import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // const SplashScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Classroom Management',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
