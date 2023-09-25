import 'dart:developer';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'dart:io';
import 'package:assignments/screens/add_client_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _box = Hive.box("Expenses_hive_box");
  List _items = [];
  int totalAmount = 0;
  int totalIn = 0;
  int totalOut = 0;

  ScrollController? _scrollController;
//function used to retrieve items
  Future _getAllDate() async {
    log('_getAllDate');
    _items = _box.keys.map((e) => _box.get(e)).toList();
    setState(() {
      _items = _items;
    });

    totalAmount = totalIn = totalOut = 0;
    for (var item in _items) {
      totalIn = totalIn + int.parse(item['amount']);

      totalAmount = totalIn;
    }

    // log(_box.keys.toString());
    // log(_items.toString());
    // log(_items.length.toString());
  }

  Future _deleteData(int key) async {
    _box.deleteAt(key);
    _getAllDate();
  }

  @override
  void initState() {
    log('DashBoardScreen initState');
    _getAllDate();
    super.initState();
  }

  @override
  void dispose() {
    log('DashBoardScreen dispose');
    _box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(title: const Text('Chilexpense')),
      body: _items.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Amount",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                totalAmount.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: totalAmount > 0
                                      ? Colors.green
                                      : totalAmount < 0
                                          ? Colors.red
                                          : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Divider(thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Total In",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    totalIn.toString(),
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListView.builder(
                    primary: _scrollController == null,
                    shrinkWrap: true,
                    controller: _scrollController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      var date = DateFormat('dd/MM/yyyy')
                          .format(_items[index]['date']);
                      return StickyHeader(
                        controller: _scrollController,
                        header: index >= 1
                            ? DateFormat('dd/MM/yyyy')
                                        .format(_items[index]['date']) !=
                                    DateFormat('dd/MM/yyyy')
                                        .format(_items[index - 1]['date'])
                                ? Container(
                                    height: 30.0,
                                    color: Colors.white60,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      date,
                                      style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Container()
                            : Container(
                                height: 30.0,
                                color: Colors.white60,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  date,
                                  style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),

                        // our actual widget
                        content: Dismissible(
                          key: ValueKey(_items[index]),
                          background: Container(
                            color: Colors.red,
                            child: Icon(LineAwesomeIcons.remove_user),
                          ),
                          onDismissed: (DismissDirection direction) =>
                              showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                  "Are You Sure You Want To Delete?"),
                              actions: [
                                TextButton(
                                  child: const Text("Yes"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _deleteData(index);
                                  },
                                ),
                                TextButton(
                                  child: const Text("No"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            elevation: 0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 8),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        _items[index]['image'] != null
                                            ? FileImage(
                                                File(_items[index]['image']))
                                            : null,
                                    child: _items[index]['image'] != null
                                        ? null
                                        : const Icon(
                                            Icons.attach_money_rounded),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _items[index]['Category'] != "" &&
                                                _items[index]['Category'] !=
                                                    null
                                            ? Text(
                                                _items[index]['Category'],
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(""),
                                        const SizedBox(height: 5),
                                        _items[index]['location'] != "" &&
                                                _items[index]['location'] !=
                                                    null
                                            ? Text(
                                                _items[index]['location'],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              )
                                            : Text(""),

                                        const SizedBox(height: 5),

                                        Text(
                                          _items[index]['amount'].toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.green),
                                        ),
                                        // Text(
                                        //   date,
                                        //   // _items[index]['date'].toString(),
                                        //   style: const TextStyle(fontSize: 14, color: AppColors.greyColor),
                                        // ),
                                        const SizedBox(height: 5),
                                        _items[index]['description'] != "" &&
                                                _items[index]['description'] !=
                                                    null
                                            ? Text(
                                                _items[index]['description'],
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      constraints: const BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      icon: const Icon(Icons.edit,
                                          color: Colors.grey),
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddClientScreen(index: index),
                                        ),
                                      ).then((value) => _getAllDate()),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : Center(child: Text("No expenses Yet")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddClientScreen());
        },
        child: Icon(LineAwesomeIcons.plus),
      ),
    );
  }
}

  // _fetchData() {
  //   FutureBuilder<List<ExpenseModel>>(
  //       future: dbService.getProducts(),
  //       builder:
  //           (BuildContext context, AsyncSnapshot<List<ExpenseModel>> expenses) {
  //         if (expenses.hasData) {
  //           return _buildExpenseList(expenses.data!);
  //         }

  //         return Center(
  //           child: CircularProgressIndicator(color: Colors.amber),
  //         );
  //       });
  // }



//      future: DB.getExpenses(),
//      builder:
//           (BuildContext context, AsyncSnapshot<List<ExpenseModel>?> expenses) {
//        if (expenses.connectionState == ConnectionState.waiting) {
//          return CircularProgressIndicator();
//        }else if(expenses.hasError){
//          return Center(child: Text(expenses.error.toString()),);
//        }else if(expenses.hasData){
//          if(expenses.data != null){
//
//          }
//        }
//

// () => showDialog(
// context: context,
// builder: (context) => AlertDialog(
// title: const Text("Are You Sure You Want To Delete?"),
// actions: [
// TextButton(
// child: const Text("Yes"),
// onPressed: () {
// Navigator.pop(context);
// _deleteData(index);
// },
// ),
// TextButton(
// child: const Text("No"),
// onPressed: () => Navigator.pop(context),
// ),
// ],
// ),),
//      }),
