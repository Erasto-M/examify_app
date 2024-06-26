import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:stacked/stacked.dart';

import 'marks_sheet_pdf_viewmodel.dart';

class MarksSheetPdfView extends StackedView<MarksSheetPdfViewModel> {
  const MarksSheetPdfView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MarksSheetPdfViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          children: [
            verticalSpaceSmall,
            viewModel.pdfPath != null
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      height: 500,
                      child: PDFView(
                        filePath: viewModel.pdfPath,
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
                    ),
                  )
                : Container()
          ],
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
