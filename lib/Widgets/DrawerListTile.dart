// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String name;
  final String imgpath;
  final Function ontap;

  const DrawerListTile({
    super.key,
    required this.name,
    required this.imgpath,
    required this.ontap,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap(imgpath),
      leading: Image.asset(
        "assets/$imgpath",
        height: 30,
      ),
      contentPadding: const EdgeInsets.only(
        left: 70,
        top: 5,
        bottom: 5,
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
