import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

enum PdfSignatureInputMode { signature, name }

Future<Uint8List?> showPdfSignatureInputDialog(
  BuildContext context, {
  required String userName,
}) {
  return showDialog<Uint8List>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _PdfSignatureInputDialog(userName: userName),
  );
}

class _PdfSignatureInputDialog extends StatefulWidget {
  const _PdfSignatureInputDialog({required this.userName});

  final String userName;

  @override
  State<_PdfSignatureInputDialog> createState() =>
      _PdfSignatureInputDialogState();
}

class _PdfSignatureInputDialogState extends State<_PdfSignatureInputDialog> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey =
      GlobalKey<SfSignaturePadState>();

  PdfSignatureInputMode _selectedMode = PdfSignatureInputMode.signature;
  bool _hasDrawnSignature = false;
  bool _isSaving = false;

  bool get _canSave {
    switch (_selectedMode) {
      case PdfSignatureInputMode.signature:
        return _hasDrawnSignature;
      case PdfSignatureInputMode.name:
        return widget.userName.trim().isNotEmpty;
    }
  }

  Future<void> _save() async {
    if (!_canSave || _isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      Uint8List? bytes;
      switch (_selectedMode) {
        case PdfSignatureInputMode.signature:
          final image = await _signaturePadKey.currentState?.toImage(
            pixelRatio: 3,
          );
          final byteData = await image?.toByteData(
            format: ui.ImageByteFormat.png,
          );
          bytes = byteData?.buffer.asUint8List();
          break;
        case PdfSignatureInputMode.name:
          bytes = await _buildTypedNameSignature(widget.userName.trim());
          break;
      }

      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(bytes);
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _clear() {
    if (_selectedMode != PdfSignatureInputMode.signature) {
      return;
    }
    _signaturePadKey.currentState?.clear();
    setState(() {
      _hasDrawnSignature = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppPallete.white,
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 12, 0),
      title: Row(
        children: [
          Expanded(
            child: Text(
              'Add Digital Signature',
              style: AppFonts.mediumStyle(size: 20),
            ),
          ),
          IconButton(
            onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: AppPallete.k666666),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppPallete.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppPallete.itemDividerColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _selectedMode == PdfSignatureInputMode.signature
                    ? SfSignaturePad(
                        key: _signaturePadKey,
                        backgroundColor: AppPallete.white,
                        strokeColor: AppPallete.black,
                        onDrawEnd: () {
                          if (_hasDrawnSignature) {
                            return;
                          }
                          setState(() {
                            _hasDrawnSignature = true;
                          });
                        },
                      )
                    : _TypedNamePreview(name: widget.userName.trim()),
              ),
            ),
            const SizedBox(height: 12),
            _ModeTabBar(
              selectedMode: _selectedMode,
              onModeChanged: (mode) {
                setState(() {
                  _selectedMode = mode;
                });
              },
            ),
            const SizedBox(height: 10),
            Text(
              _selectedMode == PdfSignatureInputMode.signature
                  ? 'Draw your signature.'
                  : 'Your logged in user name will be used as the signature image.',
              style: AppFonts.regularStyle(
                size: 14,
                color: AppPallete.k666666,
              ),
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      actions: [
        TextButton(
          onPressed: (_selectedMode == PdfSignatureInputMode.signature &&
                  _hasDrawnSignature &&
                  !_isSaving)
              ? _clear
              : null,
          child: Text(
            'Clear',
            style: AppFonts.buttonTextStyle(),
          ),
        ),
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: AppFonts.buttonTextStyle(color: AppPallete.k666666),
          ),
        ),
        ElevatedButton(
          onPressed: _canSave && !_isSaving ? _save : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPallete.blueColor,
            foregroundColor: AppPallete.white,
            disabledBackgroundColor: AppPallete.blueColor50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: _isSaving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  'Save',
                  style: AppFonts.buttonTextStyle(color: AppPallete.white),
                ),
        ),
      ],
    );
  }
}

class _ModeTabBar extends StatelessWidget {
  const _ModeTabBar({
    required this.selectedMode,
    required this.onModeChanged,
  });

  final PdfSignatureInputMode selectedMode;
  final ValueChanged<PdfSignatureInputMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _BottomModeButton(
          title: 'Signature',
          isSelected: selectedMode == PdfSignatureInputMode.signature,
          onTap: () => onModeChanged(PdfSignatureInputMode.signature),
        ),
        const SizedBox(width: 28),
        _BottomModeButton(
          title: 'Name',
          isSelected: selectedMode == PdfSignatureInputMode.name,
          onTap: () => onModeChanged(PdfSignatureInputMode.name),
        ),
      ],
    );
  }
}

class _BottomModeButton extends StatelessWidget {
  const _BottomModeButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppFonts.mediumStyle(
                size: 15,
                color: isSelected ? AppPallete.blueColor : AppPallete.k666666,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              height: 3,
              width: 74,
              decoration: BoxDecoration(
                color: isSelected ? AppPallete.blueColor : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypedNamePreview extends StatelessWidget {
  const _TypedNamePreview({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    if (name.isEmpty) {
      return Center(
        child: Text(
          'Logged in user name is unavailable.',
          style: AppFonts.regularStyle(color: AppPallete.k666666),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: AspectRatio(
          aspectRatio: 3.2,
          child: CustomPaint(
            painter: _HandwrittenSignaturePainter(name: name),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

Future<Uint8List> _buildTypedNameSignature(String name) async {
  const canvasSize = Size(900, 280);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  final backgroundPaint = Paint()..color = Colors.white;
  canvas.drawRect(Offset.zero & canvasSize, backgroundPaint);

  _paintHandwrittenSignature(
    canvas: canvas,
    size: canvasSize,
    name: name,
  );

  final picture = recorder.endRecording();
  final image = await picture.toImage(
    canvasSize.width.toInt(),
    canvasSize.height.toInt(),
  );
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return bytes!.buffer.asUint8List();
}

class _HandwrittenSignaturePainter extends CustomPainter {
  const _HandwrittenSignaturePainter({required this.name});

  final String name;

  @override
  void paint(Canvas canvas, Size size) {
    _paintHandwrittenSignature(
      canvas: canvas,
      size: size,
      name: name,
    );
  }

  @override
  bool shouldRepaint(covariant _HandwrittenSignaturePainter oldDelegate) {
    return oldDelegate.name != name;
  }
}

void _paintHandwrittenSignature({
  required Canvas canvas,
  required Size size,
  required String name,
}) {
  if (name.trim().isEmpty) {
    return;
  }

  final textPainter = _createTextPainter(name, size);
  final baseOffset = Offset(
    (size.width - textPainter.width) / 2,
    math.max(12, (size.height - textPainter.height) / 2 - 8),
  );

  canvas.save();
  canvas.translate(baseOffset.dx + (textPainter.width / 2),
      baseOffset.dy + (textPainter.height / 2));
  canvas.rotate(-0.055);
  canvas.skew(-0.18, 0);
  canvas.translate(
    -(textPainter.width / 2),
    -(textPainter.height / 2),
  );

  final shadowPainter = _createTextPainter(
    name,
    size,
    color: Colors.black.withValues(alpha: 0.16),
  );
  shadowPainter.paint(canvas, const Offset(3, 5));

  final softInkPainter = _createTextPainter(
    name,
    size,
    color: const Color(0xFF2A2A2A).withValues(alpha: 0.45),
  );
  softInkPainter.paint(canvas, const Offset(1.5, 1.5));

  textPainter.paint(canvas, Offset.zero);

  final flourishPaint = Paint()
    ..color = const Color(0xFF191919).withValues(alpha: 0.82)
    ..strokeWidth = math.max(2, size.height * 0.012)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  final flourishPath = Path()
    ..moveTo(textPainter.width * 0.04, textPainter.height * 0.88)
    ..quadraticBezierTo(
      textPainter.width * 0.40,
      textPainter.height * 1.05,
      textPainter.width * 0.78,
      textPainter.height * 0.92,
    )
    ..quadraticBezierTo(
      textPainter.width * 0.96,
      textPainter.height * 0.86,
      textPainter.width * 1.04,
      textPainter.height * 0.98,
    );

  canvas.drawPath(flourishPath, flourishPaint);
  canvas.restore();
}

TextPainter _createTextPainter(
  String name,
  Size size, {
  Color color = Colors.black,
}) {
  final fontSize = _resolveFontSize(name, size);
  final textPainter = TextPainter(
    text: TextSpan(
      text: name,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'AktivGrotesk',
        fontStyle: FontStyle.italic,
        letterSpacing: 0.4,
        height: 0.95,
      ),
    ),
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
    maxLines: 2,
  );
  textPainter.layout(maxWidth: size.width * 0.82);
  return textPainter;
}

double _resolveFontSize(String name, Size size) {
  final shortestSide = math.min(size.width, size.height);
  double fontSize = shortestSide * 0.34;

  while (fontSize > 34) {
    final painter = TextPainter(
      text: TextSpan(
        text: name,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          fontFamily: 'AktivGrotesk',
          fontStyle: FontStyle.italic,
          letterSpacing: 0.4,
          height: 0.95,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 2,
    )..layout(maxWidth: size.width * 0.82);

    if (painter.width <= size.width * 0.82 && painter.height <= size.height) {
      return fontSize;
    }

    fontSize -= 4;
  }

  return 34;
}
