import 'dart:io';
import 'dart:typed_data';

import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

import 'item_separator.dart';

class AppImagePickerField extends StatefulWidget {
  final String title;
  final bool isRequired;
  final bool showDivider;
  final double maxFileSizeInMb;
  final String selectFileText;
  final String? helperText;
  final File? initialImage;
  final String? initialImageUrl;
  final ValueChanged<File?>? onChanged;

  const AppImagePickerField({
    super.key,
    required this.title,
    this.isRequired = false,
    this.showDivider = true,
    this.maxFileSizeInMb = 2,
    this.selectFileText = 'Select file',
    this.helperText,
    this.initialImage,
    this.initialImageUrl,
    this.onChanged,
  });

  @override
  State<AppImagePickerField> createState() => _AppImagePickerFieldState();
}

class _AppImagePickerFieldState extends State<AppImagePickerField> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  Uint8List? _previewBytes;
  bool _isLoadingPreview = false;
  bool _isInitialImageRemoved = false;

  bool get _supportsImagePicker => Platform.isIOS || Platform.isAndroid;
  bool get _hasInitialImageUrl =>
      !_isInitialImageRemoved && (widget.initialImageUrl?.isNotEmpty ?? false);

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
    _loadPreview();
  }

  @override
  void didUpdateWidget(covariant AppImagePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final hasImageChanged =
        oldWidget.initialImage?.path != widget.initialImage?.path;
    final hasImageUrlChanged =
        oldWidget.initialImageUrl != widget.initialImageUrl;
    if (hasImageChanged || hasImageUrlChanged) {
      _selectedImage = widget.initialImage;
      if (hasImageUrlChanged) {
        _isInitialImageRemoved = false;
      }
      _loadPreview();
    }
  }

  String get _resolvedHelperText {
    if (widget.helperText != null && widget.helperText!.isNotEmpty) {
      return widget.helperText!;
    }
    final maxSize = widget.maxFileSizeInMb % 1 == 0
        ? widget.maxFileSizeInMb.toStringAsFixed(0)
        : widget.maxFileSizeInMb.toStringAsFixed(1);
    return '.jpeg, .jpg, .png, .gif (Max file size ${maxSize}MB)';
  }

  Future<void> _loadPreview() async {
    if (_selectedImage == null) {
      if (!mounted) {
        return;
      }
      setState(() {
        _previewBytes = null;
        _isLoadingPreview = false;
      });
      return;
    }

    setState(() {
      _isLoadingPreview = true;
    });

    final bytes = await _selectedImage!.readAsBytes();
    if (!mounted) {
      return;
    }

    setState(() {
      _previewBytes = bytes;
      _isLoadingPreview = false;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    Navigator.of(context).maybePop();

    final image = await _imagePicker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (image == null) {
      return;
    }

    final maxFileSizeInBytes = (widget.maxFileSizeInMb * 1024 * 1024).round();
    final file = File(image.path);
    final selectedFileSizeInBytes = await file.length();

    if (selectedFileSizeInBytes > maxFileSizeInBytes) {
      if (!mounted) {
        return;
      }
      showToastification(
        context,
        'Please select an image smaller than ${widget.maxFileSizeInMb.toStringAsFixed(widget.maxFileSizeInMb % 1 == 0 ? 0 : 1)}MB',
        ToastificationType.error,
      );
      return;
    }

    _selectedImage = file;
    _isInitialImageRemoved = false;
    widget.onChanged?.call(file);
    await _loadPreview();
  }

  void _removeImage() {
    Navigator.of(context).maybePop();
    setState(() {
      _selectedImage = null;
      _previewBytes = null;
      _isLoadingPreview = false;
      _isInitialImageRemoved = true;
    });
    widget.onChanged?.call(null);
  }

  Future<void> _showImagePickerOptions() async {
    if (!_supportsImagePicker) {
      showToastification(
        context,
        'Image picker is available only on iOS and Android builds.',
        ToastificationType.error,
      );
      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(
                  'Take picture',
                  style: AppFonts.regularStyle(),
                ),
                onTap: () {
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(
                  'Choose from gallery',
                  style: AppFonts.regularStyle(),
                ),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (_selectedImage != null || _hasInitialImageUrl)
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline,
                    color: AppPallete.red,
                  ),
                  title: Text(
                    'Remove image',
                    style: AppFonts.regularStyle(color: AppPallete.red),
                  ),
                  onTap: _removeImage,
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: AppFonts.regularStyle(),
                        text: widget.title,
                        children: [
                          if (widget.isRequired)
                            TextSpan(
                              text: ' *',
                              style: AppFonts.regularStyle()
                                  .copyWith(color: AppPallete.red),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: InkWell(
                      onTap: _showImagePickerOptions,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(minHeight: 132),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppPallete.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppPallete.itemDividerColor,
                          ),
                        ),
                        child: _selectedImage != null || _hasInitialImageUrl
                            ? _buildSelectedState()
                            : _buildEmptyState(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (widget.showDivider) const ItemSeparator(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: AppPallete.lightBlueColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.attach_file_rounded,
            size: 28,
            color: AppPallete.blueColor,
          ),
        ),
        AppConstants.sizeBoxWidth15,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.selectFileText,
                style: AppFonts.mediumStyle(
                  size: 18,
                  color: AppPallete.blueColor,
                ),
              ),
              AppConstants.sizeBoxHeight10,
              Text(
                _resolvedHelperText,
                style: AppFonts.regularStyle(color: AppPallete.k666666),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedState() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 88,
            height: 88,
            child: _buildPreview(),
          ),
        ),
        AppConstants.sizeBoxWidth15,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _selectedImage != null
                    ? _selectedImage!.path.split(Platform.pathSeparator).last
                    : 'Current image',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.mediumStyle(size: 16),
              ),
              AppConstants.sizeBoxHeight10,
              Text(
                _resolvedHelperText,
                style: AppFonts.regularStyle(color: AppPallete.k666666),
              ),
              AppConstants.sizeBoxHeight10,
              Text(
                'Tap to change or remove',
                style: AppFonts.regularStyle(
                  size: 14,
                  color: AppPallete.blueColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreview() {
    if (_isLoadingPreview) {
      return const ColoredBox(
        color: AppPallete.kF2F2F2,
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (_previewBytes != null) {
      return Image.memory(
        _previewBytes!,
        fit: BoxFit.cover,
      );
    }

    if (_hasInitialImageUrl) {
      return Image.network(
        widget.initialImageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPreviewFallback();
        },
      );
    }

    return _buildPreviewFallback();
  }

  Widget _buildPreviewFallback() {
    return const ColoredBox(
      color: AppPallete.kF2F2F2,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: AppPallete.borderColor,
        ),
      ),
    );
  }
}
