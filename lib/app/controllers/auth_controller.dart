import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final Rxn<UserModel> _user = Rxn<UserModel>();
  UserModel? get user => _user.value;
  Rxn<UserModel> get userRx => _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Error', e.message ?? 'Unknown error');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Sign Up Error', e.message ?? 'Unknown error');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  void _onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser == null) {
      _user.value = null;
    } else {
      _user.value = UserModel.fromFirebaseUser(firebaseUser);
    }
  }
}
