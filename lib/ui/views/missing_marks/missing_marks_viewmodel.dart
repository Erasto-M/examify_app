import 'package:examify/app/app.locator.dart';
import 'package:stacked/stacked.dart';

import '../../../models/student_registered_units.dart';
import '../../../services/cod_dashboard_service.dart';

class MissingMarksViewModel extends BaseViewModel {
  final _adminDashBoard = locator<AdminDashboardService>();
   Stream<Map<String, List<StudentsRegisteredUnitsModel>>> getMissingMarksList({
    required String semesterStage,
  }) {
    return _adminDashBoard
        .getAllStudentDetails(semesterStage: semesterStage)
        .map((studentUnits) {
      final Map<String, List<StudentsRegisteredUnitsModel>> missingMarksList = {};

      for (var unit in studentUnits) {
        // Check for missing marks in different categories
        bool hasMissingAssignmentMarks =
            unit.assignMent1Marks == null || unit.assignMent2Marks == null;
        bool hasMissingCatMarks = unit.cat1Marks == null || unit.cat2Marks == null;
        bool hasMissingExamMarks = unit.examMarks == null || unit.totalMarks == null;

        // Create a message detailing missing marks
        StringBuffer message = StringBuffer();

        if (hasMissingAssignmentMarks || hasMissingCatMarks || hasMissingExamMarks) {
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
