// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:school_management/Screens/Exam/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);

    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.5,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.3,
          0.5,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  getData() async {
    final spref = await SharedPreferences.getInstance();
    print(spref.getString('reg_no').toString());
    var url = "${Constants.x}view_student.php";
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
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              backgroundColor: const Color.fromARGB(255, 108, 147, 237),
              centerTitle: true,
            ), //AppBar
            body: Center(
              /** Card Widget **/
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return Card(
                        elevation: 50,
                        shadowColor: Colors.black,
                        color: const Color.fromARGB(255, 220, 231, 252),
                        child: SizedBox(
                          width: 300,
                          height: 500,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const Card(
                                  child: ListTile(
                                    title: Text('Register No :'),
                                    trailing: Text('snap.data[reg_no]'),
                                  ),
                                ),
                                const Divider(),
                                const ListTile(
                                  title: Text(' Name :'),
                                  trailing: Text('name'),
                                ),
                                const Divider(),
                                const ListTile(
                                  title: Text(' Email :'),
                                  trailing: Text('email'),
                                ),
                                const Divider(),
                                // ListTile(
                                //   title: Text('Department :'),
                                //   trailing: Text(snap.data['department']),
                                // ),
                                // Divider(),
                                const ListTile(
                                  title: Text('Mobile No :'),
                                  trailing: Text('mobile'),
                                ),
                                const Divider(),
                                const SizedBox(height: 40),
                                FloatingActionButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return Update();
                                      }),
                                    );
                                  },
                                  child: const Icon(Icons.edit),
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
