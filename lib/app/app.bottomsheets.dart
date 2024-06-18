// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:examify/ui/bottom_sheets/student_register_unit/student_register_unit_sheet.dart';
import 'package:examify/ui/bottom_sheets/update_profile/update_profile_sheet.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/bottom_sheets/add_unit/add_unit_sheet.dart';
import '../ui/bottom_sheets/edit_student_marks/edit_student_marks_sheet.dart';
import '../ui/bottom_sheets/edit_unit/edit_unit_sheet.dart';
import '../ui/bottom_sheets/notice/notice_sheet.dart';

enum BottomSheetType {
  notice,
  addUnit,
  editUnit,
  editStudentMarks,
  studentRegisterUnit,
  updateProfile,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(request: request, completer: completer),
    BottomSheetType.addUnit: (context, request, completer) =>
        AddUnitSheet(request: request, completer: completer),
    BottomSheetType.editUnit: (context, request, completer) =>
        EditUnitSheet(request: request, completer: completer),
    BottomSheetType.editStudentMarks: (context, request, completer) =>
        EditStudentMarksSheet(request: request, completer: completer),
    BottomSheetType.studentRegisterUnit: (context, request, completer) =>
        StudentRegisterUnitSheet(request: request, completer: completer),
    BottomSheetType.updateProfile: (context, request, completer) =>
        UpdateProfileSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
