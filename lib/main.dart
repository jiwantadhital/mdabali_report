import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/bloc/five_month_data_bloc/bloc/five_month_data_bloc.dart';
import 'package:mdabali_report/bloc/init_bloc/bloc/init_bloc.dart';
import 'package:mdabali_report/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:mdabali_report/bloc/member_limit_bloc/bloc/member_limit_bloc.dart';
import 'package:mdabali_report/bloc/monthly_aggregate_bloc/bloc/monthly_aggregate_bloc.dart';
import 'package:mdabali_report/bloc/sms_summary_bloc/bloc/sms_summary_bloc.dart';
import 'package:mdabali_report/bloc/summary_report_bloc/bloc/summary_report_bloc.dart';
import 'package:mdabali_report/bloc/topup_summary_bloc/bloc/topup_summary_bloc.dart';
import 'package:mdabali_report/bloc/totp_bloc/bloc/t_otp_bloc.dart';
import 'package:mdabali_report/controller/connectivity_listener.dart';
import 'package:mdabali_report/controller/theme_controller.dart';
import 'package:mdabali_report/data/repos/get_repo.dart';
import 'package:mdabali_report/data/repos/repositories/five_month_data_repository.dart';
import 'package:mdabali_report/data/repos/repositories/init_repository.dart';
import 'package:mdabali_report/data/repos/repositories/login_repository.dart';
import 'package:mdabali_report/data/repos/repositories/member_limit_repository.dart';
import 'package:mdabali_report/data/repos/repositories/monthly_aggreagate_repository.dart';
import 'package:mdabali_report/data/repos/repositories/sms_summary_repository.dart';
import 'package:mdabali_report/data/repos/repositories/summary_report_repository.dart';
import 'package:mdabali_report/data/repos/repositories/topup_summary_repository.dart';
import 'package:mdabali_report/data/repos/repositories/totp_repository.dart';
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/resources/colors.dart';
import 'package:mdabali_report/view/dash_board_page.dart';
import 'package:mdabali_report/view/o_t_p_verification_page.dart';
import 'package:mdabali_report/view/password_login_page.dart';

import 'view/no_internet_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init(); // Ensure SharedPreferences is initialized
  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginBloc(LoginRepository()),
            ),
            BlocProvider(create: (context) => TOtpBloc(TotpRepository())),
            BlocProvider(
                create: (context) =>
                    InitBloc(InitRepository(getRepo: GetRepo()))),
            BlocProvider(
                create: (context) => MonthlyAggregateBloc(
                    MonthlyAggregateRepository(getRepo: GetRepo()))),
            BlocProvider(
                create: (context) => SummaryReportBloc(
                    SummaryReportRepository(getRepo: GetRepo()))),
            BlocProvider(
                create: (context) => FiveMonthDataBloc(
                    FiveMonthDataRepository(getRepo: GetRepo()))),
            BlocProvider(
                create: (context) => TopupSummaryBloc(
                    TopupSummaryRepository(getRepo: GetRepo()))),
            BlocProvider(
                create: (context) =>
                    SmsSummaryBloc(SmsSummaryRepository(getRepo: GetRepo()))),
            BlocProvider(
                create: (context) =>
                    MemberLimitBloc(MemberLimitRepository(getRepo: GetRepo()))),
          ],
          child: ConnectivityListener(
            child: GetMaterialApp(
              // navigatorObservers: [AuthNavigatorObserver()],
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              themeMode: themeController.themeMode.value,
              darkTheme:
                  //    ThemeData.dark(),
                  darkColorScheme.copyWith(
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Color(0xFF000000)),
              ),
              theme: lightColorScheme.copyWith(
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Color(0xFFFFFFFF),
                ),
              ),
             initialRoute: '/login',
              getPages: [
                GetPage(name: '/login', page: () => PasswordLoginPage()),
                GetPage(name: '/dashboard', page: () => DashBoardPage()),
                GetPage(
                    name: '/otppage', page: () => OTPVerificationPage(secret: '')),
                    GetPage(name: '/NoInternetPage', page: () => const NoInternetPage()),
              ],
              //  home:PasswordLoginPage()
            ),
          ),
        );
      },
    );
  }
}
