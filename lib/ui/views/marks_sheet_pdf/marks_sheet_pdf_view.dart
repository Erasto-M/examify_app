import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import 'marks_sheet_pdf_viewmodel.dart';

class MarksSheetPdfView extends StackedView<MarksSheetPdfViewModel> {
  MarksSheetPdfView({Key? key, required this.pdfPath, required this.unitName})
      : super(key: key);
  final String? pdfPath;
  final String? unitName;

  @override
  Widget builder(
    BuildContext context,
    MarksSheetPdfViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            viewModel.navigateBack();
          },
        ),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Marks Sheet PDF',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0, bottom: 30),
          child: Column(
            children: [
              verticalSpaceSmall,
              pdfPath != null
                  ? Container(
                      margin: const EdgeInsets.only(top: 30),
                      height: 500,
                      child: PDFView(
                        filePath: pdfPath,
                        enableSwipe: true,
                        swipeHorizontal: true,
                        autoSpacing: false,
                        pageFling: false,
                        onRender: (pages) {
                          viewModel.setPageCount(pages!);
                        },
                        onViewCreated: (controller) {
                          viewModel.setPdfController(controller);
                        },
                        onPageChanged: (page, total) {
                          viewModel.setCurrentPage(page!);
                        },
                        onError: (error) {
                          throw Exception(error.toString());
                        },
                        onPageError: (page, error) {
                          throw Exception(error.toString());
                        },
                      ),
                    )
                  : Container(),
              verticalSpaceMedium,
              viewModel.isBusy
                  // ignore: prefer_const_constructors
                  ? Center(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpinKitSpinningLines(
                            color: primaryColor,
                            size: 40,
                          ),
                          horizontalSpaceSmall,
                          Text("Downloading PDF...")
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          viewModel.makePermissions();
                          viewModel.downloadPdf(
                              pdfPath: pdfPath, unitName: unitName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(
                          Icons.download_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: const Text(
                          "Download PDF",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  MarksSheetPdfViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MarksSheetPdfViewModel();
}
