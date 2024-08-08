import 'package:examify/app/app.locator.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/lecturer_dashboard_service.dart';
import 'package:examify/ui/bottom_sheets/customize_units_assesment/customize_units_assesment_sheet.form.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomizeUnitsAssesmentSheetModel extends FormViewModel {
  final _lecturerDashBoardService = locator<LecturerDashboardService>();
  final _navigationService = locator<NavigationService>();
  Future updateAssesment({
    required String unitCode,
    required StudentsRegisteredUnitsModel units,
  }) async {
    setBusy(true);
    await _lecturerDashBoardService.sendCustomizedUnitAssessMents(
      units: units,
      unitCode: unitCode,
    );
    setBusy(false);
    notifyListeners();
  }

  // navigate back
  Future navigateBack() async {
    await _navigationService.back();
    notifyListeners();
  }

  // get all my students
  Stream getAllMyStudentsDetails() {
    return _lecturerDashBoardService.getAllMyStudents(unitCode: '');
  }
}
