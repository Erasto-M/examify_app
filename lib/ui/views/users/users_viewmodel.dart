import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/models/usersModel.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/services/cod_dashboard_service.dart';
import 'package:examify/ui/widgets/common/users/users.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class UsersViewModel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _adminDashboardService = locator<AdminDashboardService>();
  List<AppUser> usersList = [];
  get users => usersList;

  Future<void> fetchUsers(String user) async {
    usersList = await _authService.fetchUsers(user);
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
      print('Could not launch $emailUri');
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
      print('Could not launch $phoneUri');
    }
  }

  //enable or dissable marks editing
    bool  marksEditingWindow  = false;
      Future<void> disableOrEnableEditing(bool value, String lecId) async {
    setBusy(true);
    try {
      await _adminDashboardService.disableOrEnableEditing(value, lecId);
     
      notifyListeners();
    } catch (e) {
      print('Error updating registration window status: $e');
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
      print('Error getting registration window status: $e');
     
    });

    return snapshotStream;
  } catch (e) {
    print('Error getting registration window status: $e');
    setBusy(false);
    return null;
  }
}

}
