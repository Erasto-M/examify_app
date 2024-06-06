import 'package:examify/app/app.locator.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/lecturer_dashboard_service.dart';
import 'package:examify/ui/bottom_sheets/edit_student_marks/edit_student_marks_sheet.form.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

class EditStudentMarksSheetModel extends FormViewModel {
  final _lectureDashboardService = locator<LecturerDashboardService>();
  Future<List<StudentsRegisteredUnitsModel>>? getAllMyStudents() {
    _lectureDashboardService.getAllMyStudents();
  }

  Future<void> updateStudentMarks({
    required String? assignment1,
    required String? assignment2,
    required String? cat1,
    required String? cat2,
    required String? examMarks,
  }) async {
    setBusy(true);
    if (assignment1Value!.isEmpty ||
        assignment1Value == '' ||
        assignment2Value!.isEmpty ||
        assignment2Value == '' ||
        cat1Value!.isEmpty ||
        cat1Value == '' ||
        cat2Value!.isEmpty ||
        cat2Value == '' ||
        examMarksValue!.isEmpty ||
        examMarksValue == '') {
      Fluttertoast.showToast(msg: "Please fill all fields");
      setBusy(false);
      return;
    } else {
      await _lectureDashboardService.updateStudentMarks(
          student: StudentsRegisteredUnitsModel(
              assignMent1Marks: int.parse(assignment1!),
              assignMent2Marks: int.parse(assignment2!),
              cat1Marks: int.parse(cat1!),
              cat2Marks: int.parse(cat2!),
              examMarks: int.parse(examMarks!),
              totalMarks: 0,
              grade: "B"));
      setBusy(false);
    }
  }
}
