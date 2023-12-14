// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class SubjectCard extends StatelessWidget {
  final String subjectname;
  final String mark;
  final String link;

  // final String mark;

  const SubjectCard({
    super.key,
    required this.subjectname,
    required this.mark,
    required this.link,
  });
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 2),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 13,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: height * 0.1,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        subjectname,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // InkWell(
                    //   // onTap: () => launchUrl(Uri.parse(link)),
                    //   child: Text(
                    //     "${link}",
                    //     style: TextStyle(
                    //       fontSize: 12,
                    //     ),
                    //   ),
                    // ),
                    // Text(
                    //   "Marks:${mark}",
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 8.0),
                //   child: Text(
                //     "${date}",
                //     style: TextStyle(
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 8.0),
                //   child: Text(
                //     "${time}",
                //     style: TextStyle(
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Marks:${mark}",
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    SizedBox(width: 5),
                    // Text(
                    //   "Grade:${grade}",
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
