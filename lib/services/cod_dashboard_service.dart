import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/models/special_exams_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/addUnit.dart';
import '../models/student_registered_units.dart';

class AdminDashboardService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<AddUnitModel?> addUnit({
    required AddUnitModel addUnitModel,
  }) async {
    try {
      CollectionReference collectionReference = db.collection("units");
      final unitWithId =
          addUnitModel.copyWith(unitId: collectionReference.doc().id);
      collectionReference
          .doc(addUnitModel.unitCode)
          .set(unitWithId.toMap())
          .then((value) {
        Fluttertoast.showToast(msg: "Added Unit Successfully");
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  //get units from firestore where semesterStage has text Y4
  Future<List<AddUnitModel>> getUnits(String currentYear) async {
    List<AddUnitModel> units = [];
    try {
      CollectionReference collectionReference = db.collection("units");
      await collectionReference
          .where("year", isEqualTo: currentYear)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          units.add(AddUnitModel.fromMap(element.data() as Map<String, dynamic>)
              .copyWith(unitId: element.id));
        });
      });
    } catch (error) {
      print(error.toString());
      Fluttertoast.showToast(msg: error.toString());
    }
    return units;
  }

  Future<void> editUnit(
      {required String unitCode, required String unitName}) async {
    try {
      await db.collection('units').doc(unitCode).update({
        'unitName': unitName,
      });
    } catch (e) {
      // Handle error
    } finally {}
  }

  Stream<List<StudentsRegisteredUnitsModel>> getStudentUnits(
      String semesterStage, String studentUid) {
    return db
        .collection('student_registered_units')
        .where('semesterStage', isEqualTo: semesterStage)
        .where('studentUid', isEqualTo: studentUid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<StudentsRegisteredUnitsModel> units = [];
      for (var doc in query.docs) {
        units.add(StudentsRegisteredUnitsModel.fromDocument(doc));
      }
      return units;
    });
  }

  // calcualate reports
  Stream<List<StudentsRegisteredUnitsModel>> getAllStudentDetails(
      {required String semesterStage}) {
    try {
      return db
          .collection('student_registered_units')
          .where('semesterStage', isEqualTo: semesterStage)
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

  Stream<List<SpecialExamsModel>> getSpecialExams(
      {required String semesterStage}) {
    try {
      return db
          .collection('SpecialEXams')
          .where('semesterStage', isEqualTo: semesterStage)
          .where('specialExamStatus', isEqualTo: 'pending')
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return SpecialExamsModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {}
    return Stream.value([]);
  }

  //Fetch all Lecturers students
  Stream<List<StudentsRegisteredUnitsModel>> fetchStudentsAccordingToYearStream(
      {required String yearName,
      required String semesterStage,
      required String unitCode}) async* {
    try {
      yield* db
          .collection('student_registered_units')
          .where('unitCode', isEqualTo: unitCode)
          .where('semesterStage', isEqualTo: semesterStage)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => StudentsRegisteredUnitsModel.fromMap(doc.data()))
              .toList());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      yield [];
    }
  }

  Future<DocumentSnapshot?> getReportsAvailabilityStatus() async {
    try {
      return await FirebaseFirestore.instance
          .collection('academic_reports_availability')
          .doc('1YqKYQDE7I7cJGNQEzE8')
          .get();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateReportsAvailabilityStatus(
      bool value, String selectedYear) async {
    await FirebaseFirestore.instance
        .collection('academic_reports_availability')
        .doc('1YqKYQDE7I7cJGNQEzE8')
        .update({
      '${selectedYear}_available': value,
    }).then((_) {
      // Successfully updated
      print('Successfully updated');
    }).catchError((error) {
      print('Failed to update: $error');
    });
  }

  //fetch all Special Exams for a Selected Semester Stage
  Stream<List<SpecialExamsModel>> fetchSpecialExamsBasedOnSemesterStage(
      {required String semesterStage}) async* {
    try {
      yield* db
          .collection('SpecialEXams')
          .where('semesterStage', isEqualTo: semesterStage)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => SpecialExamsModel.fromMap(doc.data()))
              .toList());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      yield [];
    }
  }

}
