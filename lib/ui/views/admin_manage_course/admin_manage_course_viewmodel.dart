import 'package:examify/app/app.bottomsheets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class AdminManageCourseViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  void showAddUnitBottomSheet({required String year}) {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addUnit,
      description: year,
      isScrollControlled: true,
      barrierDismissible: true,
    );
  }
}
