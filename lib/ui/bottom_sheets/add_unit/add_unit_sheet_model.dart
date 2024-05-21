import 'package:examify/app/app.locator.dart';
import 'package:examify/services/admin_dashboard_service.dart';
import 'package:examify/ui/bottom_sheets/add_unit/add_unit_sheet.form.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

import '../../../models/addUnit.dart';

class AddUnitSheetModel extends FormViewModel {
  final _adminDashBoardService = locator<AdminDashboardService>();
  List<String> lecturers = ["Lecturer 1", "Lecturer 2", "Lecturer 3"];

  get lecturesList => lecturers;

  List<String> semesterStages = ["S1", "S2"];
  String? selectedSemester;

  get getSelectedSemester => selectedSemester;

  void setSelectedSemesterStage(value) {
    selectedSemester = value;
    notifyListeners();
  }

  get semesterStagesList => semesterStages;

  String? selectedLec;

  get getSelectedLec => selectedLec;

  void setSelectedLecturer(value) {
    selectedLec = value;
    notifyListeners();
  }

  Future<AddUnitModel?> addUnit({required AddUnitModel addUnitModel}) async {
    setBusy(true);
    if (unitNameValue!.isEmpty ||
        unitNameValue == null ||
        unitCodeValue!.isEmpty ||
        unitCodeValue == null ||
        selectedLec!.isEmpty ||
        selectedLec == null ||
        selectedSemester!.isEmpty ||
        selectedSemester == null) {
      Fluttertoast.showToast(msg: "All fields are required");
      setBusy(false);
    } else {
      await _adminDashBoardService.addUnit(addUnitModel: addUnitModel);
      setBusy(false);
    }
  }
}
