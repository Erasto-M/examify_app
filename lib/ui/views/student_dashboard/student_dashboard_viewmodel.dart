import 'package:examify/app/app.bottomsheets.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/services/student_dashboard_service.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentDashboardViewModel extends BaseViewModel {
  final _studentDashboardService = locator<StudentDashboardService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  void showRegisterUnitBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.studentRegisterUnit,
    );
  }

  Stream<List<StudentsRegisteredUnitsModel>> fetchMyUnits() {
    return _studentDashboardService.fetchAllMyUnits(
        semesterStage: getSelectedSemesterStageForCourses);
  }

  Stream<List<StudentsRegisteredUnitsModel>> fetchMyUnits2() {
    return _studentDashboardService.fetchAllMyUnits2(
        semesterStage: getSelectedSemesterStageForCourses);
  }

  String _greeting = '';

  String get greeting => _greeting;

  StudentDashboardViewModel() {
    _updateGreeting();
    getCurrentUserDetails();
  }

  void _updateGreeting() {
    DateTime now = DateTime.now();
    _greeting = getGreeting(now);
    notifyListeners(); // Notify the UI that the greeting has changed
  }

  String getGreeting(DateTime now) {
    if (now.hour < 12) {
      return 'Good Morning';
    } else if (now.hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> get user => userDetails;
  Future getCurrentUserDetails() async {
    userDetails = await _authenticationService.getCurrentUserDetails();
    notifyListeners();
  }

  // semester stages For Courses
  String _selectedSemesterStageForCourses = 'Y1S1';
  String get getSelectedSemesterStageForCourses =>
      _selectedSemesterStageForCourses;
  void setSelectedSemesterStageForCourses(String value) {
    _selectedSemesterStageForCourses = value;
    notifyListeners();
  }

  //Semester stages for Transcripts
  String _selectedSemesterStageForTranscripts = 'Y1S1';
  String get getSelectedSemesterStageForTranscripts =>
      _selectedSemesterStageForTranscripts;
  void setSelectedSemesterStageForTranscripts(String value) {
    _selectedSemesterStageForTranscripts = value;
    notifyListeners();
  }

  // semester stages list
  List<String> semesterStages = [
    'Y1S1',
    'Y1S2',
    'Y1',
    'Y2S1',
    'Y2S2',
    'Y2',
    'Y3S1',
    'Y3S2',
    'Y3',
    'Y4S1',
    'Y4S2',
    'Y4',
  ];
//transcript path
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

  //Generate Trancripts
  pw.Document generateTrancript(
      {required List<StudentsRegisteredUnitsModel> students,
      required String semesterStage,
      required String meanGrade,
      required String recommendation,
      required double meanScore}) {
    final transcript = pw.Document();
    transcript.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
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
                            child: pw.Text('$semesterStage Transcript',
                                style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                          ),
                          pw.SizedBox(height: 15),
                          pw.Container(
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                  width: 1,
                                ),
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(height: 10),
                                  pw.Row(children: [
                                    pw.SizedBox(width: 20),
                                    pw.Text('Name: '),
                                    pw.SizedBox(width: 20),
                                    pw.Text(students[0].studentName!),
                                  ]),
                                  pw.SizedBox(height: 5),
                                  pw.Row(children: [
                                    pw.SizedBox(width: 20),
                                    pw.Text('RegNo: '),
                                    pw.SizedBox(width: 20),
                                    pw.Text(students[0].studentPhoneNumber!),
                                  ]),
                                  pw.SizedBox(height: 5),
                                  pw.Row(children: [
                                    pw.SizedBox(width: 20),
                                    pw.Text('Email: '),
                                    pw.SizedBox(width: 20),
                                    pw.Text(students[0].studentEmail!),
                                  ]),
                                  pw.SizedBox(height: 5),
                                  pw.Row(children: [
                                    pw.SizedBox(width: 20),
                                    pw.Text('Phone: '),
                                    pw.SizedBox(width: 20),
                                    pw.Text(students[0].studentPhoneNumber!),
                                  ]),
                                  pw.SizedBox(height: 20),
                                  pw.TableHelper.fromTextArray(
                                      border: pw.TableBorder.all(),
                                      cellHeight: 20,
                                      cellStyle: const pw.TextStyle(
                                        fontSize: 14,
                                      ),
                                      headerStyle: pw.TextStyle(
                                          fontSize: 16,
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColors.black),
                                      headers: [
                                        'UnitsCode',
                                        'UnitName',
                                        'TotalMarks',
                                        'Grade',
                                      ],
                                      data: students.map((student) {
                                        return [
                                          student.unitCode,
                                          student.unitName,
                                          student.totalMarks.toString(),
                                          student.grade,
                                        ];
                                      }).toList()),
                                  pw.Container(
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: PdfColors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: pw.Column(children: [
                                      pw.SizedBox(height: 20),
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                          pw.Center(
                                              child: pw.Text('MeanScore:')),
                                          pw.SizedBox(width: 10),
                                          pw.Center(
                                              child: pw.Text(
                                                  meanScore.toString())),
                                          pw.SizedBox(width: 10),
                                          pw.Center(
                                              child: pw.Text('MeanGrade:')),
                                          pw.SizedBox(width: 10),
                                          pw.Center(child: pw.Text(meanGrade)),
                                        ],
                                      ),
                                      pw.SizedBox(height: 10),
                                    ]),
                                  ),
                                  pw.Container(
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: PdfColors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: pw.Column(children: [
                                      pw.SizedBox(height: 20),
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                          pw.Center(
                                              child:
                                                  pw.Text('Reccommendation:')),
                                          pw.SizedBox(width: 10),
                                          pw.Center(
                                              child: pw.Text(recommendation)),
                                        ],
                                      ),
                                      pw.SizedBox(height: 10),
                                    ]),
                                  ),
                                ],
                              ))
                        ])),
              ]);
        },
      ),
    );
    return transcript;
  }

  //navigate to Trancript view
  void navigateToTrancscriptView() async {
    await _navigationService.navigateToMyTrancriptsView(
      transcriptPath: transcriptPath,
    );
  }

  //navigate back
  Future<void> navigateBack() async {
    _navigationService.back();
  }

  //Navigate to apply special Exam
  Future<void> navigateToApplySpecialExam() async {
    await _navigationService.navigateToApplySpecialExamView();
    notifyListeners();
  }

  double calculateMeanScore(List<StudentsRegisteredUnitsModel> units) {
    double totalMarks = units.fold(0, (sum, unit) => sum + unit.totalMarks!);
    return totalMarks / units.length;
  }

  String calculateMeanGrade(double meanScore) {
    if (meanScore >= 70) return 'A';
    if (meanScore >= 60) return 'B';
    if (meanScore >= 50) return 'C';
    if (meanScore >= 40) return 'D';
    if (meanScore >= 0 && meanScore <= 39) return 'E';
    return 'No Grade';
  }

  String getRecommendation(String meanGrade) {
    if (meanGrade == 'A' || meanGrade == 'B' || meanGrade == 'C') return 'Pass';
    return 'Fail';
  }
}
