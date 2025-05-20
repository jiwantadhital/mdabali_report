import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// This is same for Dark and Light Theme
const accentColor = Color(0xFFFB5656);

const Color primary = Color(0xFF0986FF);
const Color onPrimary = Color(0xFFFFFFFF);
const Color primaryContainer = Color(0x140986FF);
const Color primaryOnContainer = Color(0xFF0B72EB);
const Color secondary = Color(0xFF001A49);
const Color onSecondary = Color(0xFFFFFFFF);
const Color secondaryContainer = Color(0x14AD6016);
const Color secondaryOnContainer = Color(0xFF0986FF);

const Color dividerColor = Color(0xFFBCCCDC);

var lightColorScheme = ThemeData(
  useMaterial3: true,
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Colors.transparent),
  primaryColor: primary,
  canvasColor: const Color(0xFFF0F2F6),
//disabled
  disabledColor: const Color(0xFFBCCCDC),
//on_disabled
  dividerColor: const Color(0xFFE4E4E4),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: primaryOnContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: secondaryOnContainer,
    error: const Color(0xFFD41717),
    onError: const Color(0xFFFFFFFF),
    errorContainer: const Color(0xFFFDEDED),
    onErrorContainer: const Color(0xFF4A0808),
    surface: const Color(0xFFFFFFFF),
    onSurface: const Color(0xFF232323),
    surfaceContainerHighest: const Color(0xFFDBDFE5),
    surfaceContainer: const Color(0xFFF0F2F6),
    onSurfaceVariant: const Color(0xFF5C5C5C),
    outline: const Color(0xFFACB8C3),
    outlineVariant: const Color(0xFFDBE1E5),
//success
    tertiary: const Color(0xFF34C759),
    tertiaryFixedDim: const Color(0xFF34C759).withValues(alpha: 0.1),
//on_success
    onTertiary: const Color(0xFFFFFFFF),
//success_container
    tertiaryContainer: const Color(0x14117E2A),
//success_on_container
    onTertiaryContainer: const Color(0xFF0A4818),
//text_field_disabled
    shadow: const Color(0xFF72767A),
//disabled_outline
    scrim: const Color(0xFFCAD2D9),
//warning
    inverseSurface: const Color(0xFFF97316),
//on_warning
    onInverseSurface: const Color(0xFF3C1A01),
//warning_container
    inversePrimary: const Color(0xFFFEF3EB),
//warning_on_container
    surfaceTint: const Color(0xFF3C1A01),
  ),
);

var darkColorScheme = ThemeData(
  useMaterial3: true,
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Colors.transparent),
  fontFamily: 'Urbanist',
  primaryColor: primary,
  canvasColor: const Color(0xFF000000),
//disabled
  disabledColor: const Color(0xFF292929),
//on_disabled
  dividerColor: const Color(0xFF555555),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: primaryOnContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: secondaryOnContainer,
    error: const Color(0xFFED5959),
    onError: const Color(0xFF4A0808),
    errorContainer: const Color(0xFFED5959),
    onErrorContainer: const Color(0xFF4A0808),
    surfaceContainer: const Color(0xFF1F1F1F),
    surface: const Color(0xFF000000),
    onSurface: const Color(0xFFF5F5F5),
    surfaceContainerHighest: const Color(0xFF292929),
    surfaceContainerLowest: const Color(0xFF292929),
    onSurfaceVariant: const Color(0xFFA3A3A3),
    outline: const Color(0xFF525252),
    outlineVariant: const Color(0xFF3D3D3D),
//success
    tertiary: const Color(0xFF34C759),
    tertiaryFixedDim: const Color(0xFF34C759).withValues(alpha: 0.1),
//on_success
    onTertiary: const Color(0xFFFFFFFF),
//success_container
    tertiaryContainer: const Color(0x14117E2A),
//success_on_container
    onTertiaryContainer: const Color(0xFF0A4818),
//text_field_disabled
    shadow: const Color(0xFF9D9D9D),
//disabled_outline
    scrim: const Color(0xFF343434),
//warning
    inverseSurface: const Color(0xFFF97316),
//on_warning
    onInverseSurface: const Color(0xFF3C1A01),
//warning_container
    inversePrimary: const Color(0xFF3C1A01),
//warning_on_container
    surfaceTint: const Color(0xFF025326),
  ),
);

const kLightSurfaceColor = Color(0xFF5A6F81);

const kDarkSurfaceColor = Color(0xFF22292F);

const kLightNeutralColor = Color(0xFFF0F2F6);

const kDisableButton = Color(0xFFBCCCDC);
const kLightGrey = Color(0xFFDBE1E5);

const kDarkBlue = Color(0xff0B72EB);

const kDebitColor = Color(0xffD41717);
const kCreditColor = Color(0xff117E2A);

const kShadow = Color(0xff001A49);
const kSuccess = Color(0xff117E2A);

//final RegExp nepaliMobileRegex = RegExp(r'^9[0-8][0-8]\d{7}$');

final RegExp ntcPrepaidPattern = RegExp(r'^(984|986|976)\d{7}$');
final RegExp ntcPostpaidPattern = RegExp(r'^(985)\d{7}$');
final RegExp ncellPattern = RegExp(r'^(980|981|982|970)\d{7}$');
final RegExp cdmaPrepaidPattern = RegExp(r'^(974)\d{7}$');
final RegExp cdmaPostpaidPattern = RegExp(r'^(975)\d{7}$');
//    private val cdmaPattern2 = "^(0)\\d{8}$"
final RegExp smCellPattern = RegExp(r'^(961|962|988)\d{7}$');
final RegExp landlinePattern = RegExp(r'^([1-9])\d{7}$');

String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
final RegExp emailRegExp = RegExp(emailPattern);

bool isValidEmail(String email) {
  return emailRegExp.hasMatch(email);
}

bool nepaliMobileRegex(String phoneNumber) {
  // Define the regex pattern
  String pattern = r'^9\d{9}$';

  // Create a RegExp object
  RegExp regExp = RegExp(pattern);

  // Check if the phone number matches the pattern
  return regExp.hasMatch(phoneNumber);
}

final formatter = NumberFormat('#,##,##0.00'); // to add commas between numbers

const kAppbarColor = Color.fromRGBO(240, 242, 246, 1);

var kBoxShadow = BoxShadow(
    color: kShadow.withValues(alpha: .04),
    offset: const Offset(1, 1),
    spreadRadius: 1,
    blurRadius: 2);

var kSheetShadow = BoxShadow(
    color: kShadow.withValues(alpha: 0.1),
    offset: const Offset(2, 0),
    spreadRadius: 6,
    blurRadius: 4);

const kMemberColorList = [
  Color(0xff029DFF),
  Color(0xff2BBF7D),
  Color(0xffF6A400),
  Color(0xff936276),
  Color(0xff926BFA),
  Color(0xffD946EF),
  Color(0xffF58300),
  Color(0xff1F6DFF),
  Color(0xff059669),
  Color(0xffEC4899),
  Color(0xff1e81b0),
  Color(0xff52c4a2)
];

Color getRandomColor(int index) {
  return kMemberColorList[index % kMemberColorList.length];
}
