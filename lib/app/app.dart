import 'package:examify/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:examify/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:examify/ui/views/home/home_view.dart';
import 'package:examify/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:examify/ui/views/login/login_view.dart';
import 'package:examify/ui/views/register/register_view.dart';
import 'package:examify/ui/views/forgot_password/forgot_password_view.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/ui/views/admin_panel/admin_panel_view.dart';
import 'package:examify/ui/views/students_home/students_home_view.dart';
import 'package:examify/ui/views/lecturer_home/lecturer_home_view.dart';
import 'package:examify/ui/views/admin_home/admin_home_view.dart';
import 'package:examify/ui/views/admin_manage_course/admin_manage_course_view.dart';
import 'package:examify/ui/bottom_sheets/add_unit/add_unit_sheet.dart';
import 'package:examify/services/admin_dashboard_service.dart';

import 'package:examify/ui/views/lecturer_dashboard/lecturer_dashboard_view.dart';
import 'package:examify/services/lecturer_dashboard_service.dart';

import 'package:examify/ui/bottom_sheets/student_register_unit/student_register_unit_sheet.dart';
import 'package:examify/services/student_dashboard_service.dart';

import 'package:examify/ui/bottom_sheets/update_profile/update_profile_sheet.dart';
import 'package:examify/ui/dialogs/confirm_logout/confirm_logout_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: ForgotPasswordView),
    MaterialRoute(page: AdminPanelView),
    MaterialRoute(page: StudentsHomeView),
    MaterialRoute(page: LecturerHomeView),
    MaterialRoute(page: AdminHomeView),
    MaterialRoute(page: AdminManageCourseView),
    MaterialRoute(page: LecturerDashboardView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: AdminDashboardService),

    LazySingleton(classType: LecturerDashboardService),

    LazySingleton(classType: StudentDashboardService),

// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: AddUnitSheet),
    StackedBottomsheet(classType: StudentRegisterUnitSheet),
    StackedBottomsheet(classType: UpdateProfileSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: ConfirmLogoutDialog),
// @stacked-dialog
  ],
)
class App {}
