// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:async';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Screens/LoginPage.dart';

class SpleashScreen extends StatefulWidget {
  const SpleashScreen({super.key});

  @override
  _SpleashScreenState createState() => _SpleashScreenState();
}

class _SpleashScreenState extends State<SpleashScreen> {
  @override
  void initState() {
    super.initState();
    // Firebase.initializeApp();

    Timer(const Duration(seconds: 8), start);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width * 0.35,
            child: const FlareActor(
              "assets/school spleash.flr",
              animation: "start",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  start() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const MyHomePage(title: ''),
        ),
      );
    });
  }
}
