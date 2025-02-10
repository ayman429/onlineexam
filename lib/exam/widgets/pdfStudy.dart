import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../core/constant/app_color.dart';

class pdfStudy extends StatefulWidget {
  const pdfStudy({
    super.key,
    required this.value,
    required this.tipsExamAppBarTitle,
    required this.pdf,
  });
  final int value;
  final String tipsExamAppBarTitle;
  final String pdf;

  @override
  State<pdfStudy> createState() => _pdfStudyState();
}

class _pdfStudyState extends State<pdfStudy> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor3,
        surfaceTintColor: AppColor.backgroundColor3,
        shadowColor: const Color(0xFFc9d3de),
        elevation: 4,
        title: Text(
          widget.tipsExamAppBarTitle,
          style: TextStyle(
              color: AppColor.textColor1,
              fontSize: MediaQuery.sizeOf(context).width * 0.048,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.textColor3,
          ),
        ),
      ),
      body: SfPdfViewerTheme(
          data: SfPdfViewerThemeData(
              backgroundColor: widget.value == 2
                  ? Colors.white
                  : AppColor.backgroundColor1 // Colors.white,
              ),
          child: SfPdfViewer.asset(widget.pdf,
              key: _pdfViewerKey, canShowPaginationDialog: false)),
    );
  }
}
