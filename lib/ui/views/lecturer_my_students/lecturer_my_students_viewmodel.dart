import 'package:examify/app/app.bottomsheets.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/services/lecturer_dashboard_service.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LecturerMyStudentsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  String? pdfPath;
  late PDFViewController pdfViewController;
  int? pageCount;
  int? currentPage;
  void setPdfPath(String path) {
    pdfPath = path;
    notifyListeners();
  }

  void setPdfController(PDFViewController controller) {
    pdfViewController = controller;
  }

  void setPageCount(int count) {
    pageCount = count;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  //initializing the services
  final _lectureDashboardService = locator<LecturerDashboardService>();
  final _authenticationService = locator<AuthenticationService>();
  final _lecturerDashboardService = locator<LecturerDashboardService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigaationService = locator<NavigationService>();
  //gettiong the current user details
  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> get user => userDetails;
  Future getCurrentUserDetails() async {
    userDetails = await _authenticationService.getCurrentUserDetails();
    notifyListeners();
  }

  List<AddUnitModel>? _lecturerUnits;
  List<AddUnitModel>? get lecturerUnits => _lecturerUnits;

  List<String> unitCodes = [];
  List<String> unitNames = [];
  Future<List<AddUnitModel>?> fetchLecturerUnits() async {
    _lecturerUnits = await _lecturerDashboardService.fetchLecturerUnits();
    if (_lecturerUnits != null && _lecturerUnits!.isNotEmpty) {
      unitCodes = _lecturerUnits!.map((unit) => unit.unitCode).toList();
      unitNames = _lecturerUnits!.map((unit) => unit.unitName).toList();
      print("unitcodes: ${unitCodes}");
      print("unitnames: ${unitNames}");
    }
  }

  List<StudentsRegisteredUnitsModel>? _students;
  List<StudentsRegisteredUnitsModel>? get students => _students;

  Stream<List<StudentsRegisteredUnitsModel>> getAllMyStudents({
    required String unitCode,
  }) {
    return _lectureDashboardService.getAllMyStudents(unitCode: unitCode);
  }

  //get all who applied for Special Exams
  Stream<List<StudentsRegisteredUnitsModel>> getAllMyStudentsWithSpeialExams({
    required String unitCode,
  }) {
    return _lectureDashboardService.getAllMyStudentsWithSpecials(
        unitCode: unitCode);
  }

  //get all with both special exam and without
  Stream<List<StudentsRegisteredUnitsModel>>
      getAllMyStudentsWithSpecialExamOrWithout({
    required String unitCode,
  }) {
    return _lectureDashboardService. getAllMyStudentsWithBothSpecialExamAndWithout(unitCode: unitCode);
  }

  // open the bottom sheet to edit the student marks
  void openEditStudentMarksSheet({
    required String unitCode,
    required String unitName,
    required List<StudentsRegisteredUnitsModel> student,
  }) {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.editStudentMarks,
        isScrollControlled: true,
        description: _selectedExamModuleToEnterMarks,
        data: {
          'assignment1': student[0].assignMent1OutOff,
          'assignment2': student[0].assignMent2OutOff,
          'cat1': student[0].cat1Marks1OutOff,
          'cat2': student[0].cat2MarksOutOff,
          'exam': student[0].examMarksOutOff,
          'student': student,
        },
        title: unitCode);
  }

  String _selectedExamModuleToEnterMarks = 'assignMent1Marks';
  String get selectedExamModuleToEnterMarks => _selectedExamModuleToEnterMarks;
  void setSelectedExamModuleToEnterMarks(String value) {
    _selectedExamModuleToEnterMarks = value;
    notifyListeners();
  }

  List<String> examModelues = [
    'assignMent1Marks',
    "assignMent2Marks",
    "cat1Marks",
    "cat2Marks",
    "examMarks",
  ];
  Future<void> backToHome() async {
    await _navigaationService.back();
    notifyListeners();
  }

  Future<void> showEditMarksPerStudentSheet({
    required String studentName,
    required String studentUid,
    required String unitCode,
    int? assignMent1Marks,
    int? assignMent2Marks,
    int? cat1Marks,
    int? cat2Marks,
    int? examMarks,
    int? assignMent1OutOff,
    int? assignMent2OutOff,
    int? cat1MarksOutOff,
    int? cat2MarksOutOff,
    int? examMarksOutOff,
  }) async {
    await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.editMarksPerStudent,
      isScrollControlled: true,
      description: studentUid,
      title: studentName,
      data: {
        "assignMent1Marks": assignMent1Marks,
        "assignMent2Marks": assignMent2Marks,
        "cat1Marks": cat1Marks,
        "cat2Marks": cat2Marks,
        "examMarks": examMarks,
        "unitCode": unitCode,
        "assignMent1OutOff": assignMent1OutOff,
        "assignMent2OutOff": assignMent2OutOff,
        "cat1MarksOutOff": cat1MarksOutOff,
        "cat2MarksOutOff": cat2MarksOutOff,
        "examMarksOutOff": examMarksOutOff,
      },
    );
  }

  Future<pw.Document> generatePDF(
      List<StudentsRegisteredUnitsModel> students, String unitName) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Marks Sheet for - $unitName',
                    style: pw.TextStyle(
                        color: PdfColors.green,
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.TableHelper.fromTextArray(
                  border: pw.TableBorder.all(),
                  cellHeight: 30,
                  cellStyle: const pw.TextStyle(
                    fontSize: 12,
                  ),
                  headerStyle: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black),
                  headers: [
                    'RegNo',
                    'Name',
                    'Assign1',
                    'Assign2',
                    'CAT1 ',
                    'CAT2 ',
                    'Exam ',
                    'Total ',
                    'Grade',
                  ],
                  data: students.map((student) {
                    return [
                      student.studentPhoneNumber,
                      student.studentName,
                      student.assignMent1Marks.toString(),
                      student.assignMent2Marks.toString(),
                      student.cat1Marks.toString(),
                      student.cat2Marks.toString(),
                      student.examMarks.toString(),
                      student.totalMarks.toString(),
                      student.grade
                    ];
                  }).toList(),
                  cellPadding: const pw.EdgeInsets.all(1),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(100),
                    1: const pw.FixedColumnWidth(100),
                    2: const pw.FixedColumnWidth(90),
                    3: const pw.FixedColumnWidth(90),
                    4: const pw.FixedColumnWidth(60),
                    5: const pw.FixedColumnWidth(60),
                    6: const pw.FixedColumnWidth(60),
                    7: const pw.FixedColumnWidth(60),
                    8: const pw.FixedColumnWidth(70),
                  },
                )
              ]);
        },
      ),
    );
    return pdf;
  }

  //navigate to pdf view
  void navigateToPdfView({required String unitName}) {
    _navigationService.navigateToMarksSheetPdfView(
        pdfPath: pdfPath, unitName: unitName);
  }

  calculateGrade({required double totalMarks}) {
    if (totalMarks >= 70 && totalMarks <= 100) {
      return "A";
    } else if (totalMarks >= 60 && totalMarks <= 69) {
      return "B";
    } else if (totalMarks >= 50 && totalMarks <= 59) {
      return "C";
    } else if (totalMarks >= 40 && totalMarks <= 49) {
      return "D";
    } else if (totalMarks >= 0 && totalMarks <= 39) {
      return "E";
    } else {
      return;
    }
  }

  //update totalmarks and grade
  Future<void> updateTotalMarksAndGrade(
      {required StudentsRegisteredUnitsModel unit}) {
    return _lectureDashboardService.updateTotalMarksAndGrade(unit: unit);
  }

  Future openCustomizeAssessMentBottomSheet({
    required String unitCode,
    required String unitName,
    required StudentsRegisteredUnitsModel units,
  }) async {
    await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.customizeUnitsAssesment,
        title: unitName,
        description: unitCode,
        data: {
          'assignment1': units.assignMent1OutOff,
          'assignment2': units.assignMent2OutOff,
          'cat1': units.cat1Marks1OutOff,
          'cat2': units.cat2MarksOutOff,
          'exam': units.examMarksOutOff,
        });
  }
}
