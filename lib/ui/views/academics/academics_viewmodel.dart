import 'package:stacked/stacked.dart';

class AcademicsViewModel extends BaseViewModel {
  String _selectedSemester = 'Y1S1';
  List<String> _semesters = ['Y1S1', 'Y1S2', 'Y2S1', 'Y2S2', 'Y3S1', 'Y3S2', 'Y4S1', 'Y4S2'];
  List<Map<String, String>> _academicReports = List.generate(
    20,
        (index) => {'RegNo': 'C026 - 01 - 0697/2020', 'Name': 'John Doe'},
  );

  String get selectedSemester => _selectedSemester;
  List<String> get semesters => _semesters;
  List<Map<String, String>> get academicReports => _academicReports;

  void setSelectedSemester(String semester) {
    _selectedSemester = semester;
    notifyListeners();
  }
}
