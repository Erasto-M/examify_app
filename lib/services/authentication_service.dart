import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:examify/ui/views/admin_panel/admin_panel_view.dart';
import 'package:examify/ui/views/lecturer_home/lecturer_home_view.dart';
import 'package:examify/ui/views/login/login_view.dart';
import 'package:examify/ui/views/students_home/students_home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/views/admin_home/admin_home_view.dart';

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
        firestore.collection('users').doc(value.user!.uid).set({
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
        _navigationService.navigateToLoginView();
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
    required BuildContext context,
  }) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        //check users role and navigate to the appropriate home page
        firestore.collection('users').doc(user.uid).get().then((value) {
          if (value.data()!['role'] == 'Student') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const StudentsHomeView(),
              ),
            );
          } else if (value.data()!['role'] == 'Lecturer') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LecturerHomeView(),
              ),
            );
          } else if (value.data()!['role'] == 'Admin') {
            debugPrint("Logging to the admin");
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const AdminHomeView(),
              ),
            );
          } else {
            Fluttertoast.showToast(msg: "Role not found");
          }
        });
      } else {
        Fluttertoast.showToast(
            msg: 'Please verify your email before logging in');
      }
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
  Future<void> signOutUser({required BuildContext context}) async {
    try {
      await firebaseAuth.signOut().then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ),
        );
      }).then((value) {
        Fluttertoast.showToast(msg: 'Logged out successfully');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //forgot password
  Future<void> forgotPassword(
      {required String email, required BuildContext context}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        Fluttertoast.showToast(msg: 'Check your email to reset your password');
      }).then((value) {
        Navigator.of(context).pop();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: 'No user found for that email, please register');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //get current user auth state and navigate base on role . if role is student navigate to student home else navigate to admin home
  Future<Map<String, dynamic>> getCurrentUser(BuildContext context) async {
    try {
      await firebaseAuth.authStateChanges().listen((User? user) {
        if (user == null) {
          _navigationService.navigateToLoginView();
        } else {
          if (user.emailVerified) {
            firestore.collection('users').doc(user.uid).get().then((value) {
              if (value.data()!['role'] == 'Student') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const StudentsHomeView(),
                  ),
                );

                return value.data() as Map<String, dynamic>;
              } else if (value.data()!['role'] == "Lecturer") {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LecturerHomeView(),
                  ),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AdminHomeView(),
                  ),
                );
              }
            });
          } else {
            Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginView(),
                  ),
                );
            Fluttertoast.showToast(msg: 'Please verify your email');
          }
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return {};
  }

  // get current user details
  Future<Map<String, dynamic>> getCurrentUserDetails() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        DocumentSnapshot documentSnapshot =
            await firestore.collection('users').doc(user.uid).get();
        print(documentSnapshot.data());
        return documentSnapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } catch (e) {}
    return {};
  }

// update user profile
  Future<void> updateUserProfile({
    required String userName,
    required String email,
    required String phoneNumber,
    required String role,
  }) async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        await firestore.collection('users').doc(user.uid).update({
          'userName': userName,
          'email': email,
          "phoneNumber": phoneNumber,
          "role": role,
        }).then((value) {
          Fluttertoast.showToast(msg: 'Profile updated successfully');
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //fetch lectures from users
  Future<List<Map<String, dynamic>>> fetchLecturers() async {
    List<Map<String, dynamic>> lecturers = [];
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('users').where('role', isEqualTo: 'Lecturer').get();
      querySnapshot.docs.forEach((element) {
        lecturers.add(element.data() as Map<String, dynamic>);
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    print("Service: $lecturers");
    return lecturers;
  }
}
