// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:select_form_field/select_form_field.dart';

class RequestLogin extends StatefulWidget {
  const RequestLogin({super.key});

  @override
  _RequestLoginState createState() => _RequestLoginState();
}

class _RequestLoginState extends State<RequestLogin>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    getData();
    getSemData();
    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.8,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  late String email,
      phno,
      name,
      rollno,
      reg_no,
      roll,
      dept,
      add,
      user,
      pass,
      gua,
      sem;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // var sem = '';
  // var dept = '';
  var semList = [];
  var deptList = [];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Transform(
                  transform: Matrix4.translationValues(
                      animation.value * width, 0.0, 0.0),
                  child: const Center(
                    child: Stack(
                      children: <Widget>[
                        Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Transform(
                  transform:
                      Matrix4.translationValues(LeftCurve.value * width, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  RegExp nameRegExp = RegExp(
                                    '[a-zA-Z]',
                                  );
                                  if (value!.isEmpty) {
                                    return 'You Must enter your Name!';
                                  } else if (nameRegExp.hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter Vaild name';
                                  }
                                },
                                onSaved: (val) {
                                  name = val!;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  contentPadding: EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                validator: (value) {
                                  RegExp nameRegExp = RegExp('[0-9]');
                                  if (value!.isEmpty) {
                                    return 'You Must enter Register Number!';
                                  } else if (nameRegExp.hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter Vaild register number';
                                  }
                                },
                                onSaved: (val) {
                                  reg_no = val!;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  labelText: 'Register Number',
                                  contentPadding: EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                validator: (value) {
                                  RegExp nameRegExp = RegExp('[0-9]');
                                  if (value!.isEmpty) {
                                    return 'You Must enter Roll number!';
                                  } else if (nameRegExp.hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter Vaild rollno';
                                  }
                                },
                                onSaved: (val) {
                                  rollno = val!;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  labelText: 'Roll Number',
                                  contentPadding: EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              // TextFormField(
                              //   validator: (value) {
                              //     RegExp nameRegExp = RegExp('[a-zA-Z]');
                              //     RegExp numberRegExp = RegExp(r'\d');
                              //     if (value.isEmpty) {
                              //       return 'You Must enter your Department!';
                              //     } else if (nameRegExp.hasMatch(value)) {
                              //       return null;
                              //     } else {
                              //       return 'Enter Vaild department';
                              //     }
                              //   },
                              //   onSaved: (val) {
                              //     dept = val;
                              //   },
                              //   keyboardType: TextInputType.name,
                              //   decoration: InputDecoration(
                              //     labelText: 'Department',
                              //     contentPadding: EdgeInsets.all(5),
                              //     labelStyle: TextStyle(
                              //         fontFamily: 'Montserrat',
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 14,
                              //         color: Colors.grey),
                              //     focusedBorder: UnderlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color: Colors.green,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SelectFormField(
                                type: SelectFormFieldType.dropdown,
                                initialValue: 'department',
                                icon: const Icon(Icons.book),
                                labelText: dept,
                                items: [
                                  ...(deptList).map((element) {
                                    return {
                                      'value': element['department_id'],
                                      'label': element['dpt_name']
                                    };
                                  })
                                ],
                                onChanged: (value) {
                                  dept = value;
                                  print(dept);
                                },
                              ),
                              SelectFormField(
                                type: SelectFormFieldType.dropdown,
                                initialValue: 'sem',
                                icon: const Icon(Icons.book),
                                labelText: sem,
                                items: [
                                  ...(semList).map((element) {
                                    return {
                                      'value': element['sem_id'],
                                      'label': element['sem']
                                    };
                                  })
                                ],
                                onChanged: (value) {
                                  sem = value;
                                },
                              ),
                              const SizedBox(height: 10.0),
                              // TextFormField(
                              //   validator: (value) {
                              //     RegExp nameRegExp = RegExp('[a-zA-Z]');
                              //     RegExp numberRegExp = RegExp(r'\d');
                              //     if (value.isEmpty) {
                              //       return 'You Must enter your Semester!';
                              //     } else if (nameRegExp.hasMatch(value)) {
                              //       return null;
                              //     } else {
                              //       return 'Enter Vaild name';
                              //     }
                              //   },
                              //   onSaved: (val) {
                              //     sem = val;
                              //   },
                              //   keyboardType: TextInputType.name,
                              //   decoration: InputDecoration(
                              //     labelText: 'Semester',
                              //     contentPadding: EdgeInsets.all(5),
                              //     labelStyle: TextStyle(
                              //         fontFamily: 'Montserrat',
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 14,
                              //         color: Colors.grey),
                              //     focusedBorder: UnderlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color: Colors.green,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: 10.0),
                              TextFormField(
                                onSaved: (val) {
                                  gua = val!;
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Enter name of guardian';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Guardian',
                                  contentPadding: EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                onSaved: (val) {
                                  add = val!;
                                },
                                validator: (value) {
                                  RegExp nameRegExp = RegExp('[a-zA-Z]');
                                  if (value!.isEmpty) {
                                    return 'You Must enter this feild!';
                                  } else if (nameRegExp.hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter Vaild address';
                                  }
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Address',
                                  contentPadding: EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                validator: (value) {
                                  if ((Fzregex.hasMatch(
                                          value!, FzPattern.email) ==
                                      false)) {
                                    return "Enter your address";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  email = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: 'E-Mail',
                                  contentPadding: EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                validator: (value) {
                                  String pattern =
                                      r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                  RegExp regExp = RegExp(pattern);
                                  if (value!.isEmpty) {
                                    return 'Please enter mobile number';
                                  } else if (!regExp.hasMatch(value)) {
                                    return 'Please enter valid mobile number';
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  phno = val!;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                  contentPadding: EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(height: 10.0),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                validator: (value) {
                                  RegExp nameRegExp = RegExp('[a-zA-Z]');
                                  if (value!.isEmpty) {
                                    return 'You Must set your username!';
                                  } else if (nameRegExp.hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter Vaild username';
                                  }
                                },
                                onSaved: (val) {
                                  user = val!;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                  contentPadding: EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                validator: (value) {
                                  RegExp nameRegExp = RegExp('[a-zA-Z]');
                                  if (value!.isEmpty) {
                                    return 'You Must enter your Password!';
                                  } else if (nameRegExp.hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter Vaild password';
                                  }
                                },
                                onSaved: (val) {
                                  pass = val!;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  contentPadding: EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
                child: Transform(
                  transform: Matrix4.translationValues(
                      muchDelayedAnimation.value * width, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Bouncing(
                        onPress: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            if (sem != '' && dept != '') {
                              register().then((value) {
                                if (value) {
                                  Navigator.pop(context);
                                  print("registration successful");
                                } else {
                                  print("not registered");
                                }
                              });
                            }
                          }
                        },
                        child: MaterialButton(
                          onPressed: () {},
                          elevation: 0.0,
                          minWidth: MediaQuery.of(context).size.width,
                          color: Colors.teal[900],
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> getData() async {
    http.Response result =
        await http.post(Uri.parse("${Constants.x}view_department.php"));
    deptList = jsonDecode(result.body);
    return jsonDecode(result.body);
  }

  Future<dynamic> getSemData() async {
    http.Response result =
        await http.post(Uri.parse("${Constants.x}view_sem.php"));
    semList = jsonDecode(result.body);

    print(jsonDecode(result.body));
    return jsonDecode(result.body);
  }

  Future<bool> register() async {
    var params = {
      "name": name,
      "email": email,
      "mobile": phno,
      "department": dept,
      "sem": sem,
      "reg_no": reg_no,
      "roll_no": rollno,
      "gardian": gua,
      "address": add,
      "username": user,
      "password": pass,
    };
    print(params);
    http.Response result = await http
        .post(Uri.parse("${Constants.x}registration.php"), body: params);
    if (result.statusCode == 200) {
      var data = jsonDecode(result.body);
      if (data['status'] == "registration successful") {
        return true;
      } else {
        return false;
      }
    } else {
      print("server not connected");
      return false;
    }
  }
}
