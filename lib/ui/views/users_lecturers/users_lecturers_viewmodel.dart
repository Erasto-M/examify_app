import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/app.locator.dart';
import '../../../models/usersModel.dart';
import '../../../services/authentication_service.dart';
import '../../../services/cod_dashboard_service.dart';

class UsersLecturersViewModel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _adminDashboardService = locator<AdminDashboardService>();
  List<AppUser> usersList = [];
  get users => usersList;

  Future<void> getLecturers() async {
    usersList = await _authService.adminGetLecturers();
    notifyListeners();
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
      throw Exception(e.toString());
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
