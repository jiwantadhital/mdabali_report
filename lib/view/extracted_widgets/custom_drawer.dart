// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdabali_report/resources/images_constants.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/logout_dialog.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isSettingsExpanded = false;

  // Static values for user information
  final String _userName = "Aakash Sah";
  final String _cooperativeName = "Aarjan saving and credit Cooperative";
  final String _userImagePath = ImagesConstants.info;

  // Handle theme change internally
  void _handleThemeChange(ThemeMode themeMode) {
    // You would typically use a theme provider or state management solution
    // For this example, we'll just print the theme change
    print('Changing theme to: $themeMode');

    // Example implementation with a theme provider:
    // ThemeProvider.of(context).setThemeMode(themeMode);

    // Close the drawer
    Navigator.pop(context);
  }

  // Handle logout internally
  void _handleLogout() {
    print('Logging out...');
    Navigator.pop(context);
    showLogoutDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    // Get colorScheme from the current theme
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Top user information card
          Card(
            margin: EdgeInsets.all(0),
            elevation: 0,
            color: colorScheme.secondary.withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 40), // For safe area
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: colorScheme.onSecondary,
                    backgroundImage: AssetImage(_userImagePath),
                  ),
                  SizedBox(height: 12),
                  CustomText(
                    text: _userName,
                    fontSize: 18,
                    weight: FontWeight.w500,
                    color: colorScheme.onSecondary,
                  ),
                  SizedBox(height: 8),
                  CustomText(
                    text: _cooperativeName,
                    fontSize: 14,
                    color: colorScheme.onSecondary,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Divider
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0),
                    Colors.blue.withOpacity(0.5),
                    Colors.blue.withOpacity(0),
                  ],
                  stops: [0.0, 0.5, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),

          // Settings option
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: colorScheme.primary,
                size: 18,
              ),
              title: CustomText(text: "Settings", fontSize: 16),
              onTap: () {
                // Toggle expanded settings
                setState(() {
                  _isSettingsExpanded = !_isSettingsExpanded;
                });
              },
              trailing: Icon(
                _isSettingsExpanded ? Icons.expand_less : Icons.expand_more,
                color: colorScheme.primary,
              ),
            ),
          ),

          // Expandable theme settings
          if (_isSettingsExpanded) ...[
            // Light theme option
            ListTile(
              contentPadding: EdgeInsets.only(left: 56, right: 16),
              leading: Icon(Icons.light_mode, color: colorScheme.primary),
              title: CustomText(text: "Light Theme"),
              onTap: () => _handleThemeChange(ThemeMode.light),
            ),

            // Dark theme option
            ListTile(
              contentPadding: EdgeInsets.only(left: 56, right: 16),
              leading: Icon(Icons.dark_mode, color: colorScheme.primary),
              title: CustomText(text: "Dark Theme"),
              onTap: () => _handleThemeChange(ThemeMode.dark),
            ),

            // System theme option
            ListTile(
              contentPadding: EdgeInsets.only(left: 56, right: 16),
              leading: Icon(Icons.settings_system_daydream_rounded,
                  color: colorScheme.primary),
              title: CustomText(text: "System Theme"),
              onTap: () => _handleThemeChange(ThemeMode.system),
            ),
          ],

          Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0),
                    Colors.blue.withOpacity(0.5),
                    Colors.blue.withOpacity(0),
                  ],
                  stops: [0.0, 0.5, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),

          // Logout option
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: colorScheme.error,
                size: 18,
              ),
              title: CustomText(
                  text: "Logout", fontSize: 16, color: colorScheme.error),
              onTap: _handleLogout,
            ),
          ),
        ],
      ),
    );
  }
}
