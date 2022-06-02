import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:school_management/Screens/home.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:http/http.dart' as http;
// import 'package:school_management/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ForgetPasseord.dart';
import 'RequestLogin.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsFlutterBinding.ensureInitialized();
    // Firebase.initializeApp();
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  // UserModel _userfromfirebase(FirebaseUser user) {
  //   return user != null ? UserModel(uid: user.uid) : null;
  //   print(user);
  // }

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool passshow = false;
  String user, pass;
  // FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Transform(
                  transform: Matrix4.translationValues(
                      animation.value * width, 0.0, 0.0),
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                            ),
                            child: Text(
                              'Online',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(40.0, 80.0, 0, 0),
                            child: Text(
                              'Classroom',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Transform(
                  transform:
                      Matrix4.translationValues(LeftCurve.value * width, 0, 0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: <Widget>[
                          Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      RegExp nameRegExp = RegExp('[a-zA-Z]');
                                      RegExp numberRegExp = RegExp(r'\d');
                                      if (value.isEmpty) {
                                        return 'You Must set your username!';
                                      } else if (nameRegExp.hasMatch(value)) {
                                        return null;
                                      } else {
                                        return 'Enter Vaild username';
                                      }
                                    },
                                    onSaved: (value) {
                                      user = value;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'EMAIL',
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
                                  SizedBox(height: 20.0),
                                  TextFormField(
                                    obscuringCharacter: '*',
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Enter Vaild password";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (val) {
                                      pass = val;
                                    },
                                    decoration: InputDecoration(
                                        suffix: passshow == false
                                            ? IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    passshow = true;
                                                  });
                                                },
                                                icon: Icon(Icons.lock_open),
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    passshow = false;
                                                  });
                                                },
                                                icon: Icon(Icons.lock),
                                              ),
                                        labelText: 'PASSWORD',
                                        contentPadding: EdgeInsets.all(5),
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.grey),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                    obscureText:
                                        passshow == false ? true : false,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Transform(
                  transform: Matrix4.translationValues(
                      delayedAnimation.value * width, 0, 0),
                  child: Container(
                    alignment: Alignment(1.0, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                      child: Bouncing(
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ForgetPassword(),
                              ));
                        },
                        child: Text(
                          "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
                child: Transform(
                  transform: Matrix4.translationValues(
                      muchDelayedAnimation.value * width, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Bouncing(
                          onPress: () {
                            // if (_formkey.currentState.validate()) {
                            //   _formkey.currentState.save();
                            /*try {
                                final FirebaseUser user =
                                    (await _auth.signInWithEmailAndPassword(
                                  email: _email,
                                  password: _pass,
                                ))
                                        .user;
                                dynamic userinfo = _auth.currentUser;
                                return _userfromfirebase(userinfo);
                              } catch (e) {
                                if (e.code == 'user-not-found') {
                                  print("user not found");
                                } else if (e.code == 'wrong-password') {
                                  print("wrong password");
                                } else {
                                  print("check internet connection!");
                                }
                              }
                            } else {
                              setState(() {
                                _autoValidate = true;
                              });
                            }*/

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (BuildContext context) => Home(),
                            //     ));
                            // }
                            ;
                          },
                          child: MaterialButton(
                            onPressed: () {},
                            child: MaterialButton(
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  print('inside fn $user  $pass');

                                  _formkey.currentState.save();
                                  Login();
                                }
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (BuildContext context) => Home(),
                                //     ));
                              },
                              elevation: 0.5,
                              minWidth: MediaQuery.of(context).size.width,
                              color: Colors.teal[900],
                              child: ListTile(
                                // leading: Icon(
                                //   Icons.fingerprint,
                                //   color: Colors.black,
                                // )
                                // ,
                                title: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            elevation: 0.5,
                            minWidth: MediaQuery.of(context).size.width,
                            color: Colors.teal[900],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Bouncing(
                          onPress: () {},
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RequestLogin(),
                                  ));
                            },
                            elevation: 0.5,
                            minWidth: MediaQuery.of(context).size.width,
                            color: Colors.grey[300],
                            child: ListTile(
                              // leading: Icon(
                              //   Icons.fingerprint,
                              //   color: Colors.black,
                              // )
                              // ,
                              title: Center(child: Text('Request Login ID')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> Login() async {
    print('inside fn $user  $pass');
    var params = {
      "username": user,
      "password": pass,
    };

    print(params);
    http.Response result =
        await http.post(Uri.parse(Constants.x + "login.php"), body: params);
    var body = result.body;

    var data = jsonDecode(body);
    print('response ${result.body}, data $data');
    if (data['status'] == "successful") {
      final spref = await SharedPreferences.getInstance();
      spref.setString('loginId', data["login_id"]);
      spref.setString('reg_no', data["reg_no"]);
      spref.setString('name', data["name"]);
      spref.setString('department', data["department"]);
      spref.setString('sem', data["sem"]);
      spref.setString('email', data["email"]);
      spref.setString('mobile', data["mobile"]);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      Fluttertoast.showToast(msg: 'login failed');
    }

    if (result.statusCode == 200) {
    } else {
      print("server not connected");
      return false;
    }
  }
}
