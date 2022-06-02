import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:school_management/Screens/Exam/constant.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var data;

  getData() async {
    var url =Constants.x+ "notification_list.php";

    http.Response response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      // print('respons  $data');
    }
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
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
                  return Center(child: CircularProgressIndicator());
                } else
                  SizedBox(
                    height: 20.0,
                  );
                return ListView.builder(
                  itemCount: (data as List).length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                "https://i.pinimg.com/originals/f0/c4/04/f0c404c8486dea5ab74ff001af848ab7.png"),
                          ),
                          title: Text(data[index]['message'])),
                    );
                  },
                );
              }),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
