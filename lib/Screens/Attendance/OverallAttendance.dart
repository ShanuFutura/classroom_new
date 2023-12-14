// ignore_for_file: library_private_types_in_public_api, file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:school_management/Widgets/Attendance/OverAllAttendanceCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OverallAttendance extends StatefulWidget {
  const OverallAttendance({super.key});

  @override
  _OverallAttendanceState createState() => _OverallAttendanceState();
}

class _OverallAttendanceState extends State<OverallAttendance> {
  var data;
  var reg_no;
  var date;
  getData() async {
    final spref = await SharedPreferences.getInstance();
    print(spref.getString('reg_no').toString());

    var url = "${Constants.x}attendance_history.php";
    final response = await post(Uri.parse(url), body: {
      'reg_no': spref.getString('reg_no'),
      // 'reg_no': reg_no,
    });
    print(response.body);
    // http.Response response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      // print('respons  $data');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getData(),
          builder: (context, snap) {
            print('data: $data');
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: (data as List).length,
                  itemBuilder: (context, index) {
                    return OverallAttendanceCard(
                      date: data[index]['date'],
                      present:
                          data[index]['status'] == 'present' ? true : false,
                    );
                  });
            }
          }),
    );
  }
}
