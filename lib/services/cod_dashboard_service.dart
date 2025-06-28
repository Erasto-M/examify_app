import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/models/special_exams_model.dart';
import 'package:examify/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/addUnit.dart';
import '../models/student_registered_units.dart';

class AdminDashboardService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

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

  //Delete Unit
  Future<void> deleteUnit({required String unitcode}) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection('units')
          .where('unitCode', isEqualTo: unitcode)
          .get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        return await db.collection('units').doc(doc.id).delete();
      }
      Fluttertoast.showToast(msg: 'Units Deleted Successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error while deleting unit');
    }
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
          .where('specialExamStatus', isEqualTo: 'Approved')
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
      required String unitCode,
      required String cohort}) async* {
    try {
      yield* db
          .collection('student_registered_units')
          .where('unitCode', isEqualTo: unitCode)
          .where('cohort', isEqualTo: cohort)
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

  Stream<List<Map<String, dynamic>>> fetchConsolidatedMarksheets({
    required String semesterStage,
  }) async* {
    try {
      final studentsStream = db
          .collection('student_registered_units')
          .where('semesterStage', isEqualTo: semesterStage)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => StudentsRegisteredUnitsModel.fromMap(doc.data()))
              .toList());

      await for (var students in studentsStream) {
        final Map<String, Map<String, dynamic>> studentMap = {};

        for (var student in students) {
          final studentUid = student.studentUid;

          if (studentMap.containsKey(studentUid)) {
            studentMap[studentUid]!['units'].add({
              'unitName': student.unitName,
              'unitCode': student.unitCode,
              'marks': student.totalMarks,
              'grade': student.grade,
              'recommendation': student.recommendation,
            });
          } else {
            studentMap[studentUid!] = {
              'studentName': student.studentName,
              'studentRegNumber': student.studentRegNo,
              'studentUid': studentUid,
              'units': [
                {
                  'unitName': student.unitName,
                  'unitCode': student.unitCode,
                  'marks': student.totalMarks,
                  'grade': student.grade,
                  'recommendation': student.recommendation,
                }
              ],
            };
          }
        }

        for (var studentData in studentMap.values) {
          final units = studentData['units'] as List<Map<String, dynamic>>;

          bool hasMissingMarks = false;
          bool hasFailingGrade = false;

          // Check each unit for missing marks or failing grade
          for (var unit in units) {
            if (unit['marks'] == null) {
              hasMissingMarks = true;
              break;
            }
            if (unit['grade'] == 'E') {
              hasFailingGrade = true;
            }
          }

          // Determine the recommendation based on conditions
          if (hasMissingMarks) {
            studentData['recommendation'] = 'Missing Marks';
          } else if (hasFailingGrade) {
            studentData['recommendation'] = 'Fail';
          } else {
            studentData['recommendation'] = 'Pass';
          }

          // You can also calculate and store totalMarks and meanMarks if needed
          final totalMarks =
              units.fold(0, (sum, unit) => sum + (unit['marks'] as int? ?? 0));
          final meanMark = units.isNotEmpty ? totalMarks / units.length : 0;
          final meanMarks = double.parse(meanMark.toStringAsFixed(2));
          final grade = meanMarks >= 70
              ? 'A'
              : meanMarks >= 60
                  ? 'B'
                  : meanMarks >= 50
                      ? 'C'
                      : meanMarks >= 40
                          ? 'D'
                          : 'E';

          studentData['grade'] = grade;

          studentData['totalMarks'] = totalMarks;
          studentData['meanMarks'] = meanMarks;
        }

        yield studentMap.values.toList();
      }
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
      
    }).catchError((error) {
      
    });
  }

  Future<DocumentSnapshot?> getRegistrationWindowStatus(String year) async {
    try {
      return await db
          .collection('unit_registration_availability')
          .doc('2sz1qRL20HBQsnkXMfIG')
          .get();
    } catch (e) {
     
      return null;
    }
  }

  Future<void> updateRegistrationWindowStatus(bool value, String year) async {
    try {
      await db
          .collection('unit_registration_availability')
          .doc('2sz1qRL20HBQsnkXMfIG')
          .update({
        '${year}_opened': value,
      });
      
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  //is Editing Enabled or disabled
  Stream<DocumentSnapshot> getEditingEnabledOrDisabled(String lecId) {
    return db
        .collection('Marks_Editing_window')
        .doc(lecId)
        .snapshots()
        .handleError((error) {
    });
  }

  //disable or Enable marks Editing
  Future<void> disableOrEnableEditing(bool value, String lecId) async {
    try {
      await db.collection('Marks_Editing_window').doc(lecId).set({
        'isEditingEnabled': value,
      }, SetOptions(merge: true));
    } catch (error) {
     throw Exception(error.toString());
    }
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

  Future<void> codApproveSpecialExams({
    required String studentId,
    required String semesterStage,
    required List<String> unitCodes,
  }) async {
    try {
      final specialExamsSnapshot = await FirebaseFirestore.instance
          .collection("SpecialEXams")
          .where('studeUid', isEqualTo: studentId)
          .where('semesterStage', isEqualTo: semesterStage)
          .where('unitCode', whereIn: unitCodes)
          .get();

      if (specialExamsSnapshot.docs.isEmpty) {
        Fluttertoast.showToast(msg: "No special exams found for the student.");
        return;
      }

      // Check if all units do not have a pending status
      bool allUnitsApproved = true;
      for (var doc in specialExamsSnapshot.docs) {
        String status = doc['specialExamStatus'];
        if (status == ('pending')) {
          allUnitsApproved = false;
          break;
        }
      }

      if (allUnitsApproved) {
        // Update special exam status in SpecialExams collection
        for (var doc in specialExamsSnapshot.docs) {
          await doc.reference.update({"specialExamStatus": "Approved"});
        }

        // Update status in StudentRegisteredUnits collection
        final registeredUnitsSnapshot = await FirebaseFirestore.instance
            .collection("student_registered_units")
            .where('studentUid', isEqualTo: studentId)
            .where('semesterStage', isEqualTo: semesterStage)
            .where('unitCode', whereIn: unitCodes)
            .get();

        for (var doc in registeredUnitsSnapshot.docs) {
          await doc.reference.update({"appliedSpecialExam": true});
        }

        Fluttertoast.showToast(msg: "Special Exam Status Updated Successfully");
      } else {
        Fluttertoast.showToast(
            msg: "Cannot approve as there are pending units.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<StudentsRegisteredUnitsModel>> getUnitsForApproval(
      String semester, String cohort) {
    return _firestore
        .collection('student_registered_units')
        .where('semesterStage', isEqualTo: semester)
        .where('cohort', isEqualTo: cohort)
        .where('isUnitApproved', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => StudentsRegisteredUnitsModel.fromMap(doc.data()))
            .toList());
  }

  Future<void> approveUnitsForStudent(
      List<String> unitCodes, String studentId) async {
    final batch = _firestore.batch();

    try {
      for (final unitCode in unitCodes) {
      
        // Query to get the specific unit documents for the student
        final unitQuerySnapshot = await _firestore
            .collection('student_registered_units')
            .where('studentUid', isEqualTo: studentId)
            .where('unitCode', isEqualTo: unitCode)
            .where('isUnitApproved', isEqualTo: false)
            .get();

        if (unitQuerySnapshot.docs.isEmpty) {
         
        } else {
          for (final doc in unitQuerySnapshot.docs) {
           
            batch.update(doc.reference, {'isUnitApproved': true});
          }
        }
      }

      // Commit the batch
      await batch.commit();
      
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //get Graduation List(evaluation of Results from first year)
  Stream<List<Map<String, dynamic>>> getGraduationList({
    required String cohort,
  }) async* {
    try {
      final studentsStream = db
          .collection('student_registered_units')
          .where('cohort', isEqualTo: cohort)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => StudentsRegisteredUnitsModel.fromMap(doc.data()))
              .toList());

      await for (var students in studentsStream) {
        final Map<String, Map<String, dynamic>> studentMap = {};

        for (var student in students) {
          final studentUid = student.studentUid;

          if (studentMap.containsKey(studentUid)) {
            studentMap[studentUid]!['units'].add({
              'unitName': student.unitName,
              'unitCode': student.unitCode,
              'marks': student.totalMarks,
              'grade': student.grade,
            });
          } else {
            studentMap[studentUid!] = {
              'studentName': student.studentName,
              'studentRegNumber': student.studentRegNo,
              'studentUid': studentUid,
              'units': [
                {
                  'unitName': student.unitName,
                  'unitCode': student.unitCode,
                  'marks': student.totalMarks,
                  'grade': student.grade,
                }
              ],
            };
          }
        }

        for (var studentData in studentMap.values) {
          final units = studentData['units'] as List<Map<String, dynamic>>;
          final totalMarks = units.fold(
              0, (sum1, unit) => sum1 + (unit['marks'] as int? ?? 0));
          final meanMark = units.isNotEmpty ? totalMarks / units.length : 0;
          final meanMarks = double.parse(meanMark.toStringAsFixed(2));
          final grade = meanMarks >= 70
              ? 'A'
              : meanMarks >= 60
                  ? 'B'
                  : meanMarks >= 50
                      ? 'C'
                      : meanMarks >= 40
                          ? 'D'
                          : 'E';
          studentData['totalMarks'] = totalMarks;
          studentData['meanMarks'] = meanMarks;
          studentData['grade'] = grade;
        }

        yield studentMap.values.toList();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      yield [];
    }
  }

  // GraduationList 2
  Stream<List<StudentsRegisteredUnitsModel>> fetchGraduationList(
      {required String cohort}) {
    try {
      return db
          .collection('student_registered_units')
          .where('cohort', isEqualTo: cohort)
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
}
