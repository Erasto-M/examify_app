import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
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
  // Future<void> makePermissions() async {
  //   var status = Permission.storage.status;
  //   if (status.isGranted == false) {
  //     await Permission.storage.request();
  //   }
  // }

  // //download pdf
  // Future<void> downloadPdf({String? pdfPath, String? unitName}) async {
  //   setBusy(true);
  //   if (pdfPath != null) {
  //     final status = await Permission.storage.request();
  //     if (status.isGranted) {
  //       final directory = Platform.isAndroid
  //           ? await getExternalStorageDirectory()
  //           : await getApplicationDocumentsDirectory();
  //       if (directory != null) {
  //         final timestamp = DateTime.now().millisecondsSinceEpoch;
  //         final downloadDirectory = Directory('/storage/emulated/0/Download');
  //         if (!downloadDirectory.existsSync()) {
  //           downloadDirectory.createSync(recursive: true);
  //         }
  //         final path = '${downloadDirectory.path}/$unitName$timestamp.pdf';
  //         final file = File(pdfPath);

  //         try {
  //           await file.copy(path);
  //           await file.writeAsBytes(await file.readAsBytes());

  //           setPdfPath(path);
  //           print('unitName: $unitName');
  //           Fluttertoast.showToast(msg: "PDF downloaded successfully to $path");
  //           print("PDF downloaded successfully to $path");
  //         } catch (e) {
  //           print("Failed to copy file: $e");

  //           Fluttertoast.showToast(msg: "Failed to Download PDF");
  //         }
  //       } else {
  //         Fluttertoast.showToast(msg: "Failed to get directory");
  //         print("Failed to get directory");
  //       }
  //       setBusy(false);
  //     } else {
  //       Fluttertoast.showToast(msg: "Permission denied");
  //       print("Permission denied");
  //     }
  //   }
  // }

  Future<int> getAndroidSdkVersion() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt;
    }
    return 0;
  }

  //make permissions
  Future<void> makePermissions() async {
    int sdkInt = await getAndroidSdkVersion();
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      if (sdkInt >= 33) {
        // Request specific permissions for Android 13 and above
        await Permission.photos.request();
        await Permission.mediaLibrary.request();
      } else {
        // Request legacy storage permission for Android 12 and below
        await Permission.storage.request();
      }
    }
  }

  //download pdf
 Future<void> downloadPdf({String? pdfPath, String? unitName}) async {
    await makePermissions(); // Ensure permissions are granted

    if (pdfPath != null) {
      int sdkInt = await getAndroidSdkVersion();
      PermissionStatus status;

      if (sdkInt >= 33) {
        // Check and request new permissions for Android 13+
        status = await Permission.photos.status;
      } else {
        // Check legacy storage permission
        status = await Permission.storage.status;
      }

      if (status.isGranted) {
        Directory? directory;

        // Handle storage directory based on Android version
        if (Platform.isAndroid) {
          if (sdkInt >= 29) {
            directory = await getExternalStorageDirectory(); // Scoped Storage
          } else {
            directory = Directory('/storage/emulated/0/Download'); // Legacy path
          }
        } else {
          directory = await getApplicationDocumentsDirectory();
        }

        if (directory != null) {
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final downloadDirectory = Directory(directory.path);

          if (!downloadDirectory.existsSync()) {
            downloadDirectory.createSync(recursive: true);
          }

          final path = '${downloadDirectory.path}/$unitName$timestamp.pdf';
          final file = File(pdfPath);

          try {
            await file.copy(path);
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
      } else {
        Fluttertoast.showToast(msg: "Permission denied");
        print("Permission denied");
      }
    }
  }}


