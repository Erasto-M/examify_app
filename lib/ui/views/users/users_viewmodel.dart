import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/models/usersModel.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/services/cod_dashboard_service.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class UsersViewModel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _adminDashboardService = locator<AdminDashboardService>();
  List<AppUser> usersList = [];
  get users => usersList;

  String _selectedCohort = '2024';
  final List<String> _cohorts = [
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030"
  ];

  String get getSelectedCohort => _selectedCohort;
  List<String> get cohorts => _cohorts;

  void setSelectedCohort(String cohort) {
    _selectedCohort = cohort;
    notifyListeners();
  }

  Stream<List<AppUser>> getUsers() {
    return _authService.adminGetStudents(_selectedCohort);
  }

  void email({required String email}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(Uri.parse(emailUri.toString()))) {
      await launchUrl(Uri.parse(emailUri.toString()));
    } else {
      // Handle the error gracefully
     
    }
  }

  void call({required String phoneNumber}) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(Uri.parse(phoneUri.toString()))) {
      await launchUrl(Uri.parse(phoneUri.toString()));
    } else {
      // Handle the error gracefully
      
    }
  }

  //enable or dissable marks editing
  bool marksEditingWindow = false;
  Future<void> disableOrEnableEditing(bool value, String lecId) async {
    setBusy(true);
    try {
      await _adminDashboardService.disableOrEnableEditing(value, lecId);

      notifyListeners();
    } catch (e) {
      
    }
    setBusy(false);
  }

  Stream<DocumentSnapshot>? getEditingEnabledorDisabled(String lecId) {
    try {
      Stream<DocumentSnapshot> snapshotStream =
          _adminDashboardService.getEditingEnabledOrDisabled(lecId);

      snapshotStream.listen((snapshot) async {
        if (snapshot.exists) {
          Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
          if (data != null) {
            bool isOpen = data['isEditingEnabled'] ?? false;
            marksEditingWindow = isOpen;
            notifyListeners();
          }
        } else {
          // Create the document if it doesn't exist
          await _adminDashboardService.disableOrEnableEditing(false, lecId);
          marksEditingWindow = false;
          notifyListeners();
        }
      }, onError: (e) {
       
      });

      return snapshotStream;
    } catch (e) {
      
      setBusy(false);
      return null;
    }
  }
}
