import 'package:cloud_firestore/cloud_firestore.dart';
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
  pw.Document generateTranscript(
      {required List<StudentsRegisteredUnitsModel> students,
      required String semesterStage,
      required String meanGrade,
      required String recommendation,
      required double meanScore}) {
    final transcript = pw.Document();

    transcript.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 1),
                color: PdfColors.white,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 3),
                  pw.Center(
                    child: pw.Text(
                      'DEDAN KIMATHI UNIVERSITY OF TECHNOLOGY',
                      style: pw.TextStyle(
                        fontSize: 18,
                        color: PdfColors.black,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Center(
                    child: pw.Text(
                      'PROVISIONAL UNDERGRADUATE ACADEMIC TRANSCRIPT',
                      style: const pw.TextStyle(
                        fontSize: 15,
                        color: PdfColors.black,
                      ),
                    ),
                  ),
                  _buildStudentInfoSection(students, semesterStage),

                  pw.NewPage(), // Force page break before table
                  _buildUnitsTable(students),

                  pw.NewPage(), // Force page break before grading system
                  _buildMeanAndRecommendationSection(
                      meanScore, meanGrade, recommendation),
                  _buildGradingSystemSection(),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return transcript;
  }

  pw.Widget _buildStudentInfoSection(
      List<StudentsRegisteredUnitsModel> students, String semesterStage) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 1),
      ),
      child: pw.Padding(
        padding: pw.EdgeInsets.all(10),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(children: [
              pw.Text('Name: ${students[0].studentName!}'),
              pw.Spacer(),
              pw.Text('RegNo: ${students[0].studentRegNo!}'),
            ]),
            pw.SizedBox(height: 5),
            pw.Text('School: Computer Science and Information Technology'),
            pw.SizedBox(height: 5),
            pw.Text('Degree: Bachelor of Science in Computer Science'),
            pw.SizedBox(height: 5),
            pw.Row(children: [
              pw.Text('Academic Year: 2024/2025'),
              pw.Spacer(),
              pw.Text('Year of Study: $semesterStage'),
            ]),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildUnitsTable(List<StudentsRegisteredUnitsModel> students) {
    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(),
      cellHeight: 20,
      cellStyle: const pw.TextStyle(fontSize: 14),
      headerStyle: pw.TextStyle(
        fontSize: 16,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.black,
      ),
      headers: ['UnitsCode', 'UnitName', 'Grade'],
      data: students.map((student) {
        return [
          student.unitCode,
          student.unitName,
          student.grade,
        ];
      }).toList(),
    );
  }

  pw.Widget _buildMeanAndRecommendationSection(
      double meanScore, String meanGrade, String recommendation) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 1),
      ),
      child: pw.Padding(
        padding: pw.EdgeInsets.all(10),
        child: pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text('MeanScore: $meanScore'),
                pw.SizedBox(width: 10),
                pw.Text('MeanGrade: $meanGrade'),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Text('Recommendation: $recommendation'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildGradingSystemSection() {
    return pw.Container(
      padding: pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 1),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'KEY TO THE GRADING SYSTEM',
            style: pw.TextStyle(
              color: PdfColors.black,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 15),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(children: [
                pw.Text('A: 70-100%'),
                pw.SizedBox(width: 70),
                pw.Text('Excellent'),
              ]),
              pw.Row(children: [
                pw.Text('B: 60-69%'),
                pw.SizedBox(width: 80),
                pw.Text('Good'),
              ]),
              pw.Row(children: [
                pw.Text('C: 50-59%'),
                pw.SizedBox(width: 80),
                pw.Text('Satisfactory'),
              ]),
              pw.Row(children: [
                pw.Text('D: 40-49%'),
                pw.SizedBox(width: 80),
                pw.Text('Pass'),
              ]),
              pw.Row(children: [
                pw.Text('E: 0-39%'),
                pw.SizedBox(width: 80),
                pw.Text('Fail'),
              ]),
              pw.Row(children: [
                pw.Text('iNC'),
                pw.SizedBox(width: 110),
                pw.Text('Incomplete'),
              ]),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Text('Each full unit takes 35 hours of study time.'),
          pw.SizedBox(height: 20),
          pw.Text('Signed  ...........................................'),
          pw.SizedBox(height: 10),
          pw.Text('Dean , Computer Science and Information Technology'),
        ],
      ),
    );
  }

//navigate to Trancript view
  void navigateToTrancscriptView() async {
    await _navigationService.navigateToMyTrancriptsView(
      transcriptPath: transcriptPath,
      nameForAppBar: 'My Transcript',
    );
  }

  //navigate back
  Future<void> navigateBack() async {
    _navigationService.back();
  }

  //Navigate to apply special Exam
  Future<void> navigateToApplySpecialExam(
      {required String semesterStage}) async {
    await _navigationService.navigateToApplySpecialExamView(
        semesterStage: semesterStage);
    notifyListeners();
  }

  double calculateMeanScore(List<StudentsRegisteredUnitsModel> units) {
    double totalMarks =
        units.fold(0, (sum, unit) => sum + (unit.totalMarks ?? 0));
    double meanScore = totalMarks / units.length;
    return double.parse(meanScore.toStringAsFixed(2));
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

  // look whether a student has any special exams
  bool hasSpecialExams(List<StudentsRegisteredUnitsModel> units) {
    return units.any((unit) => unit.appliedSpecialExam == true);
  }
    Stream<DocumentSnapshot?> getReportsAvailabilityStatus(
      String selectedSemester) {
    return FirebaseFirestore.instance
        .collection('academic_reports_availability')
        .doc('1YqKYQDE7I7cJGNQEzE8')
        .snapshots();
  }
}
