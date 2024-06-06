import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TranscriptsModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  void navigateToTranscriptDetails({required String yearName}) {
    _navigationService.navigateToAdminStudentPerformanceView();
  }
}
