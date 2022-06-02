import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/Widgets/AppBar.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/Widgets/LeaveApply/LeaveHistoryCard.dart';
import 'package:school_management/Widgets/LeaveApply/datepicker.dart';
import 'package:school_management/Widgets/MainDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveApply extends StatefulWidget {
  @override
  _LeaveApplyState createState() => _LeaveApplyState();
}

class _LeaveApplyState extends State<LeaveApply>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController animationController;
  final searchFieldController = TextEditingController();

  TextEditingController _applyleavecontroller;
  String _applyleavevalueChanged = '';
  String _applyleavevalueToValidate = '';
  String _applyleavevalueSaved = '';

  TextEditingController _fromcontroller;
  String _fromvalueChanged = '';
  String _fromvalueToValidate = '';
  String _fromvalueSaved = '';

  TextEditingController _tocontroller;
  String _tovalueChanged = '';
  String _tovalueToValidate = '';
  String _tovalueSaved = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);
    _applyleavecontroller =
        TextEditingController(text: DateTime.now().toString());
    _fromcontroller = TextEditingController(text: DateTime.now().toString());
    _tocontroller = TextEditingController(text: DateTime.now().toString());

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

  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  final feedback = TextEditingController();

  var data;
  getData() async {
    print('getting');
    final spref = await SharedPreferences.getInstance();
    print(spref.getString('login_id').toString());

    var url = "http://192.168.68.133/class-api/feedback.php";
    print('${feedback.text},${spref.getString('login_id')} ');
    http.Response response = await http.post(Uri.parse(url), body: {
      // 'department': spref.getString('department'),
      'login_id': spref.getString('loginId'),
      'feedback': feedback.text,
    });
    print('respp: ${response.body}');
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      // print('respons  $data');
    }
    if (jsonDecode(response.body)['msg'] == 'successfull') {
      Fluttertoast.showToast(msg: 'sent');
      Navigator.pop(context);
    }
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

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
            title: "Feedback",
            ontap: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          drawer: Drawer(
            elevation: 0,
            child: MainDrawer(),
          ),
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Divider(
                    //   color: Colors.black.withOpacity(0.5),
                    //   height: 1,
                    // ),
                    SizedBox(
                      height: height * 0.05,
                    ),

                    SizedBox(
                      height: height * 0.03,
                    ),

                    SizedBox(
                      height: height * 0.02,
                    ),

                    SizedBox(
                      height: height * 0.05,
                    ),

                    SizedBox(
                      height: height * 0.05,
                    ),
                    // Transform(
                    //   transform: Matrix4.translationValues(
                    //       muchDelayedAnimation.value * width, 0, 0),
                    //   child: Text(
                    //     "Apply Leave Date",
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 15,
                    //     ),
                    //   ),
                    // ),
                    Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation.value * width, 0, 0),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 13,
                        ),
                        child: Container(
                          // height: height * 0.06,
                          height: height * 0.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: feedback,
                            //autofocus: true,
                            minLines: 1,
                            maxLines: 10,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              suffixIcon: searchFieldController.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () => WidgetsBinding.instance
                                          .addPostFrameCallback((_) =>
                                              searchFieldController.clear()))
                                  : null,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(7),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),

                    Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation.value * width, 0, 0),
                      child: Bouncing(
                        onPress: () {
                          print(feedback.text);
                          getData();
                        },
                        child: Container(
                          //height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Send",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal[900],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          muchDelayedAnimation.value * width, 0, 0),
                      child: Divider(
                        color: Colors.black,
                        thickness: 0.9,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
