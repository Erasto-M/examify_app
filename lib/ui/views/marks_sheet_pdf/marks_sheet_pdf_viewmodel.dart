import 'dart:io';

import 'package:examify/models/student_registered_units.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class MarksSheetPdfViewModel extends BaseViewModel {
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

  //pop back
  Future<void> navigateBack() async {
    await _navigationService.back();
  }

  //make permissions
  Future<void> makePermissions() async {
    var status = Permission.storage.status;
    if (status.isGranted == false) {
      await Permission.storage.request();
    }
  }

  //download pdf
  Future<void> downloadPdf({String? pdfPath, String? unitName}) async {
    setBusy(true);
    if (pdfPath != null) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        final directory = Platform.isAndroid
            ? await getExternalStorageDirectory()
            : await getApplicationDocumentsDirectory();
        if (directory != null) {
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final downloadDirectory = Directory('/storage/emulated/0/Download');
          if (!downloadDirectory.existsSync()) {
            downloadDirectory.createSync(recursive: true);
          }
          final path = '${downloadDirectory.path}/$unitName$timestamp.pdf';
          final file = File(pdfPath);

          try {
            await file.copy(path);
            await file.writeAsBytes(await file.readAsBytes());

            setPdfPath(path);
            print('unitName: $unitName');
            Fluttertoast.showToast(msg: "PDF downloaded successfully to $path");
            print("PDF downloaded successfully to $path");
          } catch (e) {
            print("Failed to copy file: $e");

            Fluttertoast.showToast(msg: "Failed to Download PDF");
          }
        } else {
          Fluttertoast.showToast(msg: "Failed to get directory");
          print("Failed to get directory");
        }
        setBusy(false);
      } else {
        Fluttertoast.showToast(msg: "Permission denied");
        print("Permission denied");
      }
    }
  }
}
