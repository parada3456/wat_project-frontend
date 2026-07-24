import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class PaymentSubmissionPage extends StatefulWidget {
  final String expenseId;
  final String splitId;
  const PaymentSubmissionPage({
    super.key,
    required this.expenseId,
    required this.splitId,
  });

  @override
  State<PaymentSubmissionPage> createState() => _PaymentSubmissionPageState();
}

class _PaymentSubmissionPageState extends State<PaymentSubmissionPage> {
  File? _selectedFile;
  bool _isUploading = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() {
          _selectedFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      AppPopup.show<void>(
        context: context,
        type: AppPopupType.error,
        title: 'Error',
        message: 'Failed to select image: $e',
        buttons: [
          AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(context)),
        ],
      );
    }
  }

  void _clearImage() {
    setState(() {
      _selectedFile = null;
    });
  }

  void _submit() {
    if (_selectedFile == null) {
      AppPopup.show<void>(
        context: context,
        type: AppPopupType.warning,
        title: 'Required',
        message: 'Please select or capture a payment receipt slip.',
        buttons: [
          AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(context)),
        ],
      );
      return;
    }

    setState(() => _isUploading = true);

    context.read<ExpenseSharingBloc>().add(
          ExpenseSharingEvent.payExpenseSplitSubmitted(
            expenseId: widget.expenseId,
            splitId: widget.splitId,
            file: _selectedFile!,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExpenseSharingBloc>(
      create: (context) => getIt<ExpenseSharingBloc>(),
      child: BlocListener<ExpenseSharingBloc, ExpenseSharingState>(
        listener: (context, state) {
          state.whenOrNull(
            payExpenseSplitSuccess: () {
              setState(() => _isUploading = false);
              AppPopup.show<void>(
                context: context,
                type: AppPopupType.success,
                title: 'Success',
                message: 'Payment proof submitted successfully.',
                buttons: [
                  AppPopupButton(
                    label: 'OK',
                    onPressed: () {
                      Navigator.pop(context); // pop dialog
                      Navigator.pop(context); // pop page back to detail
                    },
                  ),
                ],
              );
            },
            failure: (message) {
              setState(() => _isUploading = false);
              AppPopup.show<void>(
                context: context,
                type: AppPopupType.error,
                title: 'Submission Failed',
                message: message,
                buttons: [
                  AppPopupButton(
                    label: 'OK',
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            },
          );
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Submit Payment',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimension.space32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upload Payment Slip',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space8),
                  const Text(
                    'Please upload a screenshot of your bank transfer receipt.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space32),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceAlt,
                        borderRadius: BorderRadius.circular(
                          AppDimension.radiusMedium,
                        ),
                        border: Border.all(
                          color: AppColors.surface,
                          width: 2,
                          style: _selectedFile == null
                              ? BorderStyle.solid
                              : BorderStyle.none,
                        ),
                      ),
                      child: _selectedFile != null
                          ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    AppDimension.radiusMedium,
                                  ),
                                  child: Image.file(
                                    _selectedFile!,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black.withValues(
                                      alpha: 0.5,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                      onPressed: _clearImage,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 48,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: AppDimension.space16),
                                Text(
                                  'Tap to select image',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: AppDimension.space32),
                  const Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Paying Split ID:',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      Text(
                        widget.splitId.length > 8
                            ? widget.splitId.substring(0, 8)
                            : widget.splitId,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimension.space50),
                  WatButton(
                    label: 'Confirm Submission',
                    isLoading: _isUploading,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: AppDimension.space50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
