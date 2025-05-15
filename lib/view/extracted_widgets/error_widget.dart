import 'package:flutter/material.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';

class ErrorWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorWidget({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline,
              color: Theme.of(context).colorScheme.error, size: 24),
          SizedBox(height: 8),
          CustomText(
            text: errorMessage,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 16,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
