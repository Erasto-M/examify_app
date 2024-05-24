import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/models/addUnit.dart';
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
  Future<AddUnitModel?> myRegisteredUnits(
    StudentsRegisteredUnitsModel selectedUnits,
  ) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        final String studentUid = user.uid;
        final unitsCollection = db.collection('student_registered_units').doc();
        final newUnitWithId = selectedUnits.copyWith(studentUid: studentUid);
        unitsCollection.set(newUnitWithId.toMap()).then((value) {
          Fluttertoast.showToast(msg: "Units registered successfully");
        });
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
}
