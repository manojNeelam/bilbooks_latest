import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/utils/hive_functions.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:html_to_pdf/html_to_pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../invoice/domain/usecase/get_document_usecase.dart';
import 'widgets/pdf_signature_input_dialog.dart';
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
  final PdfViewerController _pdfViewerController = PdfViewerController();

  String? generatedPdfFilePath;
  String _currentUserName = "";
  bool _isSignatureDialogOpen = false;

  @override
  void initState() {
    _getPdfContent();
    _loadCurrentUserName();
    super.initState();
  }

  Future<void> _loadCurrentUserName() async {
    final session = await HiveFunctions.getUserSessionData();
    final user = session?.user;
    final resolvedName = (user?.name ?? '').trim().isNotEmpty
        ? (user?.name ?? '').trim()
        : (user?.firstname ?? '').trim().isNotEmpty
            ? (user?.firstname ?? '').trim()
            : (user?.email ?? '').trim();

    if (!mounted) {
      return;
    }

    setState(() {
      _currentUserName = resolvedName;
    });
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
    if (generatedPdfFilePath != null) {
      final file = await _getShareablePdfFile();
      await Share.shareXFiles(
        [XFile(file.path)],
        sharePositionOrigin: Rect.fromCircle(
          radius: MediaQuery.of(context).size.width * 0.25,
          center: const Offset(0, 0),
        ),
      );
    }
  }

  Future<File> _getShareablePdfFile() async {
    final file = File(generatedPdfFilePath!);
    try {
      final savedBytes = await _pdfViewerController.saveDocument(
        flattenOption: PdfFlattenOption.formFields,
      );
      await file.writeAsBytes(savedBytes, flush: true);
      pdfPath = file.path;
      return file;
    } catch (_) {
      return file;
    }
  }

  Future<void> _handleFormFieldFocusChange(
    PdfFormFieldFocusChangeDetails details,
  ) async {
    if (!details.hasFocus || _isSignatureDialogOpen) {
      return;
    }

    final field = details.formField;
    if (field is! PdfSignatureFormField || field.readOnly) {
      return;
    }

    _isSignatureDialogOpen = true;
    try {
      final signatureBytes = await showPdfSignatureInputDialog(
        context,
        userName: _currentUserName,
      );

      if (signatureBytes != null) {
        field.signature = signatureBytes;
      }
    } finally {
      _isSignatureDialogOpen = false;
    }
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
              ? SfPdfViewer.file(
                  File(generatedPdfFilePath!),
                  controller: _pdfViewerController,
                  canShowSignaturePadDialog: false,
                  onFormFieldFocusChange: _handleFormFieldFocusChange,
                )
              : const LoadingPage(title: "Loading pdf")),
    );
  }
}
