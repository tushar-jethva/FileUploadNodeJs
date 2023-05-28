import 'dart:convert';

import 'package:file_upload_practice/Features/Home/Model/home_model.dart';
import 'package:file_upload_practice/constants/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<HomeModel>> getAllUsers({
    required BuildContext context,
  }) async {
    List<HomeModel> list = [];
    try {
      http.Response res = await http.get(Uri.parse('$url/api/getAll'),
          headers: <String, String>{
            'Content-Type': 'application/json charset=UTF-8'
          });
      //print(res.body);
      // ignore: use_build_context_synchronously
      httpErrorHandling(
          res: res,
          onSuccess: () {
            List<dynamic> lists = jsonDecode(res.body);
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              // var obj = lists[i] as Map<String,dynamic>;
              // list.add(HomeModel.fromMap(obj));
              list.add(HomeModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
            print("List is $list");
          },
          context: context);
    } catch (e) {
      showSnackBar(context: context, data: e.toString());
    }
    return list;
  }
}
