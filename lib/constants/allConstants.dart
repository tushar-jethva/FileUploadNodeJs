import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

const url = "http://192.168.174.230:3000";
void showSnackBar({required BuildContext context, required String data}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
}

loader() {
  const CircularProgressIndicator(
    backgroundColor: Colors.green,
  );
}

void httpErrorHandling({
  required http.Response res,
  required VoidCallback onSuccess,
  required BuildContext context,
}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context: context, data: jsonDecode(res.body)['msg']);
      break;
    case 500:
      showSnackBar(context: context, data: jsonDecode(res.body)['e']);
      break;

    default:
      showSnackBar(context: context, data: "Some error is occured!");
      break;
  }
}

Future<XFile?> pickImage() async {
  ImagePicker imagePicker = ImagePicker();
  XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    print("Image is ${image.path}");
    return image;
  }
}
