import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/lecturer_dashboard_service.dart';
import 'package:examify/ui/bottom_sheets/edit_student_marks/edit_student_marks_sheet.form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

class EditStudentMarksSheetModel extends FormViewModel {
  final _lectureDashboardService = locator<LecturerDashboardService>();

  Future<void> updateStudentMarks({
    required String unitcode,
    required String studentUid,
    required String? assignment1,
    required String? assignment2,
    required String? cat1,
    required String? cat2,
    required String? examMarks,
    required BuildContext context,
  }) async {
    setBusy(true);
    bool marksEntered =
        await checkIfMarksEntered(unitcode: unitcode, studentUid: studentUid);
    if (marksEntered) {
      Fluttertoast.showToast(
          msg: "Marks have already been entered for this student.");
      setBusy(false);
      return;
    }
    if (assignment1Value!.isEmpty ||
        assignment1Value == '' ||
        assignment2Value!.isEmpty ||
        assignment2Value == '' ||
        cat1Value!.isEmpty ||
        cat1Value == '' ||
        cat2Value!.isEmpty ||
        cat2Value == '' ||
        examMarksValue!.isEmpty ||
        examMarksValue == '') {
      Fluttertoast.showToast(msg: "Please fill all fields");
      setBusy(false);
      return;
    } else {
      int totalMarks = calculateTotalMarks(
          assignment1: int.parse(assignment1!),
          assignment2: int.parse(assignment2!),
          cat1: int.parse(cat1!),
          cat2: int.parse(cat2!),
          examMarks: int.parse(examMarks!));
      int assign1 = (double.parse(assignment1) / 10 * 5).toInt();
      int assign2 = (double.parse(assignment2) / 10 * 5).toInt();
      int combinedCat1 = (double.parse(cat1) / 20 * 15).toInt();
      int combinedCat2 = (double.parse(cat2) / 20 * 15).toInt();
      int combinedExamMarks = (double.parse(examMarks) / 100 * 70).toInt();
      await _lectureDashboardService.updateStudentMarks(
          unitCode: unitcode,
          studentId: studentUid,
          context: context,
          student: StudentsRegisteredUnitsModel(
              assignMent1Marks: assign1,
              assignMent2Marks: assign2,
              cat1Marks: combinedCat1,
              cat2Marks: combinedCat2,
              examMarks: combinedExamMarks,
              totalMarks: totalMarks,
              grade: calculateGrade(totalMarks: totalMarks)));
      notifyListeners();
      Navigator.of(context).pop();
      setBusy(false);
    }
  }

  Future<void> adminUpdateStudentMarks({
    required String unitcode,
    required String studentUid,
    required String? assignment1,
    required String? assignment2,
    required String? cat1,
    required String? cat2,
    required String? examMarks,
    required BuildContext context,
  }) async {
    setBusy(true);
    if (assignment1Value!.isEmpty ||
        assignment1Value == '' ||
        assignment2Value!.isEmpty ||
        assignment2Value == '' ||
        cat1Value!.isEmpty ||
        cat1Value == '' ||
        cat2Value!.isEmpty ||
        cat2Value == '' ||
        examMarksValue!.isEmpty ||
        examMarksValue == '') {
      Fluttertoast.showToast(msg: "Please fill all fields");
      setBusy(false);
      return;
    } else {
      int totalMarks = calculateTotalMarks(
          assignment1: int.parse(assignment1!),
          assignment2: int.parse(assignment2!),
          cat1: int.parse(cat1!),
          cat2: int.parse(cat2!),
          examMarks: int.parse(examMarks!));
      int assign1 = (double.parse(assignment1) / 10 * 5).toInt();
      int assign2 = (double.parse(assignment2) / 10 * 5).toInt();
      int combinedCat1 = (double.parse(cat1) / 20 * 15).toInt();
      int combinedCat2 = (double.parse(cat2) / 20 * 15).toInt();
      int combinedExamMarks = (double.parse(examMarks) / 100 * 70).toInt();
      await _lectureDashboardService.adminUpdateStudentMarks(
          unitCode: unitcode,
          studentId: studentUid,
          student: StudentsRegisteredUnitsModel(
              assignMent1Marks: assign1,
              assignMent2Marks: assign2,
              cat1Marks: combinedCat1,
              cat2Marks: combinedCat2,
              examMarks: combinedExamMarks,
              totalMarks: totalMarks,
              grade: calculateGrade(totalMarks: totalMarks)));
      notifyListeners();
      Navigator.of(context).pop();
      setBusy(false);
    }
  }

  int calculateTotalMarks({
    required int assignment1,
    required int assignment2,
    required int cat1,
    required int cat2,
    required int examMarks,
  }) {
    //calculate the total marks  such that assignment 1 and 2 should be compiled out of 5 each and cat 1 and 2 should be compiled out of 15 each and exam marks should be compiled out of 70
    double assignment1Value = assignment1 / 10 * 5;
    double assignment2Value = assignment2 / 10 * 5;
    double cat1Value = cat1 / 20 * 15;
    double cat2Value = cat2 / 20 * 15;
    double examMarksValue = examMarks / 100 * 70;
    double totalMarks = assignment1Value +
        assignment2Value +
        cat1Value +
        cat2Value +
        examMarksValue;

    return totalMarks.round();
  }

  calculateGrade({required int totalMarks}) {
    if (totalMarks >= 70 && totalMarks <= 100) {
      return "A";
    } else if (totalMarks >= 60 && totalMarks <= 69) {
      return "B";
    } else if (totalMarks >= 50 && totalMarks <= 59) {
      return "C";
    } else if (totalMarks >= 40 && totalMarks <= 49) {
      return "D";
    } else if (totalMarks >= 0 && totalMarks <= 39) {
      return "E";
    } else {
      return;
    }
  }

  bool _isMarksEntered = false;
  bool get isMarksEntered => _isMarksEntered;

  Future<bool> checkIfMarksEntered({
    required String unitcode,
    required String studentUid,
  }) async {
    setBusy(true);
    final students = await _lectureDashboardService
        .getAllMyStudents(unitCode: unitcode)
        .first;
    for (var student in students) {
      if (student.studentUid == studentUid) {
        setBusy(false);
        return true;
      }
    }
    setBusy(false);
    return false;
  }

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
      log(e.toString());
      Fluttertoast.showToast(msg: "An error occurred while saving marks.");
    }

    setBusy(false);
    notifyListeners();
  }
}
