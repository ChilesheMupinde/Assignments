import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var darkmode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.montserrat(fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon:
                  Icon(darkmode ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(borderRadius: BorderRadius.circular(70)),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 28,
                    child: Icon(
                      LineAwesomeIcons.alternate_pencil,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text("name"),
            const SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () {
            //     Get.to(() => updateProfileScreen());
            //   },
            //   style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.blue, side: BorderSide.none),
            //   child: Text("Edit Profile"),
            // ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            ProfileMenuWidget(
                Title: Text("Settings"),
                nIcon: LineAwesomeIcons.cog,
                onpress: () {},
                endicon: true),
            ProfileMenuWidget(
                Title: Text("Financial Details"),
                nIcon: LineAwesomeIcons.wallet,
                onpress: () {},
                endicon: true),
            ProfileMenuWidget(
                Title: Text("Profile Management"),
                nIcon: LineAwesomeIcons.cog,
                onpress: () {},
                endicon: true),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            ProfileMenuWidget(
              Title: Text("Info"),
              nIcon: LineAwesomeIcons.cog,
              onpress: () {},
              endicon: true,
            ),
            ProfileMenuWidget(
                Title: Text("Log out"),
                nIcon: LineAwesomeIcons.cog,
                onpress: () {},
                endicon: false),
          ]),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.Title,
      required this.nIcon,
      required this.onpress,
      required this.endicon});
  final Text Title;
  final IconData nIcon;
  final VoidCallback onpress;
  final bool endicon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue.withOpacity(0.1)),
        child: IconButton(
          onPressed: onpress,
          icon: Icon(nIcon),
          color: Colors.blue,
        ),
      ),
      title: Title,
      trailing: endicon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: IconButton(
                onPressed: onpress,
                icon: Icon(LineAwesomeIcons.angle_right),
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
