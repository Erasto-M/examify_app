import 'package:examify/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LecturerHomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  int currentIndex = 0;
  get currentIndexValue => currentIndex;
  selectedIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
