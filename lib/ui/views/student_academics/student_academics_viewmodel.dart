import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/models/special_exams_model.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/student_dashboard_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/cod_dashboard_service.dart';

class StudentAcademicsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _StudentDashBoardService = locator<StudentDashboardService>();
  String _selectedSemester = 'Y1S1';
  final List<String> _semesters = [
    'Y1S1',
    'Y1S2',
    'Y2S1',
    'Y2S2',
    'Y3S1',
    'Y3S2',
    'Y4S1',
    'Y4S2'
  ];

  Stream<DocumentSnapshot?> getReportsAvailabilityStatus(
      String selectedSemester) {
    return FirebaseFirestore.instance
        .collection('academic_reports_availability')
        .doc('1YqKYQDE7I7cJGNQEzE8')
        .snapshots();
  }

  String get getselectedSemester => _selectedSemester;
  List<String> get semesters => _semesters;

  void setSelectedSemester(String semester) {
    _selectedSemester = semester;
    notifyListeners();
  }

  final List<String> academicLists = [
    'Passlist',
    'SuppList',
    'SpecialExams',
    'MissingMarks',
  ];

  String selectedAcademicList = 'Passlist';
  String get getSelectedAcademicList => selectedAcademicList;

  void setSelectedAcademicList(String academicList) {
    selectedAcademicList = academicList;
    notifyListeners();
  }

  /// if a student is in passlist call this

  Stream<List<StudentsRegisteredUnitsModel>> getPassLists({
    required String selectedSemesterStage,
  }) {
    return _StudentDashBoardService
        .getAllMyDetails(semesterStage: selectedSemesterStage)
        .map((studentUnits) {
      final passList = <String, StudentsRegisteredUnitsModel>{};

      // Collect all student UIDs who have an 'E' grade or missing marks or applied for a special exam
      final excludedStudents = <String>{};

      for (var unit in studentUnits) {
        if (unit.grade == 'E' ||
            unit.assignMent1Marks == null ||
            unit.assignMent2Marks == null ||
            unit.cat1Marks == null ||
            unit.cat2Marks == null ||
            unit.examMarks == null ||
            unit.totalMarks == null ||
            unit.appliedSpecialExam == true) {
          excludedStudents.add(unit.studentUid!);
        }
      }

      // Filter out students who are in the excluded list
      for (var unit in studentUnits) {
        if (!excludedStudents.contains(unit.studentUid) &&
            !passList.containsKey(unit.studentUid)) {
          passList[unit.studentUid!] = unit;
        }
      }

      return passList.values.toList();
    });
  }

  //if a student is in supp list call this
  Stream<Map<String, List<StudentsRegisteredUnitsModel>>> getSuppList({
    required String semesterStage,
  }) {
    return _StudentDashBoardService
        .getAllMyDetails(semesterStage: semesterStage)
        .map((studentUnits) {
      final suppList = <String, List<StudentsRegisteredUnitsModel>>{};

      for (var unit in studentUnits) {
        final studentUid = unit.studentUid;
        if (studentUid == null) {
          continue; // Skip if studentUid is null
        }

        // Check conditions for supplementary exam
        final hasEGrade = unit.grade == 'E';
        final hasNoMissingMarks = unit.assignMent1Marks != null &&
            unit.assignMent2Marks != null &&
            unit.cat1Marks != null &&
            unit.cat2Marks != null &&
            unit.examMarks != null &&
            unit.totalMarks != null;
        final hasNotAppliedSpecialExam = unit.appliedSpecialExam == false;

        if (hasEGrade && hasNoMissingMarks && hasNotAppliedSpecialExam) {
          // Add student if they meet all conditions
          if (!suppList.containsKey(studentUid)) {
            suppList[studentUid] = [];
          }
          suppList[studentUid]!.add(unit);
        }
      }

      return suppList;
    });
  }

  // IF A STUDENT has special exam call this
  Stream<Map<String, List<SpecialExamsModel>>> getSpecialsExam({
    required String semesterStage,
  }) {
    return _StudentDashBoardService
        .getMySpecialExams(semesterStage: semesterStage)
        .map((studentUnits) {
      final specialList = <String, List<SpecialExamsModel>>{};

      for (var unit in studentUnits) {
        final studentUid = unit.studeUid;
        if (studentUid == null) {
          continue; // Skip if studentUid is null
        }

        if (!specialList.containsKey(studentUid)) {
          specialList[studentUid] = [];
        }
        specialList[studentUid]!.add(unit);
      }

      return specialList;
    });
  }

  // if a student has missing marks call this
  Stream<Map<String, List<StudentsRegisteredUnitsModel>>> getMissingMarksList({
    required String semesterStage,
  }) {
    return _StudentDashBoardService
        .getAllMyDetails(semesterStage: semesterStage)
        .map((studentUnits) {
      final Map<String, List<StudentsRegisteredUnitsModel>> missingMarksList =
          {};

      for (var unit in studentUnits) {
        // Check for missing marks in different categories
        bool hasMissingAssignmentMarks =
            unit.assignMent1Marks == null || unit.assignMent2Marks == null;
        bool hasMissingCatMarks =
            unit.cat1Marks == null || unit.cat2Marks == null;
        bool hasMissingExamMarks =
            unit.examMarks == null || unit.totalMarks == null;

        // Create a message detailing missing marks
        StringBuffer message = StringBuffer();

        if (hasMissingAssignmentMarks ||
            hasMissingCatMarks ||
            hasMissingExamMarks) {
          message.write('${unit.studentName} has missing marks in: ');

          if (hasMissingAssignmentMarks) {
            message.write('Assignments ');
          }
          if (hasMissingCatMarks) {
            message.write('CAT ');
          }
          if (hasMissingExamMarks) {
            message.write('Exam ');
          }

          if (!missingMarksList.containsKey(unit.studentUid)) {
            missingMarksList[unit.studentUid!] = [];
          }
          unit.missingMarksMessage = message.toString();
          missingMarksList[unit.studentUid]!.add(unit);
        }
      }

      return missingMarksList;
    });
  }
}
