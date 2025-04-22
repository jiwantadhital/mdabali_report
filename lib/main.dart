import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mdabali_report/bloc/five_month_data_bloc/bloc/five_month_data_bloc.dart';
import 'package:mdabali_report/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:mdabali_report/bloc/member_limit_bloc/bloc/member_limit_bloc.dart';
import 'package:mdabali_report/bloc/monthly_aggregate_bloc/bloc/monthly_aggregate_bloc.dart';
import 'package:mdabali_report/bloc/sms_summary_bloc/bloc/sms_summary_bloc.dart';
import 'package:mdabali_report/bloc/summary_report_bloc/bloc/summary_report_bloc.dart';
import 'package:mdabali_report/bloc/topup_summary_bloc/bloc/topup_summary_bloc.dart';
import 'package:mdabali_report/bloc/totp_bloc/bloc/t_otp_bloc.dart';
import 'package:mdabali_report/data/repos/get_repo.dart';
import 'package:mdabali_report/data/repos/repositories/five_month_data_repository.dart';
import 'package:mdabali_report/data/repos/repositories/login_repository.dart';
import 'package:mdabali_report/data/repos/repositories/member_limit_repository.dart';
import 'package:mdabali_report/data/repos/repositories/monthly_aggreagate_repository.dart';
import 'package:mdabali_report/data/repos/repositories/sms_summary_repository.dart';
import 'package:mdabali_report/data/repos/repositories/summary_report_repository.dart';
import 'package:mdabali_report/data/repos/repositories/topup_summary_repository.dart';
import 'package:mdabali_report/data/repos/repositories/totp_repository.dart';
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/resources/colors.dart';
import 'package:mdabali_report/view/o_t_p_verification_page.dart';
import 'package:mdabali_report/view/password_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init(); // Ensure SharedPreferences is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
          child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              darkTheme: darkColorScheme.copyWith(
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Color(0xFF000000)),
              ),
              theme: lightColorScheme.copyWith(
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Color(0xFFFFFFFF),
                ),
              ),
              home:
              // OTPVerificationPage())
               PasswordLoginPage()),
        );
      },
    );
  }
}
