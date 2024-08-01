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
        height: 60,
        width: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
             border: Border.all(color: Colors.black12, width: 0.6),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.9),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(5)),
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
