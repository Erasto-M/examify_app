import 'package:examify/app/app.router.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/usersModel.dart';
import 'package:examify/services/cod_dashboard_service.dart';
import 'package:examify/services/lecturer_dashboard_service.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../app/app.locator.dart';
import '../../../models/student_registered_units.dart';
import '../../../services/authentication_service.dart';

class AdminStudentPerformanceViewModel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _lectureDashboardService = LecturerDashboardService();
  final _adminDashboardService = locator<AdminDashboardService>();

  TextEditingController searchController = TextEditingController();

  List<AppUser> usersList = [];
  get users => usersList;

  List<AppUser> _filteredUsers = [];
  get filteredUsers => _filteredUsers;

  String selectedSem = '';
  String get getSelectedSem => selectedSem;

  String selectedUnitCode = '';
  String get getSelectedUnitCode => selectedSem;

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

  String _selectedUnitToViewMarks = '';
  String get selectedUnitToGetMarks => _selectedUnitToViewMarks;

  List<AddUnitModel> _unitsPerSelectedSemester = [];
  List<AddUnitModel> get unitsPerSelectedSemester => _unitsPerSelectedSemester;

  void fetchUnits() {
    _lectureDashboardService
        .fetchUnits(semesterStage: selectedSem)
        .listen((units) {
      _unitsPerSelectedSemester = units;
if (units.isNotEmpty) {
        setSelectedUnitCode(units[0].unitCode);
      }
      notifyListeners();
    });
  }

  void setSelectedSem(String value) {
    selectedSem = value;
    fetchUnits();
    notifyListeners();
  }
  void setSelectedUnitCode(unitCode) {
    selectedUnitCode = unitCode;
    notifyListeners();
  }


  void setInitSemValue(String yearName) {
    String currentSem = yearName.endsWith("one")
        ? "Y1S1"
        : yearName.endsWith("two")
            ? "Y2S1"
            : yearName.endsWith("three")
                ? "Y3S1"
                : "Y4S1";

    selectedSem = currentSem;
    fetchUnits();
    notifyListeners();
  }

  void searchStudent() {
    String query = searchController.text.toLowerCase();
    usersList = users.where((user) {
      return user.userName.toLowerCase().contains(query) ||
          user.email.toLowerCase().contains(query);
    }).toList();
    notifyListeners();
  }

  Future<void> fetchUsers({required String yearName}) async {
    String currentYearName = yearName.endsWith("one")
        ? "Y1"
        : yearName.endsWith("two")
            ? "Y2"
            : yearName.endsWith("three")
                ? "Y3"
                : "Y4";
    notifyListeners();
  }

  Stream<List<StudentsRegisteredUnitsModel>>
      fetchStudentsAccordingToYearStream({
    required String yearName,
    required String semesterStage,
  }) {
    String currentYearName = yearName.endsWith("one")
        ? "Y1"
        : yearName.endsWith("two")
            ? "Y2"
            : yearName.endsWith("three")
                ? "Y3"
                : "Y4";
    return _adminDashboardService.fetchStudentsAccordingToYearStream(
        yearName: currentYearName,
        semesterStage: semesterStage,
        unitCode: selectedUnitCode,
        cohort: _selectedCohort);
  }

  Stream<List<Map<String, dynamic>>> getConsolidatedMarksheets(
      String semesterStage) {
    return _adminDashboardService.fetchConsolidatedMarksheets(
      semesterStage: semesterStage,
    );
  }

  void checkPerformanceBasedOnCurrentYear(
      {required String semesterStage, required String? studentUid}) {
    _navigationService.navigateToAdminStudentPerformanceDetailsView(
        semesterStage: semesterStage, studentUid: studentUid!!);
  }

  //Generate consolidated markSheets

  pw.Document generateConsolidatedNMarkSheet({
    required List<Map<String, dynamic>> students,
    required String semesterStage,
  }) {
    final transcript = pw.Document();

    // Collect all unique unit names for headers
    final Set<String> unitNames = {};
    for (var student in students) {
      for (var unit in student['units']) {
        unitNames.add(unit['unitCode']);
      }
    }

    final headers = [
      'Reg No',
      // 'Name',
      ...unitNames,
      'MeanScore',
      'MeanGrade',
      'Recommendation',
    ];

    final data = students.map((student) {
      final studentUnits = student['units'] as List<Map<String, dynamic>>;
      final Map<String, dynamic> unitGrades = {};

      for (var unit in studentUnits) {
        unitGrades[unit['unitCode']] = unit['marks'];
      }

      final unitMarks = unitNames
          .map((unitName) => unitGrades[unitName]?.toString() ?? 'null')
          .toList();

      return [
        student['studentRegNumber'],
        // student['studentName'],
        ...unitMarks,
        student['meanMarks'].toString(),
        student['grade'].toString(),
        student['recommendation'],
      ];
    }).toList();

    transcript.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
                color: PdfColors.white,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 3),
                  pw.Center(
                    child: pw.Text(
                      'Dedan Kimathi University of Technology',
                      style: pw.TextStyle(
                        fontSize: 20,
                        color: PdfColors.green,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Center(
                    child: pw.Text(
                      'BSC Computer Science',
                      style: pw.TextStyle(
                        fontSize: 20,
                        color: PdfColors.green,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Center(
                    child: pw.Text(
                      '$semesterStage Consolidated Mark Sheet',
                      style: pw.TextStyle(
                        fontSize: 20,
                        color: PdfColors.green,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 3),
                  pw.SizedBox(height: 15),
                  pw.Table(
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: const pw.FixedColumnWidth(100),
                      1: const pw.FixedColumnWidth(50),
                      for (int i = 2; i < headers.length - 2; i++)
                        i: const pw.FixedColumnWidth(50),
                      headers.length - 2: const pw.FixedColumnWidth(100),
                      headers.length - 1: const pw.FixedColumnWidth(100),
                    },
                    children: [
                      pw.TableRow(
                        children: headers
                            .map((header) => pw.Padding(
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Text(
                                    header,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      ...data.map((row) => pw.TableRow(
                            children: row
                                .map((cell) => pw.Padding(
                                      padding: const pw.EdgeInsets.all(8),
                                      child: pw.Text(cell.toString()),
                                    ))
                                .toList(),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return transcript;
  }

  String? transcriptPath;
  late PDFViewController pdfViewController;
  int? pageCount;
  int? currentPage;
  void setPdfPath(String path) {
    transcriptPath = path;
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

  //navigate to Trancript view
  void navigateToConsolidatedMarksView() async {
    await _navigationService.navigateToMyTrancriptsView(
      transcriptPath: transcriptPath,
      nameForAppBar: "Consolidated Marks Sheet",
    );
  }
}
