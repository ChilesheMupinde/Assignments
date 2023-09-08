import 'dart:io';

import 'package:assignments/authentication/Expenses.dart';
import 'package:assignments/authentication/models/Expensemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

TextEditingController amount = TextEditingController();
TextEditingController description = TextEditingController();
File? image;

List<Expensemodel> allexpenses = [];
