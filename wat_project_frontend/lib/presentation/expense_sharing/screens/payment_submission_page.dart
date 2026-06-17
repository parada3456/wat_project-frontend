import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class PaymentSubmissionPage extends StatefulWidget {
  const PaymentSubmissionPage({super.key});

  @override
  State<PaymentSubmissionPage> createState() => _PaymentSubmissionPageState();
}

class _PaymentSubmissionPageState extends State<PaymentSubmissionPage> {
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: () {
                  // TODO: Implement File Picker
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                    border: Border.all(color: AppColors.surface, width: 2, style: BorderStyle.none), // Dash border would be better but requires custom painter
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload_outlined, size: 48, color: AppColors.primary),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Paying to:', style: TextStyle(color: AppColors.textSecondary)),
                  Text('Alex Smith', style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: AppDimension.space8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Amount:', style: TextStyle(color: AppColors.textSecondary)),
                  Text('\$28.40', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                ],
              ),
              const SizedBox(height: AppDimension.space50),
              WatButton(
                label: 'Confirm Submission',
                isLoading: _isUploading,
                onPressed: () {
                  setState(() => _isUploading = true);
                  // TODO: Implement Upload Logic
                },
              ),
              const SizedBox(height: AppDimension.space50),
            ],
          ),
        ),
      ),
    );
  }
}
