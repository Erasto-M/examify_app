import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

final _navigationService = locator<NavigationService>();

class UsersModel extends BaseViewModel {
  void navigateToUserDetails({required String user}) {
    _navigationService.navigateToUsersView(user : user);
  }
}
