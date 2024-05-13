import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationService {
  final _navigationService = locator<NavigationService>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //register user
  Future<void> createUser({
    required String email,
    required String userName,
    required String role,
    required String phoneNumber,
    required String gender,
    required String password,
  }) async {
    try {
      //register user
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        //add user to firestore
        firestore.collection('users').doc().set({
          'email': email,
          'userName': userName,
          'role': role,
          'phoneNumber': phoneNumber,
          'userId': value.user!.uid,
        });
      }).then((value) {
        //send verification email
        firebaseAuth.currentUser!.sendEmailVerification();
        Fluttertoast.showToast(
            msg: 'Account created successfully, check your email to verify');
      }).then((value) {
        _navigationService.replaceWithLoginView();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

// login user
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        if (value.user!.emailVerified) {
          _navigationService.replaceWithHomeView();
        } else {
          Fluttertoast.showToast(
              msg: 'Please verify your email before logging in');
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: 'No user found for that email, please register');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //sign out user
  Future<void> signOutUser() async {
    await firebaseAuth.signOut().then((value) {
      _navigationService.navigateToLoginView();
    });
  }

  //forgot password
  Future<void> forgotPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        Fluttertoast.showToast(msg: 'Check your email to reset your password');
      }).then((value) => _navigationService.navigateToLoginView());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: 'No user found for that email, please register');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //get current user auth state
  get getCurrentUser {
    return firebaseAuth.authStateChanges().listen((event) {
      if (event == null) {
        _navigationService.replaceWithLoginView();
      } else {
        _navigationService.replaceWithHomeView();
      }
    });
  }
}
