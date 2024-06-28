import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import 'my_trancripts_viewmodel.dart';

class MyTrancriptsView extends StackedView<MyTrancriptsViewModel> {
  MyTrancriptsView({Key? key, required this.transcriptPath}) : super(key: key);
  final String? transcriptPath;
  @override
  Widget builder(
    BuildContext context,
    MyTrancriptsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            viewModel.navigateBack();
          },
        ),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'My Trancripts',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 30),
          child: Column(
            children: [
              verticalSpaceSmall,
              transcriptPath != null
                  ? Container(
                      margin: const EdgeInsets.only(top: 30),
                      height: 500,
                      child: PDFView(
                        filePath: transcriptPath,
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
                          print(error.toString());
                        },
                        onPageError: (page, error) {
                          print('$page : ${error.toString()}');
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
                          Text("Downloading Transcript PDF...")
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
                            pdfPath: transcriptPath,
                          );
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
  MyTrancriptsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MyTrancriptsViewModel();
}
