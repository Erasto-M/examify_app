import 'package:stacked/stacked.dart';

class ExamsCoordinatorHomeViewModel extends BaseViewModel {
  int currentIndex = 0;
  get currentView => currentIndex;
  updateCurrentView(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
