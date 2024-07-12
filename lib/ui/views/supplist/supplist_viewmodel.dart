import 'package:examify/app/app.locator.dart';
import 'package:examify/services/cod_dashboard_service.dart';
import 'package:stacked/stacked.dart';

import '../../../models/student_registered_units.dart';

class SupplistViewModel extends BaseViewModel {
  final _adminDashBoard = locator<AdminDashboardService>();

  Stream<Map<String, List<StudentsRegisteredUnitsModel>>> getSuppList() {
    return _adminDashBoard
        .getAllStudentDetails(semesterStage: 'Y1S1')
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
}
