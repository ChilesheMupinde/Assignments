import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignments/common_widgets/input_wiget.dart';
import 'package:assignments/constraints/image_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //gives size of device
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  image: AssetImage(welcome_image),
                ),
                const Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Create with Creately",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                //section 2
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(Icons.person_outline_outlined),
                          labelText: "email",
                          hintText: "enter email",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                            prefixIcon: const Icon(Icons.fingerprint),
                            labelText: "Password",
                            hintText: "Password",
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove_red_eye_rounded)),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      //SECTION3
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                    padding: const EdgeInsets.all(30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Select Method"),
                                        const Text(
                                            "Choose an option to reset your password"),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // forgetpasswordbutton(
                                        //   btnicon: Icons.email_outlined,
                                        //   title: "E-mail",
                                        //   subtitle: "Use e-mail verificaion",
                                        //   ontap: () {
                                        //     Get.to(
                                        //         () => (ForgetPasswordMail()));
                                        //   },
                                        // ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        forgetpasswordbutton(
                                          btnicon:
                                              Icons.mobile_friendly_outlined,
                                          title: "Mobile",
                                          subtitle:
                                              "Use Phone number Verification",
                                          ontap: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Forgot Password? "))),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("login"))),
                      const SizedBox(
                        height: 20,
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
                                  text: "Dont have an account?",
                                  children: [TextSpan(text: "Signup")]),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class forgetpasswordbutton extends StatelessWidget {
  const forgetpasswordbutton({
    required this.btnicon,
    required this.subtitle,
    required this.title,
    required this.ontap,
    super.key,
  });

  final IconData btnicon;
  final String title, subtitle;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade200),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(btnicon),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(title), Text(subtitle)],
            )
          ],
        ),
      ),
    );
  }
}
