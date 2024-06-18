import 'package:examify/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'transcripts_model.dart';

class Transcripts extends StackedView<TranscriptsModel> {
  const Transcripts({super.key, required this.yearName});

  final String yearName;

  @override
  Widget builder(
    BuildContext context,
    TranscriptsModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () {
        viewModel.navigateToTranscriptDetails(yearName: yearName);
      },
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Row(
            children: [
              Text(
                yearName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  TranscriptsModel viewModelBuilder(
    BuildContext context,
  ) =>
      TranscriptsModel();
}
