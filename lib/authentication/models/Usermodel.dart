import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  final String? id;
  final String fullname;
  final String password;
  final String email;

  const Usermodel({
    this.id,
    required this.fullname,
    required this.password,
    required this.email,
  });

  toJSon() {
    return {
      "fullname": fullname,
      "password": password,
      "email": email,
    };
  }

  //map user to user model
  factory Usermodel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return Usermodel(
      id: documentSnapshot.id,
      fullname: documentSnapshot["fullname"],
      password: documentSnapshot["password"],
      email: documentSnapshot["email"],
    );
  }
}
