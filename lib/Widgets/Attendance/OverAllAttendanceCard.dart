// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class OverallAttendanceCard extends StatefulWidget {
  final String date;
  final bool present;

  const OverallAttendanceCard(
      {super.key, required this.date, required this.present});

  @override
  _OverallAttendanceCardState createState() => _OverallAttendanceCardState();
}

class _OverallAttendanceCardState extends State<OverallAttendanceCard>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

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
          0.6,
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

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Transform(
            transform:
                Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white70,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 3),
                    //blurRadius: 3,
                    //spreadRadius: 1,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.date,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.present ? Colors.green : Colors.red,
                    ),
                    child: Center(
                      child: widget.present == true
                          ? const Text(
                              "P",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )
                          : const Text(
                              "A",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
