import 'package:examify/app/app.bottomsheets.dart';
import 'package:examify/models/addUnit.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/admin_dashboard_service.dart';

class AdminManageCourseViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final _adminService = locator<AdminDashboardService>();

  List<AddUnitModel> _courses = [];
  List<AddUnitModel> get courses => _courses;
  void fetchCourses(String year) async {
    setBusy(true);
    _courses = await _adminService.getUnits(year);
    setBusy(false);
  }

  void showAddUnitBottomSheet({required String year}) {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addUnit,
      description: year,
      isScrollControlled: true,
      barrierDismissible: true,
    );
  }


  void showEditCourseBottomSheet({required AddUnitModel course, required String year}) {
_bottomSheetService.showCustomSheet(
      variant: BottomSheetType.editUnit,
      description: year,
      isScrollControlled: true,
      barrierDismissible: true,
      data: course
    );
  }
}
