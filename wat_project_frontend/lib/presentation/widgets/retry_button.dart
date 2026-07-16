import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';

/// RetryButton — Pixel styled retry action.
class RetryButton extends StatelessWidget {
  final VoidCallback onRetry;
  final String label;

  const RetryButton({
    super.key,
    required this.onRetry,
    this.label = 'RETRY',
  });

  @override
  Widget build(BuildContext context) {
    return WatButton(label: label, onPressed: onRetry);
  }
}
