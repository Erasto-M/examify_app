import 'package:examify/app/app.locator.dart';
import 'package:stacked/stacked.dart';

import '../../../models/student_registered_units.dart';
import '../../../services/cod_dashboard_service.dart';

class MissingMarksViewModel extends BaseViewModel {
  final _adminDashBoard = locator<AdminDashboardService>();
  Stream<List<StudentsRegisteredUnitsModel>> getMissingMarksList() {
    return _adminDashBoard
        .getAllStudentDetails(semesterStage: 'Y1S1')
        .map((studentUnits) {
      final missingMarksList = <String, StudentsRegisteredUnitsModel>{};

      for (var unit in studentUnits) {
        if (unit.assignMent1Marks == null ||
            unit.assignMent2Marks == null ||
            unit.cat1Marks == null ||
            unit.cat2Marks == null ||
            unit.examMarks == null ||
            unit.totalMarks == null) {
          missingMarksList[unit.studentUid!] = unit;
        }
      }

      return missingMarksList.values.toList();
    });
  }
}
