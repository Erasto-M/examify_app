import 'package:examify/app/app.locator.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/cod_dashboard_service.dart';
import 'package:stacked/stacked.dart';

class PasslistViewModel extends FormViewModel {
  final _adminDashBoard = locator<AdminDashboardService>();

  Stream<List<StudentsRegisteredUnitsModel>> getPassLists({
    required String selectedSemesterStage,
  }) {
    return _adminDashBoard
        .getAllStudentDetails(semesterStage: selectedSemesterStage)
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
}
