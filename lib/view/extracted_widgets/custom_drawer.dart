import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/bloc/init_bloc/bloc/init_bloc.dart';
import 'package:mdabali_report/controller/theme_controller.dart';
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/resources/images_constants.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/logout_dialog.dart';
import 'package:shimmer/shimmer.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isSettingsExpanded = false;

  final bool isDarkmode = true;
  // Handle theme change internally
  void _handleThemeChange(ThemeMode mode) {
    final controller = Get.find<ThemeController>();
    controller.setThemeMode(mode);
    Navigator.pop(context);
  }

  // Handle logout internally
  void _handleLogout() {
    Navigator.pop(context);
    showLogoutDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    // Get colorScheme from the current theme
    final colorScheme = Theme.of(context).colorScheme;
    final controller = Get.find<ThemeController>();
    return Drawer(
      backgroundColor: colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Top user information card
          Card(
            margin: EdgeInsets.all(0),
            elevation: 0,
            color: colorScheme.secondary.withValues(alpha: 0.9),
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
                  BlocBuilder<InitBloc, InitState>(
                    builder: (context, state) {
                      if (state is InitLoading) {
                        var colorScheme = Theme.of(context).colorScheme;
                        var brightness = Theme.of(context).brightness;
                        Color baseColor = brightness == Brightness.light
                            ? colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.5)
                            : colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.3);
                        Color highlightColor = brightness == Brightness.light
                            ? colorScheme.onSurface
                            : colorScheme.onSurface.withValues(alpha: 0.6);
                        return Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else if (state is InitLoaded) {
                        return CircleAvatar(
                            radius: 50,
                            backgroundColor: colorScheme.onSecondary,
                            backgroundImage: MemoryImage(
                              Uint8List.fromList(state.imageBytes!),
                            ));
                      } else {
                        return CircleAvatar(
                          radius: 40,
                          backgroundColor: colorScheme.onSecondary,
                          backgroundImage:
                              AssetImage(ImagesConstants.mdabaliLogo),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  CustomText(
                    text: UserSimplePreferences.getUsername().toString(),
                    fontSize: 18,
                    weight: FontWeight.w500,
                    color: colorScheme.onSecondary,
                  ),
                  SizedBox(height: 8),
                  BlocBuilder<InitBloc, InitState>(
                    builder: (context, state) {
                      if (state is InitLoading) {
                        return Center(
                          child: CustomText(
                            text: 'Loading...',
                            fontSize: 14,
                            color: colorScheme.onSecondary,
                          ),
                        );
                      } else if (state is InitLoaded) {
                        final initData = state.initModel.data;
                        return Center(
                          child: CustomText(
                            text: initData?.clientName ?? 'Not found',
                            fontSize: 14,
                            textAlign: TextAlign.center,
                            color: colorScheme.onSecondary,
                          ),
                        );
                      } else {
                        return CustomText(
                          text: 'Something went wrong!',
                          fontSize: 14,
                          color: colorScheme.onSecondary,
                          textAlign: TextAlign.center,
                        );
                      }
                    },
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
                    Colors.blue.withValues(alpha: 0),
                    Colors.blue.withValues(alpha: 0.5),
                    Colors.blue.withValues(alpha: 0),
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
            ListTile(
              contentPadding: EdgeInsets.only(left: 56, right: 16),
              leading: Icon(Icons.light_mode, color: colorScheme.primary),
              title: CustomText(text: "Light Theme"),
              trailing: controller.themeMode.value == ThemeMode.light
                  ? Icon(Icons.check, color: colorScheme.primary)
                  : null,
              onTap: () {
                _handleThemeChange(ThemeMode.light);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 56, right: 16),
              leading: Icon(Icons.dark_mode, color: colorScheme.primary),
              title: CustomText(text: "Dark Theme"),
              trailing: controller.themeMode.value == ThemeMode.dark
                  ? Icon(Icons.check, color: colorScheme.primary)
                  : null,
              onTap: () {
                _handleThemeChange(ThemeMode.dark);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 56, right: 16),
              leading: Icon(Icons.settings_system_daydream_rounded,
                  color: colorScheme.primary),
              title: CustomText(text: "System Theme"),
              trailing: controller.themeMode.value == ThemeMode.system
                  ? Icon(Icons.check, color: colorScheme.primary)
                  : null,
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
                    Colors.blue.withValues(alpha: 0),
                    Colors.blue.withValues(alpha: 0.5),
                    Colors.blue.withValues(alpha: 0),
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
