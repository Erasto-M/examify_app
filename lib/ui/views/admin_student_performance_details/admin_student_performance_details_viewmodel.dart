import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/student_registered_units.dart';
import '../../../services/admin_dashboard_service.dart';

class AdminStudentPerformanceDetailsViewModel extends BaseViewModel {
  final _adminDashboardService = locator<AdminDashboardService>();
  Stream<List<StudentsRegisteredUnitsModel>>? _studentUnitsStream;
  Stream<List<StudentsRegisteredUnitsModel>>? get studentUnitsStream => _studentUnitsStream;
  void fetchStudentUnits(String semesterStage, String studentUid) {
    _studentUnitsStream = _adminDashboardService.getStudentUnits(semesterStage, studentUid);
    notifyListeners();
  }
}
