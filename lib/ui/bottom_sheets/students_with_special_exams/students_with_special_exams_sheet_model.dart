import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/app/app.locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

import '../../../models/student_registered_units.dart';
import '../../../services/lecturer_dashboard_service.dart';

class StudentsWithSpecialExamsSheetModel extends BaseViewModel {
  final _lectureDashboardService = locator<LecturerDashboardService>();

  Stream<List<StudentsRegisteredUnitsModel>> getAllMyStudents({
    required String unitCode,
  }) {
    return _lectureDashboardService.getAllMyStudents(unitCode: unitCode);
  }

  // datacell Controllers
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List<StudentsRegisteredUnitsModel> _students = [];
  List<StudentsRegisteredUnitsModel> get studentsList => _students;

  Map<String, TextEditingController> _controllers = {};
  Map<String, TextEditingController> get controllers => _controllers;

// numeric
  bool isNumeric(String? value) {
    if (value!.isEmpty) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  //submit marks loop
  Future<void> submitMarks({
    required String unitCode,
    required String selectedModule,
    required int assignMent1Outof,
    required int assignMent2Outof,
    required int cat1Outof,
    required int cat2Outof,
    required int examOutof,
    required BuildContext context,
  }) async {
    setBusy(true);

    // Validate that all controllers have been filled
    if (controllers.isEmpty) {
      Fluttertoast.showToast(msg: "Please Enter all the marks");
      setBusy(false);
      return;
    }

    // Collect all errors
    List<String> errors = [];
    for (var entry in controllers.entries) {
      final text = entry.value.text;
      if (text.isEmpty) {
        errors.add("Please enter all the marks ");
      } else if (!isNumeric(text)) {
        errors.add("Invalid input. Please enter a number.");
      } else {
        int marks = int.parse(text);
        if (selectedModule == 'assignMent1Marks' && marks > assignMent1Outof) {
          errors.add("Assignment 1 marks  should not exceed $assignMent1Outof");
        } else if (selectedModule == 'assignMent2Marks' &&
            marks > assignMent2Outof) {
          errors.add("Assignment 2 marks  should not exceed $assignMent2Outof");
        } else if (selectedModule == 'cat1Marks' && marks > cat1Outof) {
          errors.add("CAT 1 marks should not exceed $cat1Outof");
        } else if (selectedModule == 'cat2Marks' && marks > cat2Outof) {
          errors.add("CAT2 marks  should not exceed $cat2Outof");
        } else if (selectedModule == 'examMarks' && marks > examOutof) {
          errors.add("Exam marks  should not exceed $examOutof");
        }
      }
    }

    // Show errors if any
    if (errors.isNotEmpty) {
      Fluttertoast.showToast(msg: errors.first, backgroundColor: Colors.red);
      setBusy(false);
      return;
    }

    // Proceed with sending data to Firebase
    try {
      for (var entry in controllers.entries) {
        final studentId = entry.key;
        final marks = int.parse(entry.value.text);

        var querySnapshot = await firestore
            .collection('student_registered_units')
            .where("studentUid", isEqualTo: studentId)
            .where("unitLecturer", isEqualTo: firebaseAuth.currentUser!.uid)
            .where("unitCode", isEqualTo: unitCode)
            .get();

        for (var doc in querySnapshot.docs) {
          await doc.reference.update({selectedModule: marks}).then((value) {});
        }
      }
      Fluttertoast.showToast(msg: "Marks saved successfully");
      Navigator.of(context).pop();
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred while saving marks.");
    }

    setBusy(false);
    notifyListeners();
  }
}
