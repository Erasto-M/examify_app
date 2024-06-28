import 'package:examify/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ApplySpecialExamViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  //navigate back
  void navigateBack() {
    _navigationService.back();
    notifyListeners();
  }
}
