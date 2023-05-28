import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_upload_practice/Features/Home/Model/home_model.dart';
import 'package:file_upload_practice/Features/Home/services/home_services.dart';
import 'package:file_upload_practice/constants/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  XFile? image;
  List<XFile>? images;

  //upload single
  Future<String> uploadSingle(XFile file) async {
    var uri = Uri.parse('$url/upload');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(
      await http.MultipartFile.fromPath('uploadFile', file.path),
    );
    var response = await request.send();

    String msgRes = await response.stream.bytesToString();
    var map = jsonDecode(msgRes);
    return map['msg'];
  }

  //uploadMulti
  Future<String> uploadMutli(List<XFile> list, String name) async {
    Uri uri = Uri.parse('$url/uploadMulti');
    var request = http.MultipartRequest('POST', uri);
    for (var i = 0; i < list.length; i++) {
      request.files
          .add(await http.MultipartFile.fromPath('uploadFile', list[i].path));
    }
    request.fields['name'] = name;
    var response = await request.send();
    log(response.toString());
    return response.stream.bytesToString();
  }

  void pickImage1() async {
    image = await pickImage();
    setState(() {});
  }

  void pickImageMulti() async {
    images = await ImagePicker().pickMultiImage(imageQuality: 20);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                pickImageMulti();
              },
              child: Text("pickImage"),
            ),
            image == null
                ? SizedBox.shrink()
                : Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.file(
                      File(image!.path),
                    ),
                  ),
            ElevatedButton(
                onPressed: () {
                  uploadMutli(images!, "Tushasr");
                },
                child: Text("Upload"))
          ],
        ),
      ),
    );
  }
}
