import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'Profilescreen.dart';
import '../methods/AuthenticationMethods.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        elevation: 0,
        title: const Text(
          "ChileTrack",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,

        /// add icon here
        actions: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: IconButton(
              onPressed: () {
                Get.to(() => (ProfileScreen()));
              },
              icon: Icon(
                Icons.person_2_sharp,
                color: Colors.black12,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(LineAwesomeIcons.plus_square),
      ),
    );
  }
}
