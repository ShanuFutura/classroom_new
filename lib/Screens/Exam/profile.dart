import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:randomizer/randomizer.dart';
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:school_management/Screens/Exam/update_profile.dart';

import 'package:school_management/Widgets/AppBar.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/Widgets/Exams/SubjectCard.dart';
import 'package:school_management/Widgets/MainDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController animationController;
  Randomizer randomcolor = Randomizer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  getData() async {
    final spref = await SharedPreferences.getInstance();
    print(spref.getString('reg_no').toString());
    var url = Constants.x + "view_student.php";
    final response = await post(Uri.parse(url), body: {
      'reg': spref.getString('reg_no'),
      // 'reg_no': reg_no,
    });
    spref.setString('department_id', jsonDecode(response.body)['department']);
    print(response.body);
    return jsonDecode(response.body);
  }

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
            appBar: AppBar(
              title: Text('Profile'),
              backgroundColor: Color.fromARGB(255, 108, 147, 237),
              centerTitle: true,
            ), //AppBar
            body: Center(
              /** Card Widget **/
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return Card(
                        elevation: 50,
                        shadowColor: Colors.black,
                        color: Color.fromARGB(255, 220, 231, 252),
                        child: SizedBox(
                          width: 300,
                          height: 500,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Card(
                                  child: ListTile(
                                    title: Text('Register No :'),
                                    trailing: Text(snap.data['reg_no']),
                                  ),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(' Name :'),
                                  trailing: Text(snap.data['name']),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(' Email :'),
                                  trailing: Text(snap.data['email']),
                                ),
                                Divider(),
                                // ListTile(
                                //   title: Text('Department :'),
                                //   trailing: Text(snap.data['department']),
                                // ),
                                // Divider(),
                                ListTile(
                                  title: Text('Mobile No :'),
                                  trailing: Text(snap.data['mobile']),
                                ),
                                Divider(),
                                SizedBox(height: 40),
                                FloatingActionButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Update();
                                    }));
                                  },
                                  child: Icon(Icons.edit),
                                )
                              ],
                            ), //Column
                          ), //Padding
                        ), //SizedBox
                      );
                    }
                  }), //Card
            ), //Center
          );
        });
  }
}
