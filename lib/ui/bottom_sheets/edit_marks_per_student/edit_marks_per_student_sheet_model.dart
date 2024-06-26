import 'package:examify/app/app.locator.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../services/lecturer_dashboard_service.dart';

class EditMarksPerStudentSheetModel extends FormViewModel {
  final _lecturerDashboardService = locator<LecturerDashboardService>();
  Future<void> updateMarks({
    required String studentId,
    required String unitCode,
    required StudentsRegisteredUnitsModel student,
    required BuildContext context,
  }) async {
    setBusy(true);
    await _lecturerDashboardService.updateStudentMarks(
        studentId: studentId,
        unitCode: unitCode,
        student: student,
        context: context);
    setBusy(false);
  }
}
