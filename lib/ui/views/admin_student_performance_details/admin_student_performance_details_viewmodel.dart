import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/student_registered_units.dart';
import '../../../services/admin_dashboard_service.dart';

class AdminStudentPerformanceDetailsViewModel extends BaseViewModel {
  final _adminDashboardService = locator<AdminDashboardService>();
  Stream<List<StudentsRegisteredUnitsModel>>? _studentUnitsStream;
  Stream<List<StudentsRegisteredUnitsModel>>? get studentUnitsStream => _studentUnitsStream;

  String? _recommendationText;
  String? get recommendationText => _recommendationText;

  // void fetchStudentUnits(String semesterStage, String studentUid) {
  //   _studentUnitsStream = _adminDashboardService.getStudentUnits(semesterStage, studentUid);
  //   notifyListeners();
  // }
  // Future<void> generateRecommendations(List<StudentsRegisteredUnitsModel> units) async {
  //   final totalMarksList = units.map((unit) => unit.totalMarks).toList();
  //   // Feed the totalMarksList to your recommendation model or service
  //   final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: "AIzaSyAPyNw4jkSHZWCN7Kgln5jMHV5aMqkDYDE");
  //   final prompt = 'Recommended performance in 2 lines based on the following marks: ${totalMarksList.join(", ")}.';
  //   final content = [Content.text(prompt)];
  //   final response = await model.generateContent(content);
  //   _recommendationText = response.text;
  //   notifyListeners();
  // }
  void fetchStudentUnitsAndGenerateRecommendations(String semesterStage, String studentUid) async {
    _studentUnitsStream = _adminDashboardService.getStudentUnits(semesterStage, studentUid);
    notifyListeners();

    try {
      final units = await _studentUnitsStream!.first;
      generateRecommendations(units);
    } catch (e) {
      print('Error fetching student units or generating recommendations: $e');
    }
  }

  Future<void> generateRecommendations(List<StudentsRegisteredUnitsModel> units) async {
    final totalMarksList = units.map((unit) => unit.totalMarks).toList();
    // Feed the totalMarksList to your recommendation model or service
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: "AIzaSyAPyNw4jkSHZWCN7Kgln5jMHV5aMqkDYDE");
    final prompt = 'Recommended performance in 2 lines based on the following marks: ${totalMarksList.join(", ")}.';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    _recommendationText = response.text;
    notifyListeners();
  }
}
