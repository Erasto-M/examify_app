import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/special_exams_model.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/bottom_sheets/student_register_unit/student_register_unit_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LecturerDashboardService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<AddUnitModel> unitCodes = [];
  List<AddUnitModel> unitNames = [];
  String? lecturerName;
  //method to fetch units of the lecturer
  Future<List<AddUnitModel>> fetchLecturerUnits() async {
    List<AddUnitModel> units = [];
    try {
      await firestore
          .collection('units')
          .where('unitLecturerId', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          units.add(AddUnitModel.fromMap(element.data()));
        });
        print(units);
      });
    } catch (e) {
      print(e);
    }
    return units;
  }

  //Fetch all Lecturers students
  Stream<List<StudentsRegisteredUnitsModel>> getAllMyStudents({
    required String unitCode,
  }) async* {
    try {
      yield* firestore
          .collection('student_registered_units')
          .where("unitLecturer", isEqualTo: auth.currentUser!.uid)
          .where("unitCode", isEqualTo: unitCode)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => StudentsRegisteredUnitsModel.fromMap(doc.data()))
              .toList());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      yield [];
    }
  }

  Stream<List<StudentsRegisteredUnitsModel>> getStudentsBasedOnUnitAndYear({
    required String unitCode,
    required String semesterStage,
  }) async* {
    try {
      yield* firestore
          .collection('student_registered_units')
          .where("unitCode", isEqualTo: unitCode)
          .where("semesterStage", isEqualTo: semesterStage)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => StudentsRegisteredUnitsModel.fromMap(doc.data()))
              .toList());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      yield [];
    }
  }

  //update student marks
  Future updateStudentMarks({
    required String studentId,
    required String unitCode,
    required StudentsRegisteredUnitsModel student,
    required BuildContext context,
  }) async {
    try {
      final collection = await firestore
          .collection('student_registered_units')
          .where("studentUid", isEqualTo: studentId)
          .where("unitLecturer", isEqualTo: auth.currentUser!.uid)
          .where("unitCode", isEqualTo: unitCode)
          .get();
      for (var doc in collection.docs) {
        await doc.reference.update({
          "assignMent1Marks": student.assignMent1Marks,
          "assignMent2Marks": student.assignMent2Marks,
          "cat1Marks": student.cat1Marks,
          "cat2Marks": student.cat2Marks,
          "examMarks": student.examMarks,
        });
      }
      Fluttertoast.showToast(msg: "Marks Updated Successfully");
      Navigator.of(context).pop();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } catch (e) {}
  }

  //update student marks
  Future adminUpdateStudentMarks({
    required String studentId,
    required String unitCode,
    required StudentsRegisteredUnitsModel student,
  }) async {
    try {
      print('studentId FROM VIEWMODEL: $studentId');
      print('unitCode: $unitCode');
      print("student Marks: ${student.assignMent1Marks}");
      print("student Marks: ${student.assignMent2Marks}");
      print("student Marks: ${student.cat1Marks}");
      print("student Marks: ${student.cat2Marks}");
      print("student Marks: ${student.examMarks}");
      print("student Marks: ${student.totalMarks}");
      print("student Marks: ${student.grade}");

      final collection = await firestore
          .collection('student_registered_units')
          .where("studentUid", isEqualTo: studentId)
          .where("unitCode", isEqualTo: unitCode)
          .get();
      for (var doc in collection.docs) {
        await doc.reference.update({
          "assignMent1Marks": student.assignMent1Marks,
          "assignMent2Marks": student.assignMent2Marks,
          "cat1Marks": student.cat1Marks,
          "cat2Marks": student.cat2Marks,
          "examMarks": student.examMarks,
          "totalMarks": student.totalMarks,
          "grade": student.grade,
        });
      }
      Fluttertoast.showToast(msg: "Marks Updated Successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } catch (e) {}
  }

  Stream<List<AddUnitModel>> fetchUnits({required String semesterStage}) {
    try {
      print("Fetching units as stream");
      return firestore
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
      print(e.toString());
      return Stream.value([]); // Return an empty stream in case of error
    }
  }

  Future<void> updateTotalMarksAndGrade(
      {required StudentsRegisteredUnitsModel unit}) async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        String userId = currentUser.uid;
        final collection = await firestore
            .collection('student_registered_units')
            .where("studentUid", isEqualTo: unit.studentUid)
            .where('unitLecturer', isEqualTo: userId)
            .where("unitCode", isEqualTo: unit.unitCode)
            .get();
        for (var doc in collection.docs) {
          await doc.reference.update({
            "totalMarks": unit.totalMarks,
            "grade": unit.grade,
          });
        }
      }
    } catch (e) {}
  }

  // Fetch All Special Exams For a scpecific Lecturer
  Stream<List<SpecialExamsModel>> getAllMyStudentSpecials() {
    try {
      return FirebaseFirestore.instance
          .collection('SpecialEXams')
          .where('unitLecturer', isEqualTo: auth.currentUser!.uid)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return SpecialExamsModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {}
    return Stream.value([]);
  }

  // update speciall exam status
  Future updateSpecialExamStatus({
    required String studentId,
    required String unitCode,
  }) async {
    try {
      final collection = await firestore
          .collection("SpecialEXams")
          .where('studeUid', isEqualTo: studentId)
          .where('unitCode', isEqualTo: unitCode)
          .where('unitLecturer', isEqualTo: auth.currentUser!.uid)
          .get();
      for (var doc in collection.docs) {
        await doc.reference.update({
          "specialExamStatus": "Lecturer Approved",
        });
      }
      Fluttertoast.showToast(msg: "Special Exam Status Updated Successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //customize units assesment
  Future sendCustomizedUnitAssessMents({
    required StudentsRegisteredUnitsModel units,
    required String unitCode,
  }) async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        final userId = currentUser.uid;
        final collection = await firestore
            .collection('student_registered_units')
            .where('unitLecturer', isEqualTo: userId)
            .where('unitCode', isEqualTo: unitCode)
            .get();
        for (var doc in collection.docs) {
          await doc.reference.update({
            "assignMent1OutOff": units.assignMent1OutOff,
            "assignMent2OutOff": units.assignMent2OutOff,
            "cat1Marks1OutOff": units.cat1Marks1OutOff,
            "cat2MarksOutOff": units.cat2MarksOutOff,
            "examMarksOutOff": units.examMarksOutOff,
          });
        }
        Fluttertoast.showToast(msg: "Assesment Updated Successfully");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      debugPrint(e.toString());
    }
  }

  // fet
}
