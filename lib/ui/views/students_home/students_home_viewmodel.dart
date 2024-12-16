import 'package:stacked/stacked.dart';

class StudentsHomeViewModel extends BaseViewModel {
  int currentIndex = 0;
  get currentIndexValue => currentIndex;
  selectedIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
