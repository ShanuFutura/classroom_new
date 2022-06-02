import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// import 'constants.dart';

class Exam extends StatefulWidget {
  Exam({Key key}) : super(key: key);

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  var data;
  bool alreadyAttended = false;
  getData() async {
    final spref = await SharedPreferences.getInstance();
    print(spref.getString('reg_no').toString());

    var url = Constants.x+ "exam_view.php";

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

  sendAnswer(int index, text) async {
    http.Response result =
        await http.post(Uri.parse("${Constants.x}send_ans.php"), body: {
      'answer': text,
      'q_id': (data[index]['id']).toString(),
      'reg_no': '123',
    });
    var body = result.body;

    print("result" + result.body);
    // var data = jsonDecode(body);
  }

  getStatus() async {
    final spref = await SharedPreferences.getInstance();
    print(spref.getString('reg_no').toString());
    final res = await http.post(
        Uri.parse('${Constants.x}exam_status.php'),
        body: {'reg_no': spref.getString('reg_no')});
    print(jsonDecode(res.body));
    if ((jsonDecode(res.body))['message'] == 'attended') {
      setState(() {
        alreadyAttended = true;
      });
    }
  }

  var removeList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snap) {
          print('data: $data');
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            print('att $alreadyAttended');
            return Scaffold(
              appBar: AppBar(title: Text('Exam')),
              body: Column(
                children: [
                  Expanded(
                      flex: 9,
                      child: !alreadyAttended
                          ? ListView.builder(
                              itemCount: (data as List).length,
                              itemBuilder: (context, index) {
                                final answer = TextEditingController();
                                if (!removeList.contains(index)) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 280),
                                                child: Text(
                                                  '1. ${snap.data[0]['question']}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              'a) ${snap.data[index]['op1']}'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              'b) ${snap.data[index]['op2']}'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              'c) ${snap.data[index]['op3']}'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              'd) ${snap.data[index]['op4']}'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  TextField(
                                                    controller: answer,
                                                    decoration: InputDecoration(
                                                        suffixIcon: IconButton(
                                                          icon: Icon(Icons.send,
                                                              color:
                                                                  Colors.blue),
                                                          onPressed: () {
                                                            setState(() {});
                                                            removeList
                                                                .add(index);
                                                            print(answer.text);
                                                            sendAnswer(index,
                                                                answer.text);
                                                          },
                                                        ),
                                                        border:
                                                            OutlineInputBorder()),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          : Center(
                              child: Text(
                                "Already Attended...!",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            getStatus();
                          },
                          child: Text(
                            'Finish',
                          )),
                    ],
                  ))
                ],
              ),
            );
          }
        });
  }
}
