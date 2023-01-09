import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:frusan_precios/src/models/user_model.dart';
export 'package:frusan_precios/src/models/user_model.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  // create user based on FirebaseUser

  Stream<UserInside> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map(_userFromFirebase);

  // create user based on FirebaseUser

  UserInside _userFromFirebase(User user) {
    return user == null ? null : UserInside(uid: user.uid);
  }

  //sign in anon
  /*Future<User> signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/

  //sign with email and password

  Future<UserInside> signInWithEmailAndPassword(
      String email, String password) async {
    UserInside resultUser = UserInside();

    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      resultUser = _userFromFirebase(result.user);
    } on FirebaseAuthException catch(e) {
      resultUser.setErrores = e;
    } on PlatformException catch (e) {
      resultUser.setErrores = e;
    } on Exception catch (e) {
      resultUser.setErrores = e;
    }

    return resultUser;
  }

  // register with email & passwrod
  Future<UserInside> registerWithEmailAndPassword(
      String email, String password) async {
    UserInside resultUser = UserInside();

    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      resultUser = _userFromFirebase(result.user);
    } on PlatformException catch (e) {
      resultUser.setErrores = e;
    } on Exception catch (e) {
      resultUser.setErrores = e;
    }

    return resultUser;
  }

  //sign out
  Future<void> signOut() async {
    try {
      final _responseAwait = await _firebaseAuth.signOut();
      return _responseAwait;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
