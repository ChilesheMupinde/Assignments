import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 155), width: 2),
    ),
    //shown before youve clicked
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(222, 0, 0, 255), width: 1),
    ),
    //shown before an error is displayed
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(222, 0, 0, 155), width: 2),
    ));
