// ignore_for_file: avoid_print

import 'dart:convert';
// import 'dart:html' as htm;
import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:school_management/Screens/image_view.dart';
// import 'package:pet_spotter/utils/constant.dart';

class Materials extends StatelessWidget {
  const Materials({super.key});

  // const DoctorsView({Key? key}) : super(key: key);

  Future<dynamic> getData() async {
    final res = await http.post(
      Uri.parse('${Constants.x}view_material.php'),
    );
    print(res.body);
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text('Online Classes'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.data == null) {
              return const Center(
                child: Text('No data'),
              );
            } else {
              return ListView.builder(
                  itemCount: (snap.data as List).length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          // launchUrl(Uri.parse(
                          //     '${(snap.data as dynamic)[index]['file_path']}'));
                          // FlutterDownloader.enqueue(
                          //     url: (snap.data as dynamic)[index]['file_path'],
                          //     savedDir: '/storage/emulated/0/Download/');
                          // PDFView(
                          //   filePath: (snap.data as dynamic)[index]
                          //       ['file_path'],
                          // );
                          // ht.window.open(
                          //     (snap.data as dynamic)[index]['file_path'],
                          //     'name');

                          Navigator.push(context,
                              MaterialPageRoute(builder: (conext) {
                            return ImageViewScreen(
                                (snap.data as dynamic)[index]['file_path']);
                          }));
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (conext) {
                          //   return PDFViewPage(
                          //       path: (snap.data as dynamic)[index]
                          //           ['file_path']);
                          // }));
                          // html.window.open(
                          //     '${(snap.data as dynamic)[index]['file_path']}',
                          //     'name');
                          print(
                              'file path :- ${(snap.data as dynamic)[index]['file_path']}');
                          // launchUrl(Uri.parse(
                          //     'https://docs.google.com/gview?embedded=true&url=${(snap.data as dynamic)[index]['file_path']}'));
                        },
                        leading: const Icon(Icons.description),
                        title: Text(
                          (snap.data as dynamic)[index]['heading'],
                        ),
                        subtitle: Text(
                          (snap.data as dynamic)[index]['file'],
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
