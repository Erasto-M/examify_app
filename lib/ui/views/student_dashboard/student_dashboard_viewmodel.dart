import 'package:examify/app/app.bottomsheets.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/services/student_dashboard_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentDashboardViewModel extends BaseViewModel {
  final _studentDashboardService = locator<StudentDashboardService>();
  final _bottomSheetService = locator<BottomSheetService>();
  void showRegisterUnitBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.studentRegisterUnit,
    );
  }

  Stream<List<AddUnitModel>> fetchMyUnits() {
    return _studentDashboardService.fetchAllMyUnits();
  }
}
