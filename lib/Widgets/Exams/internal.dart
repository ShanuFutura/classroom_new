import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Internal extends StatelessWidget {
  Internal({Key key}) : super(key: key);

  var data;
  var total_internal;
  getData() async {
    final spref = await SharedPreferences.getInstance();
    print(spref.getString('reg_no').toString());
    var url = Constants.x + "avg.php";

    http.Response response = await http.post(Uri.parse(url), body: {
      'reg_no': spref.getString('reg_no'),
    });
    final totalMark = jsonDecode(response.body)['total_internal'];
    // print('temp res=$tempRes');
    print('totalmark $totalMark');
    http.post(Uri.parse(Constants.x + 'view_internal.php'), body: {
      'reg_no': spref.getString('reg_no'),
      'mark': totalMark.toString(),
    }).then((value) => print('sent back${value.body}'));
    print(response.body);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      // print('respons  $data');
    }
    return jsonDecode(response.body);
  }

  sendBackTotalInternal(String reg, String mark) {
    print('reg:$reg mark$mark');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snap) {
            print('data: $data');
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Card(
                  child: Container(
                    height: double.infinity,
                    width: 550,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Mark average: ${data['mark_average']}%',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Attendace average: ${data['attandance_average']}%',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            'Assignment: ${data['assignment']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'InternalMark',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${data['total_internal']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              );
            }
          }),
    );
  }
}
