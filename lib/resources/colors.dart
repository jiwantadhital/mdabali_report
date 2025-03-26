import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// This is same for Dark and Light Theme
const accentColor = Color(0xFFFB5656);

const Color primary = Color(0xFF0986FF);
const Color on_primary = Color(0xFFFFFFFF);
const Color primary_container = Color(0x140986FF);
const Color primary_on_container = Color(0xFF0B72EB);
const Color secondary = Color(0xFF001A49);
const Color on_secondary = Color(0xFFFFFFFF);
const Color secondary_container = Color(0x14AD6016);
const Color secondary_on_container = Color(0xFF0986FF);

const Color dividerColor = Color(0xFFBCCCDC);

var lightColorScheme = ThemeData(
  useMaterial3: true,
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Colors.transparent),
  primaryColor: primary,
  canvasColor: Color(0xFFF0F2F6),
//disabled
  disabledColor: Color(0xFFBCCCDC),
//on_disabled
  dividerColor: Color(0xFFE4E4E4),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: on_primary,
    primaryContainer: primary_container,
    onPrimaryContainer: primary_on_container,
    secondary: secondary,
    onSecondary: on_secondary,
    secondaryContainer: secondary_container,
    onSecondaryContainer: secondary_on_container,
    error: Color(0xFFD41717),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFDEDED),
    onErrorContainer: Color(0xFF4A0808),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF232323),
    surfaceContainerHighest: Color(0xFFDBDFE5),
    surfaceContainer: Color(0xFFF0F2F6),
    onSurfaceVariant: Color(0xFF5C5C5C),
    outline: Color(0xFFACB8C3),
    outlineVariant: Color(0xFFDBE1E5),
//success
    tertiary: Color(0xFF117E2A),
//on_success
    onTertiary: Color(0xFFFFFFFF),
//success_container
    tertiaryContainer: Color(0x14117E2A),
//success_on_container
    onTertiaryContainer: Color(0xFF0A4818),
//text_field_disabled
    shadow: Color(0xFF72767A),
//disabled_outline
    scrim: Color(0xFFCAD2D9),
//warning
    inverseSurface: Color(0xFFF97316),
//on_warning
    onInverseSurface: Color(0xFF3C1A01),
//warning_container
    inversePrimary: Color(0xFFFEF3EB),
//warning_on_container
    surfaceTint: Color(0xFF3C1A01),
  ),
);

var darkColorScheme = ThemeData(
  useMaterial3: true,
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Colors.transparent),
  fontFamily: "Urbanist",
  primaryColor: primary,
  canvasColor: Color(0xFF000000),
//disabled
  disabledColor: Color(0xFF292929),
//on_disabled
  dividerColor: Color(0xFF555555),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: on_primary,
    primaryContainer: primary_container,
    onPrimaryContainer: primary_on_container,
    secondary: secondary,
    onSecondary: on_secondary,
    secondaryContainer: secondary_container,
    onSecondaryContainer: secondary_on_container,
    error: Color(0xFFED5959),
    onError: Color(0xFF4A0808),
    errorContainer: Color(0xFFED5959),
    onErrorContainer: Color(0xFF4A0808),
    surfaceContainer: Color(0xFF1F1F1F),
    surface: Color(0xFF000000),
    onSurface: Color(0xFFF5F5F5),
    surfaceContainerHighest: Color(0xFF292929),
    surfaceContainerLowest: Color(0xFF292929),
    onSurfaceVariant: Color(0xFFA3A3A3),
    outline: Color(0xFF525252),
    outlineVariant: Color(0xFF3D3D3D),
//success
    tertiary: Color(0xFF117E2A),
//on_success
    onTertiary: Color(0xFFFFFFFF),
//success_container
    tertiaryContainer: Color(0x14117E2A),
//success_on_container
    onTertiaryContainer: Color(0xFF0A4818),
//text_field_disabled
    shadow: Color(0xFF9D9D9D),
//disabled_outline
    scrim: Color(0xFF343434),
//warning
    inverseSurface: Color(0xFFF97316),
//on_warning
    onInverseSurface: Color(0xFF3C1A01),
//warning_container
    inversePrimary: Color(0xFF3C1A01),
//warning_on_container
    surfaceTint: Color(0xFF025326),
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
final RegExp LANDLINE_PATTERN = RegExp(r'^([1-9])\d{7}$');

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
    color: kShadow.withOpacity(.04),
    offset: Offset(1, 1),
    spreadRadius: 1,
    blurRadius: 2);

var kSheetShadow = BoxShadow(
    color: kShadow.withOpacity(0.1),
    offset: Offset(2, 0),
    spreadRadius: 6,
    blurRadius: 4);

const kMemberColorList = [
  Color(0xff029DFF),
  Color(0xff2BBF7D),
  Color(0xffF6A400),
  Color(0xffE00000),
  Color(0xff926BFA),
  Color(0xffD946EF),
  Color(0xffF58300),
  Color(0xff1F6DFF),
  Color(0xff059669),
  Color(0xffEC4899),
];

Color getRandomColor(int index) {
  return kMemberColorList[index % kMemberColorList.length];
}
