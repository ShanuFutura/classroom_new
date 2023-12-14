// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:school_management/Screens/Exam/Exam_Rseult.dart';
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:school_management/Screens/Exam/notification.dart';
import 'package:school_management/Screens/Exam/timetable.dart';
import 'package:school_management/Widgets/AppBar.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/Widgets/DashboardCards.dart';
import 'package:school_management/Widgets/MainDrawer.dart';
import 'package:school_management/Widgets/UserDetailCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Attendance/Attendance.dart';
import 'Exam/exam.dart';
import 'Exam/profile.dart';
// import 'Leave_Apply/Leave_apply.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;
  late String loginId;
  late String name;
  late String department;
  late String sem;
  @override
  void initState() {
    getString("loginId").then((value) {
      loginId = value;
      print(value);
    });
    getString("name").then((value) {
      name = value;
      print(value);
    });
    getString("sem").then((value) {
      name = value;
      print(value);
    });
    getString("department").then((value) {
      name = value;
      print(value);
    });
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  setDeptId() async {
    final spref = await SharedPreferences.getInstance();
    print(spref.getString('reg_no').toString());
    var url = "${Constants.x}view_student.php";
    final response = await post(Uri.parse(url), body: {
      'reg': spref.getString('reg_no'),
      // 'reg_no': reg_no,
    });
    spref.setString('department_id', jsonDecode(response.body)['department']);
  }

  @override
  Widget build(BuildContext context) {
    setDeptId();
    final double width = MediaQuery.of(context).size.width;

    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        final GlobalKey<ScaffoldState> scaffoldKey =
            // ignore: unnecessary_new
            new GlobalKey<ScaffoldState>();
        return Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            elevation: 0,
            child: MainDrawer(),
          ),
          appBar: CommonAppBar(
            menuenabled: true,
            notificationenabled: true,
            ontap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            title: "Dashboard",
          ),
          body: ListView(
            children: [
              UserDetailCard(),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: const Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Attendance(),
                                  ));
                            },
                            child: DashboardCard(
                              name: "Attendance",
                              imgpath: "attendance.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Profile(),
                                  ));
                            },
                            child: DashboardCard(
                              name: "Profile",
                              imgpath: "profile.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: const Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Exam(),
                                ),
                              );
                            },
                            child: DashboardCard(
                              name: "OnlineExam",
                              imgpath: "exam.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Timetable(),
                                ),
                              );
                            },
                            child: DashboardCard(
                              name: "TimeTable",
                              imgpath: "calendar.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: const Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ExamResult(),
                                  ));
                            },
                            child: DashboardCard(
                              name: "Assignment",
                              imgpath: "library.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Notifications(),
                                ),
                              );
                            },
                            child: DashboardCard(
                              name: "Notification",
                              imgpath: "notification.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: const Alignment(1.0, 0),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Transform(
                        //   transform: Matrix4.translationValues(
                        //       muchDelayedAnimation.value * width, 0, 0),
                        //   child: Bouncing(
                        //     onPress: () {},
                        //     child: DashboardCard(
                        //       name: "Notification",
                        //       imgpath: "notification.png",
                        //     ),
                        //   ),
                        // ),
                        // Transform(
                        //   transform: Matrix4.translationValues(
                        //       delayedAnimation.value * width, 0, 0),
                        //   child: Bouncing(
                        //     onPress: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (BuildContext context) =>
                        //                 LeaveApply(),
                        //           ));
                        //     },
                        //     child: DashboardCard(
                        //       name: "Feedback",
                        //       imgpath: "leave_apply.png",
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // saveString(String key, String value) async {
  //   final pref = await SharedPreferences.getInstance();
  //   await pref.setString(key, value);
  //   return true;
  // }

  Future<String> getString(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? "";
  }
}
