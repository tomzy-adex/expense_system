import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      print("Signed up user: ${_user?.uid}"); // Debugging line
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.message}");
      throw e;
    } catch (e) {
      print("Unknown Error: ${e.toString()}");
      throw e;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = userCredential.user;
      print("Signed in user: ${_user?.uid}"); // Debugging line
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.message}");
      throw e;
    } catch (e) {
      print("Unknown Error: ${e.toString()}");
      throw e;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
