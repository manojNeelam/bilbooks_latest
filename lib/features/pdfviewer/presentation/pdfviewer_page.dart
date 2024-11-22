import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:html_to_pdf/html_to_pdf.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../invoice/domain/usecase/get_document_usecase.dart';
// import 'package:html_to_pdf_plus/html_to_pdf_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/core/api/api_constants.dart';

@RoutePage()
class PdfviewerPage extends StatefulWidget {
  final EnumDocumentType enumPageType;
  final String id;
  final bool isPrint;
  const PdfviewerPage({
    super.key,
    required this.enumPageType,
    required this.id,
    required this.isPrint,
  });

  @override
  State<PdfviewerPage> createState() => _PdfviewerPageState();
}

class _PdfviewerPageState extends State<PdfviewerPage> {
  String pdfPath = "";
  //PdfViewerController pdfController = PdfViewerController();

  String? generatedPdfFilePath;

  @override
  void initState() {
    _getPdfContent();
    super.initState();
  }

  void _getPdfContent() async {
    final APIClient client = APIClient();
    final path = widget.enumPageType == EnumDocumentType.estimate
        ? "estimates/estimatepdf"
        : "invoices/pdf";
    final respone = await client.getRequest("${ApiConstant.mainUrl}$path",
        queryParameters: {
          "id": widget.id,
          "print": widget.isPrint ? "true" : "false"
        });
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    const targetFileName = "example-pdf";
    final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
      htmlContent: respone.data,
      printPdfConfiguration: PrintPdfConfiguration(
        targetDirectory: targetPath,
        targetName: targetFileName,
        printSize: PrintSize.A4,
        printOrientation: PrintOrientation.Portrait,
      ),
    );
    final path_ = generatedPdfFile.path;
    pdfPath = path_.replaceAll("%20", "_");

    debugPrint("pdfPath: $pdfPath");

    setState(
      () {
        generatedPdfFilePath = generatedPdfFile.path;
      },
    );
  }

  void sharePDF() async {
    if (pdfPath.isNotEmpty) {
      debugPrint("PDF Path: $pdfPath");
      await Share.shareXFiles(
        [XFile(pdfPath)],
        sharePositionOrigin: Rect.fromCircle(
          radius: MediaQuery.of(context).size.width * 0.25,
          center: const Offset(0, 0),
        ),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.enumPageType == EnumDocumentType.estimate
            ? "Estimate"
            : "Invoice"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          // IconButton(
          //     onPressed: () async {
          //       pdfPath.isNotEmpty ? await pdfController.zoomDown() : null;
          //     },
          //     icon: const Icon(
          //       Icons.zoom_out,
          //       color: AppPallete.blueColor,
          //     )),
          // IconButton(
          //     onPressed: () async {
          //       pdfPath.isNotEmpty ? await pdfController.zoomUp() : null;
          //     },
          //     icon: const Icon(
          //       Icons.zoom_in,
          //       color: AppPallete.blueColor,
          //     )),
          IconButton(
              onPressed: () async {
                sharePDF();
              },
              icon: const Icon(
                Icons.share,
                color: AppPallete.blueColor,
              ))
        ],
      ),
      body: Container(
          child: generatedPdfFilePath != null
              ? SfPdfViewer.file(File(generatedPdfFilePath!))
              : const LoadingPage(title: "Loading pdf")),
    );
  }
}
