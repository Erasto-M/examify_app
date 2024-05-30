import 'package:examify/app/app.locator.dart';
import 'package:examify/models/usersModel.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/ui/widgets/common/users/users.dart';
import 'package:stacked/stacked.dart';

class UsersViewModel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  List<AppUser> usersList = [];
  get users => usersList;

  Future<void> fetchUsers(String user) async {
    usersList = await _authService.fetchUsers(user);
    notifyListeners();
  }

  void email({required email}) {}

  void call({required phoneNumber}) {}
}
