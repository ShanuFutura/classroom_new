// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Timetable extends StatefulWidget {
  const Timetable({super.key});

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  var data;

  getData() async {
    final spref = await SharedPreferences.getInstance();
    print(spref.getString('reg_no').toString());
    var url = "${Constants.x}view_timetable.php";

    http.Response response = await http.post(Uri.parse(url), body: {
      'department': spref.getString('department'),
      'sem': spref.getString('sem'),
    });
    print(response.body);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      // print('respons  $data');
    }
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
      ),
      body:
          //  ListView(
          //   children: [
          //     SizedBox(height: 20),
          //     Card(
          //       child:
          // ListTile(
          //         leading: CircleAvatar(
          //           backgroundColor: Colors.white,
          //           backgroundImage: NetworkImage(
          //               "https://i.pinimg.com/originals/f0/c4/04/f0c404c8486dea5ab74ff001af848ab7.png"),
          //         ),
          //         title:
          FutureBuilder(
              future: getData(),
              builder: (context, snap) {
                print('data: $data');
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  const SizedBox(height: 20.0);
                }
                return const Center(
                  child: Card(
                    child: SizedBox(
                      height: 250,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Forenoon',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text('Subject : forenoon_sub'),
                          SizedBox(height: 10),
                          Text('Teacher : forenoon_teacher'),
                          SizedBox(height: 10),
                          Text(
                            'Afternoon',
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(height: 20),
                          Text('Subject : afternoon_sub'),
                          SizedBox(height: 10),
                          Text('Teacher : afternoon_teacher'),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                );
              }),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
