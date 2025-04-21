import 'package:flutter/material.dart';
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/password_login_page.dart';

void showLogoutDialog(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        alignment: Alignment.center,
        backgroundColor: colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Logout',
                fontSize: 18,
                weight: FontWeight.bold,
                color: colorScheme.onSurface,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              CustomText(
                text: 'Are you sure you want to logout?',
                fontSize: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      minimumSize: Size(100, 36),
                      side: BorderSide(color: colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: CustomText(
                      text: 'No',
                      fontSize: 16,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      foregroundColor: colorScheme.onError,
                      minimumSize: Size(100, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Perform logout action
                      UserSimplePreferences.cleanToken();
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PasswordLoginPage()),
                        (route) => false,
                      );
                    },
                    child: CustomText(
                      text: 'Logout',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              //   SizedBox(height: 12),

              //   SizedBox(height: 12),
            ],
          ),
        ),
      );
    },
  );
}
