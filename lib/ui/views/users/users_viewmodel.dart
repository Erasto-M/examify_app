import 'package:examify/app/app.locator.dart';
import 'package:examify/models/usersModel.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/ui/widgets/common/users/users.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class UsersViewModel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
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
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
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
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      // Handle the error gracefully
      print('Could not launch $phoneUri');
    }
  }
}
