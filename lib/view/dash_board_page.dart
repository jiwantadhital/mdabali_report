import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mdabali_report/bloc/five_month_data_bloc/bloc/five_month_data_bloc.dart';
import 'package:mdabali_report/bloc/init_bloc/bloc/init_bloc.dart';
import 'package:mdabali_report/bloc/monthly_aggregate_bloc/bloc/monthly_aggregate_bloc.dart';
import 'package:mdabali_report/bloc/summary_report_bloc/bloc/summary_report_bloc.dart';
import 'package:mdabali_report/resources/colors.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_drawer.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'homepage/home_page.dart';
import 'mdabali_page/mdabali_page.dart';
import 'sms_page/sms_page.dart';
import 'transaction_page/transaction_page.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    // _pages = [HomePage(), TransactionPage(), SmsPage(), MdabaliPage()];
    // // Get today's date
    // String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // DateTime now = DateTime.now();
    // DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
    // String dateFrom = DateFormat('yyyy-MM-dd').format(oneMonthAgo);
    // context.read<MonthlyAggregateBloc>().add(FetchMonthlyAggregate());
    // context
    //     .read<SummaryReportBloc>()
    //     .add(FetchSummaryReport(dateFrom: dateFrom, dateTo: todayDate));

    // //this is for line chart data
    // context
    //     .read<FiveMonthDataBloc>()
    //     .add(FetchFiveMonthData(toDate: todayDate));
    // super.initState();
    //   super.initState();
    // _pages = [const HomePage(), const TransactionPage(), const SmsPage(), const MdabaliPage()];
    // // Get today's date
    // String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // DateTime now = DateTime.now();
    // DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
    // String dateFrom = DateFormat('yyyy-MM-dd').format(oneMonthAgo);

    // // Sequence BLoC requests to avoid parallel 440s
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   try {
    //     context.read<MonthlyAggregateBloc>().add(FetchMonthlyAggregate());
    //     await Future.delayed(Duration(milliseconds: 100)); // Wait for first request
    //     context.read<SummaryReportBloc>().add(FetchSummaryReport(dateFrom: dateFrom, dateTo: todayDate));
    //     await Future.delayed(Duration(milliseconds: 100)); // Wait for second request
    //     context.read<FiveMonthDataBloc>().add(FetchFiveMonthData(toDate: todayDate));
    //   } catch (e) {
    //     print('DashBoardPage: initState error: $e');
    //   }
    // });super.initState();
    _pages = [
      const HomePage(),
      const TransactionPage(),
      const SmsPage(),
      const MdabaliPage()
    ];
    // Get today's date
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    DateTime now = DateTime.now();
    DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
    String dateFrom = DateFormat('yyyy-MM-dd').format(oneMonthAgo);

    // Delay BLoC requests to ensure widget is fully initialized
    Future.microtask(() async {
      print('DashBoardPage: Initializing BLoC requests');
      try {
        final monthlyAggregateBloc = context.read<MonthlyAggregateBloc>();
        final summaryReportBloc = context.read<SummaryReportBloc>();
        final fiveMonthDataBloc = context.read<FiveMonthDataBloc>();

        // Check if widget is still mounted
        if (!mounted) {
          print('DashBoardPage: Widget not mounted, aborting BLoC requests');
          return;
        }
        context.read<InitBloc>().add(FetchInitData());
        monthlyAggregateBloc.add(FetchMonthlyAggregate());
        await monthlyAggregateBloc.stream.firstWhere(
          (state) =>
              state is MonthlyAggregateLoaded || state is MonthlyAggregateError,
          orElse: () => MonthlyAggregateError('Timeout'),
        );
        if (!mounted) return;

        summaryReportBloc
            .add(FetchSummaryReport(dateFrom: dateFrom, dateTo: todayDate));
        await summaryReportBloc.stream.firstWhere(
          (state) =>
              state is SummaryReportLoaded || state is SummaryReportError,
          orElse: () => SummaryReportError('Timeout'),
        );
        if (!mounted) return;

        fiveMonthDataBloc.add(FetchFiveMonthData(toDate: todayDate));
      } catch (e) {
        print('DashBoardPage: initState error: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> appBar = [
      'mDabali Next Gen Report',
      'Transaction Summary',
      'SMS & TopUP Summary',
      'mDabali Summary'
    ];
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      drawer: CustomDrawer(),
      appBar: AppBar(
        surfaceTintColor: colorScheme.surfaceTint,
        elevation: 0,
        backgroundColor: colorScheme.surfaceDim,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: colorScheme.primary),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: CustomText(
          text: appBar[_selectedIndex],
          fontSize: 18,
          color: colorScheme.primary,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        // Actions for notification icon on the right
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.notifications, color: colorScheme.primary),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(microseconds: 300),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [kBoxShadow],
      ),
      child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() {
                _selectedIndex = index;
              }),
          selectedItemColor: Theme.of(context).colorScheme.primaryFixedDim,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HomePage'),
            BottomNavigationBarItem(
                icon: Icon(Icons.swap_horiz), label: 'Transaction'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'SMS & TopUp'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'mDabali')
          ]),
    );
  }
}
