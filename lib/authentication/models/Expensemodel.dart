import 'dart:io';

import 'package:get/get_connect/http/src/_http/_io/_file_decoder_io.dart';

class Expensemodel {
  int? id;
  late int amount;
  DateTime date;
  File? image;
  late String category;
  late String description;
  late String location;

  Expensemodel(
      {this.id,
      required this.amount,
      required this.date,
      this.image,
      required this.category,
      required this.description,
      required this.location});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
      "category": category,
      "description": description,
      "location": location,
      "date": DateTime.now().toString(),
      "locarion": location,
      'image': image == null ? '' : image!.path
    };
  }

  factory Expensemodel.fromsnap(Map<String, dynamic> map) {
    return Expensemodel(
        id: map['id'],
        amount: map['amount'],
        date: map['date'],
        category: map['category'],
        description: map['description'],
        location: map['location'],
        image: map['image'] != null ? File(map['image']) : null);
  }
}
