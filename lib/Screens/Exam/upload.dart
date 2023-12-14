// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

class ImageUpload {
  static Future<bool> upload({
    File? imageFile,
    Uri? url,
    String? department,
    String? sem,
    // required String name,
    // required DateTime date,
    String? name,
  }) async {
    bool ret;

    var stream = ByteStream(DelegatingStream.typed(imageFile!.openRead()));
    var length = await imageFile.length();

    var uri = url;

    var request = MultipartRequest("POST", uri!);
    var multipartFile =
        MultipartFile('f1', stream, length, filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    // request.fields['presc_name'] = name;
    request.fields['name'] = name!;
    request.fields['department'] = department!;
    request.fields['sem'] = sem!;
    // request.fields['date'] = DateFormat('dd/MM/yyyy').format(date);

    // request.fields['crime'] = crime;
    // request.fields['entry_date'] = DateFormat('dd/MM/yyyy').format(entryDate);
    // request.fields['releasing_date'] =
    //     DateFormat('dd/MM/yyyy').format(releaseDate);
    // request.fields['age'] = age;
    // request.fields['address'] = address;
    // request.fields['cell_no'] = cellNo;
    // request.fields['gender'] = gender;
    // request.fields['section_no'] = section;
    // request.fields = {'string': 'string'};

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      print(jsonDecode(value)['message']);
    });
    if (response.statusCode == 200) {
      ret = true;
    } else {
      ret = false;
    }
    return ret;
  }
}
