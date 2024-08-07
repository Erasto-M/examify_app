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
import 'package:examify/services/cod_dashboard_service.dart';

import 'package:examify/ui/views/lecturer_dashboard/lecturer_dashboard_view.dart';
import 'package:examify/services/lecturer_dashboard_service.dart';

import 'package:examify/ui/bottom_sheets/student_register_unit/student_register_unit_sheet.dart';
import 'package:examify/services/student_dashboard_service.dart';

import 'package:examify/ui/bottom_sheets/update_profile/update_profile_sheet.dart';
import 'package:examify/ui/dialogs/confirm_logout/confirm_logout_dialog.dart';

import 'package:examify/ui/bottom_sheets/edit_unit/edit_unit_sheet.dart';

import 'package:examify/ui/views/users/users_view.dart';
import 'package:examify/ui/views/admin_student_performance/admin_student_performance_view.dart';
import 'package:examify/ui/views/admin_student_performance_details/admin_student_performance_details_view.dart';
import 'package:examify/ui/views/lecturer_my_students/lecturer_my_students_view.dart';
import 'package:examify/ui/bottom_sheets/edit_student_marks/edit_student_marks_sheet.dart';
import 'package:examify/ui/views/student_units_marks/student_units_marks_view.dart';
import 'package:examify/ui/views/exams_coordinator_home/exams_coordinator_home_view.dart';
import 'package:examify/ui/views/exam_coordinator_panel_view/exam_coordinator_panel_view_view.dart';
import 'package:examify/ui/bottom_sheets/edit_marks_per_student/edit_marks_per_student_sheet.dart';
import 'package:examify/ui/views/marks_sheet_pdf/marks_sheet_pdf_view.dart';
import 'package:examify/ui/views/my_trancripts/my_trancripts_view.dart';
import 'package:examify/ui/views/apply_special_exam/apply_special_exam_view.dart';
import 'package:examify/ui/views/ec_access_marks_sheets/ec_access_marks_sheets_view.dart';
import 'package:examify/ui/views/passlist/passlist_view.dart';
import 'package:examify/ui/views/supplist/supplist_view.dart';
import 'package:examify/ui/views/special_exams_list/special_exams_list_view.dart';
import 'package:examify/ui/views/missing_marks/missing_marks_view.dart';
import 'package:examify/ui/views/cod_special_exams/cod_special_exams_view.dart';
import 'package:examify/ui/bottom_sheets/customize_units_assesment/customize_units_assesment_sheet.dart';
import 'package:examify/ui/views/student_academics/student_academics_view.dart';
import 'package:examify/ui/views/cod_approve_units/cod_approve_units_view.dart';
import 'package:examify/ui/bottom_sheets/students_with_special_exams/students_with_special_exams_sheet.dart';
import 'package:examify/ui/views/support_team/support_team_view.dart';
import 'package:examify/ui/bottom_sheets/add_supp_exam_marks/add_supp_exam_marks_sheet.dart';
import 'package:examify/ui/views/users_lecturers/users_lecturers_view.dart';
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
    MaterialRoute(page: UsersView),
    MaterialRoute(page: AdminStudentPerformanceView),
    MaterialRoute(page: AdminStudentPerformanceDetailsView),
    MaterialRoute(page: LecturerMyStudentsView),
    MaterialRoute(page: StudentUnitsMarksView),
    MaterialRoute(page: ExamsCoordinatorHomeView),
    MaterialRoute(page: ExamCoordinatorPanelViewView),
    MaterialRoute(page: MarksSheetPdfView),
    MaterialRoute(page: MyTrancriptsView),
    MaterialRoute(page: ApplySpecialExamView),
    MaterialRoute(page: EcAccessMarksSheetsView),
    MaterialRoute(page: PasslistView),
    MaterialRoute(page: SupplistView),
    MaterialRoute(page: SpecialExamsListView),
    MaterialRoute(page: MissingMarksView),
    MaterialRoute(page: CodSpecialExamsView),
    MaterialRoute(page: StudentAcademicsView),
    MaterialRoute(page: CodApproveUnitsView),
    MaterialRoute(page: SupportTeamView),
    MaterialRoute(page: UsersLecturersView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: AdminDashboardService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: AddUnitSheet),
    StackedBottomsheet(classType: EditUnitSheet),
    StackedBottomsheet(classType: EditStudentMarksSheet),
    StackedBottomsheet(classType: EditMarksPerStudentSheet),
    StackedBottomsheet(classType: CustomizeUnitsAssesmentSheet),
    StackedBottomsheet(classType: StudentsWithSpecialExamsSheet),
    StackedBottomsheet(classType: AddSuppExamMarksSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: ConfirmLogoutDialog),
// @stacked-dialog
  ],
)
class App {}
