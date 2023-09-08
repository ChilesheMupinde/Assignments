import 'dart:io';

import 'package:assignments/authentication/models/Expensemodel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class expensesDBhelper {
  late Database database;
  static expensesDBhelper Expensedbhelper = expensesDBhelper();
  final String tablename = "expenses";
  final String idcolumn = "id";
  final String amountcolumn = "amount";
  final String category = "category";
  final String locationcolumn = "location";
  final String datecolumn = "date";
  final String decriptioncolumn = "description";
  final String imagecolumn = "image";

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE $tablename(
      "id" INTEGER NOT NULL,
      "amount" INTEGER NOT NULL,
      "date" TIMESTAMP NOT NULL DEFAULT CURRENT TIMESTAMP
      "category" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "image" TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
      );""");
  }

  initDatabase() async {
    database = await ConnecttoDB();
  }

  Future<Database> ConnecttoDB() async {
    Directory directory = await getApplicationDocumentsDirectory();

    //gives the path to our specific database name
    String path = "$directory/expenses.db";
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute("""CREATE TABLE $tablename(
      "id" INTEGER NOT NULL,
      "amount" INTEGER NOT NULL,
      "date" TIMESTAMP NOT NULL DEFAULT CURRENT TIMESTAMP
      "category" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "image" TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
      );""");
      },
      onDowngrade: (db, oldVersion, newVersion) {
        db.delete(tablename);
      },
    );
  }

  //Fetch data
  Future<List<Expensemodel>> getexpenses() async {
    List<Map<String, dynamic>> db = await database.query(tablename);
    return db.map((e) => Expensemodel.fromsnap(e)).toList();
  }

  //insert data
  InsertNewExpense(Expensemodel expensemodel) {
    database.insert(tablename, expensemodel.toMap());
  }

  //deleting a single column
  deleteExpensecolumn(Expensemodel expensemodel) {
    database.delete(tablename, where: 'id = ?', whereArgs: [expensemodel.id]);
  }

  //delete a whole table
  deleteExpense(Expensemodel expensemodel) {
    database.delete(tablename);
  }

  //update expense
  updateExpense(Expensemodel expensemodel) {
    database.update(tablename, {
      "amount": expensemodel.amount,
      "date": expensemodel.date,
      "category": expensemodel.category,
      "description": expensemodel.description,
      "location": expensemodel.location,
      "image": expensemodel.image!.path
    });
  }
}
