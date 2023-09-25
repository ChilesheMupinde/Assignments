import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets/input_wiget.dart';
import '../../constraints/image_strings.dart';
import 'package:assignments/authentication/controllers/SIgnupController.dart';
import 'package:assignments/authentication/models/Usermodel.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUPController());
    final _formkey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage(welcome_image),
              ),
              const Text(
                "ChileTrack",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Track Your Finances",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              //section 2
              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //fullname
                    TextFormField(
                      controller: controller.fullname,
                      decoration: textInputDecoration.copyWith(
                        prefixIcon: const Icon(Icons.person_outline_outlined),
                        labelText: "Fullname",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //email
                    TextFormField(
                        controller: controller.email,
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(Icons.email_outlined),
                          labelText: "email",
                          hintText: "enter email",
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.numbers_outlined)),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    //password
                    TextFormField(
                        controller: controller.password,
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(Icons.fingerprint),
                          labelText: "Password",
                          hintText: "enter password",
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove_red_eye_rounded)),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    //SECTION 3
                    //
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                final user = Usermodel(
                                  email: controller.email.text.trim(),
                                  password: controller.password.text.trim(),
                                  fullname: controller.fullname.text.trim(),
                                );
                                SignUPController.Instance.createUser(user);
                              }
                            },
                            child: const Text("Signup"))),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(child: Text("OR")),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                          icon: const Image(
                            image: AssetImage(google_logo),
                            width: 30,
                          ),
                          onPressed: () {},
                          label: const Text("Sign-in with Google")),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {},
                          child: const Text.rich(
                            TextSpan(
                                text: "Already have an account?",
                                children: [TextSpan(text: "Login")]),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
