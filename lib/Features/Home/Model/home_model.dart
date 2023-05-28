// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HomeModel {
  final String name;
  final String mobile_no;
  final String area;
  final String city;
//my
  HomeModel({
    required this.name,
    required this.mobile_no,
    required this.area,
    required this.city,
  });

//my
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'mobile_no': mobile_no,
      'area': area,
      'city': city,
    };
  }

  //my
  String toJson() => json.encode(toMap());

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      name: map['name'] as String,
      mobile_no: map['mobile_no'] as String,
      area: map['area'] as String,
      city: map['city'] as String,
    );
  }

  factory HomeModel.fromJson(String source) => HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
