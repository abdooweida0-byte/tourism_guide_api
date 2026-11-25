import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/models/user_model.dart';

class AppAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? user;
  bool isLoading = false;
  String? error;

  Future<bool> signUp(String name, String email, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await cred.user!.updateDisplayName(name);

      user = AppUser(uid: cred.user!.uid, name: name, email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      error = e.message ?? 'Sign up failed';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = AppUser(
        uid: cred.user!.uid,
        name: cred.user!.displayName ?? '',
        email: email,
      );
      return true;
    } on FirebaseAuthException {
      error = 'Email or password is wrong, or the account is not registered';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}