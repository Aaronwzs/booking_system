import 'dart:ffi';

class ClassTypeModel{

  final String? id;
  final String ctName;
  final String ctDesc;
  final int ctMaxPart;
  final int ctduration;
  final Float ctprice;

  ClassTypeModel({
     this.id,
    required this.ctName,
    required this.ctDesc,
    required this.ctMaxPart,
    required this.ctduration,
    required this.ctprice,
  });

  factory ClassTypeModel.fromMap(Map<String, dynamic> map) {
    return ClassTypeModel(
      id: map['id'],
      ctName: map['ct_name'],
      ctDesc: map['ct_desc'],
      ctMaxPart: map['ct_max_part'],
      ctduration: map['ct_duration'],
      ctprice: map['ct_price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ct_name': ctName,
      'ct_desc': ctDesc, 
      'ct_max_part': ctMaxPart,
      'ct_duration': ctduration,
      'ct_price': ctprice,
    };
  }
}