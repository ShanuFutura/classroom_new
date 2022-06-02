import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:randomizer/randomizer.dart';
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:school_management/Screens/Exam/upload.dart';

import 'package:school_management/Widgets/AppBar.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/Widgets/Exams/SubjectCard.dart';
import 'package:school_management/Widgets/MainDrawer.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ExamResult extends StatefulWidget {
  @override
  _ExamResultState createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController animationController;
  Randomizer randomcolor = Randomizer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    //SystemChrome.setEnabledSystemUIOverlays([]);

    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 0.5, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 0.5, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  var data;
  var ImageFile;
  getData() async {
    final spref = await SharedPreferences.getInstance();
    print(spref.getString('reg_no').toString());
    var url = Constants.x + "view_assignments.php";

    http.Response response = await http.post(Uri.parse(url), body: {
      'department': spref.getString('department'),
      'sem': spref.getString('sem'),
    });
    print(response.body);
    return jsonDecode(response.body);
  }

  Future<File> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    ImageFile = File(pickedFile.path);
    if (ImageFile != null) {
      final spref = await SharedPreferences.getInstance();
      ImageUpload.upload(
              sem: spref.getString('sem') ?? 'nil',
              department: spref.getString('department') ?? 'nil',
              imageFile: ImageFile,
              name: spref.getString('name') ?? 'nil',
              url: Uri.parse(
                  "http://192.168.68.133/class-api/upload_assignment.php"))
          .then((value) {
        if (value) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'File Sent');
        }
      });
    }
    return ImageFile;
  }

  var details = TextEditingController();

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          final GlobalKey<ScaffoldState> _scaffoldKey =
              new GlobalKey<ScaffoldState>();
          return Scaffold(
              key: _scaffoldKey,
              appBar: CommonAppBar(
                menuenabled: true,
                notificationenabled: false,
                title: "Classes",
                ontap: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              drawer: Drawer(
                elevation: 0,
                child: MainDrawer(),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(
                                  muchDelayedAnimation.value * width, 0, 0),
                              child: Text(
                                "Class Links",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  delayedAnimation.value * width, 0, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "date : 15/12/2020",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      // Transform(
                      //   transform: Matrix4.translationValues(
                      //       muchDelayedAnimation.value * width, 0, 0),
                      //   child: DropdownSearch<String>(
                      //     validator: (v) => v == null ? "Please Select" : null,
                      //     hint: "Please Select",
                      //     mode: Mode.MENU,
                      //     showSelectedItem: true,
                      //
                      //     items: [
                      //       "Quarterly",
                      //       "half yearly",
                      //       "First Revision",
                      //       'Second Revision',
                      //       'Third Revision',
                      //       'Annual Exam'
                      //     ],
                      //     showClearButton: false,
                      //     onChanged: (value) {},
                      //   ),
                      // ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            muchDelayedAnimation.value * width, 0, 0),
                        child: FutureBuilder(
                            future: getData(),
                            builder: (context, snap) {
                              if (snap.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else
                                print('data: ${snap.data}');
                              // SizedBox(
                              //   height: 20.0,
                              // );
                              return InkWell(
                                child: SubjectCard(
                                  subjectname:
                                      'Subject : ${snap.data[0]['subject']}(${snap.data[0]['name']})',
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(snap.data[0]['details']),
                                              IconButton(
                                                  onPressed: () {
                                                    getImage();
                                                  },
                                                  icon:
                                                      Icon(Icons.photo_camera)),
                                            ],
                                          ),
                                        );
                                      });
                                },
                              );
                            }),
                      ),

                      SizedBox(
                        height: height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Row(
                          //   children: [
                          //     Transform(
                          //       transform: Matrix4.translationValues(
                          //           muchDelayedAnimation.value * width, 0, 0),
                          //       child: Text(
                          //         "Total Marks:",
                          //         style: TextStyle(
                          //           fontSize: 15,
                          //           //fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: height * 0.03,
                          //     ),
                          //     // Transform(
                          //     //   transform: Matrix4.translationValues(
                          //     //       delayedAnimation.value * width, 0, 0),
                          //     //   child: Text(
                          //     //     "490/500",
                          //     //     style: TextStyle(
                          //     //       fontSize: 15,
                          //     //       fontWeight: FontWeight.bold,
                          //     //     ),
                          //     //   ),
                          //     // ),
                          //   ],
                          // ),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              // Transform(
                              //   transform: Matrix4.translationValues(
                              //       muchDelayedAnimation.value * width, 0, 0),
                              //   child: Text(
                              //     "Overall Grade:",
                              //     style: TextStyle(
                              //       fontSize: 15,
                              //       //fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                width: height * 0.03,
                              ),
                              // Transform(
                              //   transform: Matrix4.translationValues(
                              //       delayedAnimation.value * width, 0, 0),
                              //   child: Text(
                              //     "A +",
                              //     style: TextStyle(
                              //       fontSize: 15,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 13.0),
                        child: Row(
                          children: [
                            // Transform(
                            //   transform: Matrix4.translationValues(
                            //       muchDelayedAnimation.value * width, 0, 0),
                            //   child: Text(
                            //     "Result: ",
                            //     style: TextStyle(
                            //       fontSize: 15,
                            //       //fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              width: height * 0.03,
                            ),
                            // Transform(
                            //   transform: Matrix4.translationValues(
                            //       delayedAnimation.value * width, 0, 0),
                            //   child: Text(
                            //     "Pass",
                            //     style: TextStyle(
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(0, 18, 0, 5),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Transform(
                      //         transform: Matrix4.translationValues(
                      //             muchDelayedAnimation.value * width, 0, 0),
                      //         child: Bouncing(
                      //           onPress: () {},
                      //           child: Container(
                      //             decoration: BoxDecoration(
                      //                 color: Colors.blue,
                      //                 borderRadius: BorderRadius.circular(3),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.black26,
                      //                   ),
                      //                 ]),
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Text(
                      //                 "Save",
                      //                 style: TextStyle(
                      //                   fontSize: 15,
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Transform(
                      //         transform: Matrix4.translationValues(
                      //             delayedAnimation.value * width, 0, 0),
                      //         child: Bouncing(
                      //           onPress: () {},
                      //           child: Container(
                      //             decoration: BoxDecoration(
                      //                 color: Colors.blue,
                      //                 borderRadius: BorderRadius.circular(3),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.black26,
                      //                   ),
                      //                 ]),
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Text(
                      //                 "Share",
                      //                 style: TextStyle(
                      //                   color: Colors.white,
                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: height * 0.20,
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
