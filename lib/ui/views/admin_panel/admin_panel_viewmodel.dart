import 'package:examify/app/app.router.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication_service.dart';
import '../../../services/cod_dashboard_service.dart';

class AdminPanelViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _adminDashBoard = locator<AdminDashboardService>();
  void navigateToRegisterNewUser() {
    _navigationService.navigateToRegisterView();
  }

  Future navigateToManageSpecialExams() async {
    _navigationService.navigateToCodSpecialExamsView();
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

  void navigateToApproveStudentUnits() {
    _navigationService.navigateToCodApproveUnitsView();
  }

  //Generate Graduation List


pw.Document generateGraduationList({
  required List<StudentsRegisteredUnitsModel> students,
  required String cohort,
}) {
  final transcript = pw.Document();

  // Headers for the table
  final headers = [
    'Reg No',
    'Name',
    'Mean Grade',
  ];

  // Data rows for each student
  final data = students.map((student) {
    return [
      student.studentRegNo,
      student.studentName,
      student.meanGrade,
    ];
  }).toList();

  // Create PDF content
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
                    '$cohort Graduation List',
                    style: pw.TextStyle(
                      fontSize: 20,
                      color: PdfColors.green,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(100),
                    1: const pw.FixedColumnWidth(100),
                    2: const pw.FixedColumnWidth(100),
                    3: const pw.FixedColumnWidth(100),
                  },
                  children: [
                    // Table headers
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
                    // Table rows
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

  //navigate to Graduation List view
  void navigateToGraduationListView() async {
    await _navigationService.navigateToMyTrancriptsView(
      transcriptPath: transcriptPath,
      nameForAppBar: "Graduation List Class of 2024",
    );
  }

  //GraduationList Stream
  Stream<List<StudentsRegisteredUnitsModel>> getGraduationList({
    required String cohort,
  }) {
    return _adminDashBoard
        .fetchGraduationList(cohort: cohort)
        .map((studentUnits) {
      final graduationList = <String, List<StudentsRegisteredUnitsModel>>{};

      // Collect all student UIDs who have an 'E' grade or missing marks or applied for a special exam
      final excludedStudents = <String>{};

      for (var unit in studentUnits) {
        if (unit.grade == 'E' ||
            unit.assignMent1Marks == null ||
            unit.assignMent2Marks == null ||
            unit.cat1Marks == null ||
            unit.cat2Marks == null ||
            unit.examMarks == null ||
            unit.totalMarks == null ||
            unit.appliedSpecialExam == true) {
          excludedStudents.add(unit.studentUid!);
        }
      }
 print('excludedStudents: $excludedStudents');
      // Filter out students who are in the excluded list
      for (var unit in studentUnits) {
        if (!excludedStudents.contains(unit.studentUid)) {
          graduationList.putIfAbsent(unit.studentUid!, () => []).add(unit);
        }
      }
      print('graduationList: $graduationList');
      final graduationClassifications = <StudentsRegisteredUnitsModel>[];
      //calculate the mean marks , mean grade , and classify  the students
      graduationList.forEach((studentUid, units) {
        final totalMarks =
            units.fold(0, (sum, unit) => sum + (unit.totalMarks ?? 0));
        //mean marks  to 2 decimal places
        final meanMarks =
            double.parse((totalMarks / units.length).toStringAsFixed(2));
        final studentName = units.first.studentName;
        final regNo = units.first.studentRegNo;

        //determine meanGrade classification
        String meangrade;
        if (meanMarks >= 70 && meanMarks <= 100) {
          meangrade = 'First Class Honors';
        } else if (meanMarks >= 60) {
          meangrade = 'Second Class Honors. Upper Division';
        } else if (meanMarks >= 50) {
          meangrade = 'Second Class Honors. Lower Division';
        } else if (meanMarks >= 40) {
          meangrade = 'Pass';
        } else {
          meangrade = 'Fail';
        }
        //add the classification to the graduationClassifications list
        graduationClassifications.add(StudentsRegisteredUnitsModel(
            studentUid: studentUid,
            meanGrade: meangrade,
            meanMarks: meanMarks,
            studentName: studentName!,
            studentRegNo: regNo!));
      });

      return graduationClassifications;
    });
  }
}

