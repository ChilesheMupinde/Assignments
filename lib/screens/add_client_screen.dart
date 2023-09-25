import 'dart:developer';
import 'dart:io';
import 'dart:ui' as size;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddClientScreen extends StatefulWidget {
  final int? index;

  const AddClientScreen({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? selctedItem;
  final _box = Hive.box("Expenses_hive_box");
  final formkey = GlobalKey<FormState>();
  String? _currentAddress;
  Position? _currentPosition;

  DateTime selectedDate = DateTime.now();
  int selectedIndex = 0;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  final List<String> _categories = [
    'food',
    "Transfer",
    "Transportation",
    "Education",
    "bank"
  ];

//Funtions
//function for selecting date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

// function responsible for adding a client
  Future _addClient(Map<String, dynamic> newClient) async {
    await _box.add(newClient);

    log('Client Added' '${_box.values.toString()}');
  }

  Future _updateClient(Map<String, dynamic> items) async {
    await _box.putAt(widget.index!, items);
    log('Client Updated');
  }

  Future? _getClient() async {
    if (widget.index != null) {
      setState(() {
        _amountController.text = _box.getAt(widget.index!)['amount'].toString();
        _box.getAt(widget.index!)['image'] != null
            ? _image = XFile(_box.getAt(widget.index!)['image'])
            : null;
        selctedItem = _box.getAt(widget.index!)['Category'];

        selectedDate = _box.getAt(widget.index!)['date'];
        _currentAddress = _box.getAt(widget.index!)['location'];
      });
    }
    return null;
  }

  Future getCametaImage() async {
    _image = await _picker.pickImage(source: ImageSource.camera);
    if (_image != null) {
      setState(() {
        _image;
      });
    }
  }

  Future getGalleryImage() async {
    _image = await _picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {
        _image;
      });
    }
  }

  @override
  void initState() {
    log('initState');
    _getClient();
    _getCurrentPosition();
    super.initState();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      if (mounted) {
        super.setState(() => _currentPosition = position);
      }
      _getAddressFromLatLng(_currentPosition!);
      print(_currentPosition);
    }).catchError((e) {
      log('error $e');
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = ' ${place.locality},${place.country}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index == null ? "Add Expense" : "Edit Expense"),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actionsPadding:
                            const EdgeInsets.symmetric(vertical: 30),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          FloatingActionButton(
                            onPressed: () {
                              getCametaImage();
                              Navigator.pop(context);
                              // context.pop();
                            },
                            child: const Icon(Icons.camera_alt),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              getGalleryImage();
                              Navigator.pop(context);
                              // context.pop();
                            },
                            child: const Icon(Icons.photo_library),
                          )
                        ],
                      ),
                    ),

                    child: CircleAvatar(
                        // radius: 35,
                        minRadius: 30,
                        maxRadius: 36,
                        // backgroundColor: Colors.transparent,
                        backgroundImage: _image != null
                            ? FileImage(File(_image!.path))
                            : null,
                        child: _image == null
                            ? const Icon(
                                Icons.add_a_photo_outlined,
                                size: 30,
                              )
                            : null),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Row(
                //   children: [
                //     customRadio(AppText.cashInText, 0),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     customRadio(AppText.cashOutText, 1),
                //   ],
                // ),
                // Categories
                DropdownButton<String>(
                  value: selctedItem,
                  onChanged: ((value) {
                    setState(() {
                      selctedItem = value!;
                    });
                  }),
                  items: _categories
                      .map((e) => DropdownMenuItem(
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    child:
                                        Image.asset('assets/images/${e}.png'),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    e,
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            value: e,
                          ))
                      .toList(),
                  selectedItemBuilder: (BuildContext context) => _categories
                      .map((e) => Row(
                            children: [
                              Container(
                                width: 42,
                                child: Image.asset('assets/images/${e}.png'),
                              ),
                              SizedBox(width: 5),
                              Text(e)
                            ],
                          ))
                      .toList(),
                  hint: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'Category',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  underline: Container(),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Amount",
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Amount";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                    prefix: Text("K"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  maxLines: 2,
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //SETS THE DATE
                ElevatedButton.icon(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.calendar_month, color: Colors.blue),
                  label: Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black, primary: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const size.Size(double.infinity, 50)),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        if (widget.index == null) {
                          _getCurrentPosition();

                          _addClient({
                            "key": _box.values.length,
                            "amount": _amountController.text,
                            "date": selectedDate,
                            "description": _descriptionController.text,
                            "Category": selctedItem,
                            'image': _image?.path,
                            'location': _currentAddress
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Expense Added"),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          _updateClient({
                            "key": widget.index!,
                            "amount": _amountController.text,
                            "date": selectedDate,
                            "description": _descriptionController.text,
                            "Category": selctedItem,
                            'image': _image?.path,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Succesfully edited"),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: widget.index == null
                        ? const Text("Add Expense")
                        : const Text("Edit Expense")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // Widget customRadio(String text, int index) {
  //   return OutlinedButton(
  //     onPressed: () => changeIndex(index),
  //     style: OutlinedButton.styleFrom(
  //       primary: selectedIndex == index
  //           ? AppColors.whiteColor
  //           : AppColors.blackColor,
  //       backgroundColor: selectedIndex == index
  //           ? AppColors.primaryColor
  //           : AppColors.whiteColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),
  //     child: Text(text),
  //   );
  // }
}
