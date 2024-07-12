import 'package:examify/models/special_exams_model.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/cod_dashboard_service.dart';

class SpecialExamsListViewModel extends BaseViewModel {
  final _adminDashBoard = locator<AdminDashboardService>();

  Stream<Map<String, List<SpecialExamsModel>>> getSpecialsExam({
    required String semesterStage,
  }) {
    return _adminDashBoard
        .getSpecialExams(semesterStage:semesterStage )
        .map((studentUnits) {
      final specialList = <String, List<SpecialExamsModel>>{};

      for (var unit in studentUnits) {
        final studentUid = unit.studeUid;
        if (studentUid == null) {
          continue; // Skip if studentUid is null
        }

        if (!specialList.containsKey(studentUid)) {
          specialList[studentUid] = [];
        }
        specialList[studentUid]!.add(unit);
      }

      return specialList;
    });
  }
}
