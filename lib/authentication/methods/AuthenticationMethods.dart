import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:assignments/screens/Homescreen.dart';
import 'package:assignments/screens/loginscreen.dart';
import 'package:assignments/screens/signupscreen.dart';
import '../exceptions.dart';


class AuthMethods extends GetxController {
  static AuthMethods get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  //our application's user
  late final Rx<User?> firebaseUser;

  var verificationId = ''.obs;
  @override
  //called when the app starts
  void onReady() {
    Future(() => const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    //detects changes in profile
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

//detects whether a user is logged in
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const Signupscreen())
        : Get.offAll(() => const Home());
  }

  Future<void> createuserwithemailandpassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const Home())
          : Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION- ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION- ${ex.message}');
      throw ex;
    }
  }

  Future<void> Loginwithemailandpassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const Home())
          : Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION- ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION- ${ex.message}');
      throw ex;
    }
  }

  Future<void> Logout() async => await _auth.signOut();
}
