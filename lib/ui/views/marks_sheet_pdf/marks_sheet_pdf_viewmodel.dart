import 'package:examify/models/student_registered_units.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:stacked/stacked.dart';

class MarksSheetPdfViewModel extends BaseViewModel {
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
                        fontSize: 20, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.TableHelper.fromTextArray(
                  border: pw.TableBorder.all(),
                  headers: [
                    'RegNo',
                    'Name',
                    'Assigment1',
                    'Assigment2',
                    'CAT1 Marks',
                    'CAT2 Marks',
                    'Exam Marks',
                    'Total Marks',
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
                )
              ]);
        },
      ),
    );
    return pdf;
  }
}
