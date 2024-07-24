import 'package:examify/app/app.locator.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/special_exams_model.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/student_dashboard_service.dart';
import 'package:examify/ui/views/apply_special_exam/apply_special_exam_view.form.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ApplySpecialExamViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _studentDashboardService = locator<StudentDashboardService>();

  //navigate back
  void navigateBack() {
    _navigationService.back();
    notifyListeners();
  }

  // String? _selectedSemesterStage = 'Y1S1';
  // String? get selectedSemesterStage => _selectedSemesterStage;

  // void setSelectedSemesterStage(String value) {
  //   _selectedSemesterStage = value;
  //   notifyListeners();
  // }

  bool _isSpecialExamApplied = false;
  bool? get getIsSpecialExamApplied => _isSpecialExamApplied;

  void SetSpecialExamApplied(bool value) {
    _isSpecialExamApplied = value;
    notifyListeners();
  }

  Stream<List<StudentsRegisteredUnitsModel>> fetchMyUnits(
      {required String semesterStage}) {
    return _studentDashboardService.fetchAllMyUnits(
        semesterStage: semesterStage);
  }

  // list of selected units
  List<StudentsRegisteredUnitsModel> selectedUnits = [];
  List<StudentsRegisteredUnitsModel> get getSelectedUnits => selectedUnits;
  bool isUnitSelected(String unitCode) {
    return selectedUnits.any((unit) => unit.unitCode == unitCode);
  }

  void updateSelectedUnits(
      bool isUnitSelected, StudentsRegisteredUnitsModel unit) {
    if (isUnitSelected) {
      selectedUnits.add(unit);
    } else {
      selectedUnits.removeWhere(
          (selectedUnit) => selectedUnit.unitCode == unit.unitCode);
    }
    notifyListeners();
  }

  Future<void> applySpecialExam({String? specialExamReason}) async {
    setBusy(true);
    if (reasonValue == "" || reasonValue!.isEmpty) {
      Fluttertoast.showToast(msg: 'please give a reason');
      setBusy(false);
    } else if (selectedUnits.isEmpty) {
      Fluttertoast.showToast(msg: 'Please select Units');
      setBusy(false);
    } else {
      List<SpecialExamsModel> specialExams = selectedUnits.map((unit) {
        return SpecialExamsModel(
          studentName: unit.studentName,
          studeEmail: unit.studentEmail,
          studePhone: unit.studentPhoneNumber,
          studeRegNo: unit.studentRegNo,
          unitCode: unit.unitCode,
          unitName: unit.unitName,
          unitLecturer: unit.unitLecturer,
          semesterStage: unit.semesterStage,
          yearOfStudent: unit.yearOfStudent,
          specialExamStatus: 'pending',
          specialExamReason: specialExamReason,
        );
      }).toList();
      await _studentDashboardService.applySpecialExams(specialExams);
      setBusy(false);
    }
  }

  //get al my special exams units
  Stream<List<SpecialExamsModel>> mySpecialExamUnits(
      {required String selectedSemesterStage}) {
    return _studentDashboardService.getAllMySpecials(
        semesterStage: selectedSemesterStage);
  }
}
