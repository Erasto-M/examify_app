import 'package:stacked/stacked.dart';

class AdminHomeViewModel extends BaseViewModel {
  int currentIndex = 0;
  get currentView => currentIndex;
  updateCurrentView(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
