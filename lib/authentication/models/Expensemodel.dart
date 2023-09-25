import 'package:assignments/authentication/models/model.dart';

class ExpenseModel extends Model {
  static String table = "expenses";

  int? id;
  double amount;
  String date;
  int? categoryId;
  String? description;
  String? location;

  String? Picture;

  ExpenseModel(
      {this.id,
      required this.date,
      required this.categoryId,
      this.description,
      required this.amount,
      this.Picture,
      this.location});

  factory ExpenseModel.fromMap(Map<String, dynamic> json) => ExpenseModel(
        id: json['id'],
        amount: json['amount'],
        date: json['date'],
        categoryId: json['categoryId'],
        description: json['description'].toString(),
        location: json["location"],
        Picture: json['Picture'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'amount': amount,
      'date': DateTime.now().toString(),
      'categoryId': categoryId,
      'description': description,
      'location': location,
      'Picture': Picture
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}

// class CategoryModel extends Model {
//   static String table = 'product_categories';

//   String categoryName;
//   int categoryId;

//   CategoryModel({
//     required this.categoryId,
//     required this.categoryName,
//   });

//   static CategoryModel fromMap(Map<String, dynamic> map) {
//     return CategoryModel(
//       categoryId: map["id"],
//       categoryName: map['categoryName'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> map = {
//       'categoryName': categoryName,
//     };

//     if (id != null) {
//       map['id'] = id;
//     }
//     return map;
//   }
// }
