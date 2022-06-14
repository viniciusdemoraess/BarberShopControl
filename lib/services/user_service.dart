import 'package:barber_shop_control/dtos/user/user_local.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UserService extends ChangeNotifier {
  UserLocal? userLocal;

  //método construtor
  UserService() {
    _loadingCurrentUser();
  }

  Future<void> signIn(
    UserLocal userLocal, {
    Function? onSuccess,
    Function? onFail,
  }) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
              email: userLocal.email!, password: userLocal.password!))
          .user;
      this.userLocal = userLocal;
      this.userLocal!.id = user!.uid;
      // await _loadingCurrentUser(user: user);
      onSuccess!();
    } on PlatformException catch (e) {
      onFail!(debugPrint(e.toString()));
    }
  }

  signUp({
    required UserLocal userLocal,
    Function? onSuccess,
    Function? onFail,
  }) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: userLocal.email!, password: userLocal.password!))
          .user;
      userLocal.id = user?.uid;
      this.userLocal = userLocal;
      await userLocal.saveData();
      onSuccess!();
    } catch (e) {
      onFail!(debugPrint(e.toString()));
    }
    notifyListeners();
  }

  Future<void> _loadingCurrentUser({User? user}) async {
    final User? currentUser = user ?? _auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await _firestore.collection("users").doc(currentUser.uid).get();
      //  debugPrint(docUser.get('name'));

      userLocal = UserLocal.fromDocument(docUser);

      notifyListeners();
    }
  }
}
