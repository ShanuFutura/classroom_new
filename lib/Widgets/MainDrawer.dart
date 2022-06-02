import 'package:flutter/material.dart';
import 'package:school_management/Screens/Attendance/Attendance.dart';
import 'package:school_management/Screens/Exam/Exam_Rseult.dart';
import 'package:school_management/Screens/Exam/profile.dart';
import 'package:school_management/Screens/Exam/timetable.dart';
import 'package:school_management/Screens/Leave_Apply/Leave_apply.dart';
import 'package:school_management/Screens/LoginPage.dart';
import 'package:school_management/Screens/home.dart';
import 'package:school_management/Screens/materials.dart';
import 'package:school_management/Widgets/meetings.dart';
import 'package:school_management/Widgets/DrawerListTile.dart';
import 'package:school_management/Widgets/Exams/internal.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Exams/teachers.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 60),
        DrawerListTile(
            imgpath: "home.png",
            name: "Home",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Home(),
                ),
              );
            }),
        // DrawerListTile(
        //   imgpath: "attendance.png",
        //   name: "Attendance",
        //   ontap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (BuildContext context) => Attendance(),
        //       ),
        //     );
        //   },
        // ),
        // DrawerListTile(
        //     imgpath: "classroom.png", name: "Class work", ontap: () {}),
        DrawerListTile(
            imgpath: "profile.png",
            name: "Profile",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Profile(),
                ),
              );
            }),
        DrawerListTile(
          imgpath: "classroom.png",
          name: "Internal Mark",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Internal(),
              ),
            );
          },
        ),
        // DrawerListTile(imgpath: "fee.png", name: "Fees", ontap: () {}),
        DrawerListTile(
            imgpath: "calendar.png",
            name: "Time Table",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Timetable(),
                ),
              );
            }),
        DrawerListTile(
            imgpath: "meet.png",
            name: "Online Class",
            ontap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Meetings(),
                  ));
            }),

        DrawerListTile(
            imgpath: "library.png",
            name: "Assignments",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ExamResult(),
                ),
              );
            }),
            DrawerListTile(
            imgpath: "book.png",
            name: "Study Materials",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Materials(),
                ),
              );
            }),
        // DrawerListTile(imgpath: "downloads.png", name: "Downloads"),
        // DrawerListTile(imgpath: "bus.png", name: "Track ", ontap: () {}),
        DrawerListTile(
          imgpath: "message.png",
          name: "Feedback",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LeaveApply(),
              ),
            );
          },
        ),
        DrawerListTile(
            imgpath: "exit.png",
            name: "Logout",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage(),
                ),
              );
            }),
        // DrawerListTile(
        //     imgpath: "notification.png", name: "Notification", ontap: () {}),
      ],
    );
  }
}
