import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:http/http.dart' as http;
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:pet_spotter/utils/constant.dart';

class Materials extends StatelessWidget {
  // const DoctorsView({Key? key}) : super(key: key);

  Future<dynamic> getData() async {
    final spref = await SharedPreferences.getInstance();
    final res = await http.post(
      Uri.parse(Constants.x + 'view_material.php'),
    );
    print(res.body);
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text('Online Classes'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snap.data == null) {
              return Center(
                child: Text('No data'),
              );
            } else {
              return ListView.builder(
                  itemCount: (snap.data as List).length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          // FlutterDownloader.enqueue(
                          //     url: (snap.data as dynamic)[index]['file_path'],
                          //     savedDir: '/storage/emulated/0/Download/');
                          // PDFView(
                          //   filePath: (snap.data as dynamic)[index]
                          //       ['file_path'],
                          // );
                          // launchUrl(Uri.parse(
                          //     '${(snap.data as dynamic)[index]['file_path']}'));
                        },
                        leading: Image.asset('assets/meet.png'),
                        title: Text((snap.data as dynamic)[index]['heading']),
                        subtitle: Text(
                          (snap.data as dynamic)[index]['file'],
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
