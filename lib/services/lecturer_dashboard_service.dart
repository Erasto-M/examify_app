import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  //update student marks
  Future updateStudentMarks({
    required String studentId,
    required String unitCode,
    required StudentsRegisteredUnitsModel student,
    required BuildContext context,
  }) async {
    try {
      // print('studentId FROM VIEWMODEL: $studentId');
      // print('unitCode: $unitCode');
      // print("student Marks: ${student.assignMent1Marks}");
      // print("student Marks: ${student.assignMent2Marks}");
      // print("student Marks: ${student.cat1Marks}");
      // print("student Marks: ${student.cat2Marks}");
      // print("student Marks: ${student.examMarks}");
      // print("student Marks: ${student.totalMarks}");
      // print("student Marks: ${student.grade}");

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
}
