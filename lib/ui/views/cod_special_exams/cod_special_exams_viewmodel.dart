import 'package:examify/app/app.locator.dart';
import 'package:examify/models/special_exams_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/cod_dashboard_service.dart';

class CodSpecialExamsViewModel extends BaseViewModel {
  final _naviationService = locator<NavigationService>();
  final _codService = locator<AdminDashboardService>();
  String _selectedSemester = 'Y1S1';

  String get selectedSemester => _selectedSemester;

  void setSelectedSemester({required String semester}) {
    _selectedSemester = semester;

    notifyListeners();
  }

  List<String> years = [
    'Y1S1',
    'Y1S2',
    'Y2S1',
    'Y2S2',
    'Y3S1',
    'Y3S2',
    'Y4S1',
    'Y4S2'
  ];
  Future<void> navigateBack() async {
    await _naviationService.back();
  }

  //get special Exams
  Stream<List<Map<String, dynamic>>> getAllSpecialExams() async* {
    // Fetch special exams data from the service
    final examsStream = _codService.fetchSpecialExamsBasedOnSemesterStage(
        semesterStage: _selectedSemester);

    await for (var exams in examsStream) {
      // Map to store the aggregated data
      final Map<String, Map<String, dynamic>> studentMap = {};

      for (var exam in exams) {
        final studentUid = exam.studeUid;
        if (studentMap.containsKey(studentUid)) {
          // If student already exists, add the unit and status to the existing entry
          studentMap[studentUid]!['unitName'].add(exam.unitName);
          studentMap[studentUid]!['unitCode'].add(exam.unitCode);
          studentMap[studentUid]!['statuses'].add(exam.specialExamStatus);
        } else {
          // If student doesn't exist, create a new entry
          studentMap[studentUid!] = {
            'studentName': exam.studentName,
            'studentRegNumber': exam.studeRegNo,
            'unitName': [exam.unitName],
            'unitCode': [exam.unitCode],
            'statuses': [exam.specialExamStatus],

            'studentId': studentUid,

          };
        }
      }

      // Yield the aggregated data as a list of maps
      yield studentMap.values.toList();
    }
  }

  // student loading state map
  final Map<String, bool> studentLoadingState = {};
  // Update special exam status
  Future<void> updateSpecialExamStatus(
      {required String studentId, required List<String> unitCodes}) async {
    studentLoadingState[studentId] = true;
    await Future.delayed(const Duration(seconds: 2));
    notifyListeners();
    await _codService.codApproveSpecialExams(
        studentId: studentId,
        semesterStage: _selectedSemester,
        unitCodes: unitCodes);
    studentLoadingState[studentId] = false;
    notifyListeners();
  }

  bool isStudentLoading({required String studentId}) {
    return studentLoadingState[studentId] ?? false;
  }

}
