import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/special_exams_model.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/bottom_sheets/student_register_unit/student_register_unit_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StudentDashboardService {
  //firebase instances
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  //method to fetch units from firebase
  Stream<List<AddUnitModel>> fetchUnits({required String semesterStage}) {
    try {
      print("Fetching units as stream");
      return db
          .collection("units")
          .where("semesterStage", isEqualTo: semesterStage)
          .snapshots()
          .map((querySnapshot) {
        print("Number of units fetched: ${querySnapshot.docs.length}");
        return querySnapshot.docs.map((doc) {
          return AddUnitModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return Stream.value([]); // Return an empty stream in case of error
    }
  }

  // my registered units
  Future<void> myRegisteredUnits(
      List<StudentsRegisteredUnitsModel> selectedUnits) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        final String studentUid = user.uid;

        for (var unit in selectedUnits) {
          final unitsCollection =
              db.collection('student_registered_units').doc();
          final newUnitWithId = unit.copyWith(studentUid: studentUid);
          print(newUnitWithId.toMap());
          await unitsCollection.set(newUnitWithId.toMap());
        }

        Fluttertoast.showToast(msg: "Units registered successfully");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // fetch all my units
  Stream<List<StudentsRegisteredUnitsModel>> fetchAllMyUnits(
      {required String semesterStage}) {
    try {
      print("Fetching All My Units");
      return db
          .collection("student_registered_units")
          .where("studentUid", isEqualTo: auth.currentUser!.uid)
          .where("semesterStage", isEqualTo: semesterStage)
          .snapshots()
          .map((querySnapshot) {
        print("Number of units fetched: ${querySnapshot.docs.length}");
        return querySnapshot.docs.map((doc) {
          return StudentsRegisteredUnitsModel.fromMap(
              doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return Stream.value([]); // Return an empty stream in case of error
    }
  }

  Stream<List<StudentsRegisteredUnitsModel>> fetchAllMyUnits2(
      {required String semesterStage}) {
    try {
      print("Fetching All My Units");

      String baseYear = semesterStage.substring(0, 2);
      List<String> stagesToInclude = [
        "${baseYear}S1",
        "${baseYear}S2",
      ];

      return db
          .collection("student_registered_units")
          .where("studentUid", isEqualTo: auth.currentUser!.uid)
          .where("semesterStage", whereIn: stagesToInclude)
          .snapshots()
          .map((querySnapshot) {
        print("Number of units fetched: ${querySnapshot.docs.length}");
        return querySnapshot.docs.map((doc) {
          return StudentsRegisteredUnitsModel.fromMap(
              doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return Stream.value([]); // Return an empty stream in case of error
    }
  }

  //appply Special Exam
  Future<void> applySpecialExams(
    List<SpecialExamsModel> selectedUnits,
  ) async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        String currentUserId = currentUser.uid;

        for (var unit in selectedUnits) {
          Fluttertoast.showToast(msg: unit.specialExamReason!);
          final specialExamsCollection = db.collection("SpecialEXams");
          final newUnitWithId = unit.copyWith(studeUid: currentUserId);
          await specialExamsCollection.doc().set(newUnitWithId.toMap());
          print("this are my specials: ${newUnitWithId.toMap()}");
        }
        Fluttertoast.showToast(msg: "Special Exams Applied Successfully");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // method to fetch the units
  Stream<List<SpecialExamsModel>> getAllMySpecials(
      {required String semesterStage}) {
    try {
      return db
          .collection('SpecialEXams')
          .where('studeUid', isEqualTo: auth.currentUser!.uid)
          .where('semesterStage', isEqualTo: semesterStage)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return SpecialExamsModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {}
    return Stream.value([]);
  }

  //mySpecial Exams
  Stream<List<SpecialExamsModel>> getMySpecialExams(
      {required String semesterStage}) {
    try {
      return db
          .collection('SpecialEXams')
          .where('semesterStage', isEqualTo: semesterStage)
          .where('specialExamStatus', isEqualTo: 'Approved')
          .where('studeUid', isEqualTo: auth.currentUser!.uid)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return SpecialExamsModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {}
    return Stream.value([]);
  }

  //get all my Misiing marks
  Stream<List<StudentsRegisteredUnitsModel>> getAllMyDetails(
      {required String semesterStage}) {
    try {
      return db
          .collection('student_registered_units')
          .where('semesterStage', isEqualTo: semesterStage)
          .where('studentUid', isEqualTo: auth.currentUser!.uid)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return StudentsRegisteredUnitsModel.fromMap(
              doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {}
    return Stream.value([]);
  }

  //check whether units registration is closed or not
  Stream<DocumentSnapshot<Map<String, dynamic>>>?
      getUnitRegistrationWindowStatus() {
    return db
        .collection('unit_registration_availability')
        .doc('2sz1qRL20HBQsnkXMfIG')
        .snapshots();
  }
}
