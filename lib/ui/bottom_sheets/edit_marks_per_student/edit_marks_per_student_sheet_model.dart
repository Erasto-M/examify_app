import 'package:examify/app/app.locator.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/bottom_sheets/edit_marks_per_student/edit_marks_per_student_sheet.form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    if (assignMent1MarksValue!.isEmpty ||
        assignMent1MarksValue == '' ||
        assignMent2MarksValue!.isEmpty ||
        assignMent2MarksValue == '' ||
        cat1MarksValue!.isEmpty ||
        cat1MarksValue == '' ||
        cat2MarksValue!.isEmpty ||
        cat2MarksValue == '' ||
        examMarksValue!.isEmpty ||
        examMarksValue == '') {
      Fluttertoast.showToast(msg: 'Please fill all fields');
      setBusy(false);
      return;
    }
    await _lecturerDashboardService.updateStudentMarks(
        studentId: studentId,
        unitCode: unitCode,
        student: student,
        context: context);
    setBusy(false);
  }
}
