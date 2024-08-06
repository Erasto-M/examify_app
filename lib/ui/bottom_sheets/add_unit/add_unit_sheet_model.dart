import 'package:examify/app/app.locator.dart';
import 'package:examify/services/cod_dashboard_service.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/ui/bottom_sheets/add_unit/add_unit_sheet.form.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

import '../../../models/addUnit.dart';

class AddUnitSheetModel extends FormViewModel {
  final _adminDashBoardService = locator<AdminDashboardService>();
  final _authService = locator<AuthenticationService>();
  List<Map<String, dynamic>> lecturers = [];

  get lecturesList => lecturers;

  List<String> semesterStages = ["S1", "S2"];
  String? selectedSemester;

  get getSelectedSemester => selectedSemester;

  void setSelectedSemesterStage(value) {
    selectedSemester = value;
    notifyListeners();
  }

  get semesterStagesList => semesterStages;

  String? selectedLecName;

  get getSelectedLecName => selectedLecName;

  String? selectedLecId;

  get getSelectedLecId => selectedLecId;
  void setSelectedLecName(value) {
    selectedLecName = value;
    notifyListeners();
  }

  void setSelectedLecId(value) {
    selectedLecId = value;
    notifyListeners();
  }

  void setSelectedLecturer(value) {
    selectedLecName = value['userName'];
    selectedLecId = value['userId'];
    notifyListeners();
  }

  Future<AddUnitModel?> addUnit({required AddUnitModel addUnitModel}) async {
    setBusy(true);
    if (unitNameValue!.isEmpty ||
        unitNameValue == null ||
        unitCodeValue!.isEmpty ||
        unitCodeValue == null ||
        selectedLecName!.isEmpty ||
        selectedLecName == null ||
        selectedSemester!.isEmpty ||
        selectedSemester == null) {
      Fluttertoast.showToast(msg: "All fields are required");
      setBusy(false);
    } else {
      await _adminDashBoardService.addUnit(addUnitModel: addUnitModel);
      setBusy(false);
    }
  }

  //get lectures from auth service
  Future<void> getLectures() async {
    lecturers = await _authService.fetchLecturers();
    notifyListeners();
  }
}
