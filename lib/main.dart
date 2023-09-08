import 'package:assignments/authentication/Providers/ExpenseProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:assignments/authentication/methods/AuthenticationMethods.dart';
import 'package:assignments/authentication/controllers/SIgnupController.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

//function required for firebase
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthMethods()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var mailcontroller = Get.put(SignUPController());
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 600),
        home: CircularProgressIndicator()
        //
        //const CircularProgressIndicator(
        //   color: Colors.red,

        // ),
        );
  }
}
