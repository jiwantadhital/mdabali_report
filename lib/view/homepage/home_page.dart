import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mdabali_report/bloc/five_month_data_bloc/bloc/five_month_data_bloc.dart';
import 'package:mdabali_report/bloc/init_bloc/bloc/init_bloc.dart';
import 'package:mdabali_report/bloc/monthly_aggregate_bloc/bloc/monthly_aggregate_bloc.dart';
import 'package:mdabali_report/bloc/summary_report_bloc/bloc/summary_report_bloc.dart';
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shimmer/shimmer.dart';
import '../extracted_widgets/custom_text.dart';
import 'charts/line_chart_card.dart';
import 'charts/pie_chart_card.dart';
import 'header_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<NepaliDateTime?> selectedNepaliDate = ValueNotifier(null);

  @override
  void dispose() {
    selectedNepaliDate.dispose();
    super.dispose();
  }

  Future<void> selectNepaliDate(BuildContext context) async {
    NepaliDateTime currentNepaliDate = NepaliDateTime.now();
    NepaliDateTime initialDate =
        selectedNepaliDate.value ?? NepaliDateTime.now();
    final NepaliDateTime? picked = await showMaterialDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: NepaliDateTime(2075),
      lastDate: currentNepaliDate,
      initialDatePickerMode: DatePickerMode.day,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              surface: Theme.of(context).colorScheme.surfaceContainer,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      //to show selected date in container
      selectedNepaliDate.value = picked;
      DateTime englishDate = picked.toDateTime();
      String englishDateFormatted =
          "${englishDate.year}-${englishDate.month.toString().padLeft(2, '0')}-${englishDate.day.toString().padLeft(2, '0')}";
      print("five month date:$englishDateFormatted");
      // ignore: use_build_context_synchronously
      context
          .read<FiveMonthDataBloc>()
          .add(FetchFiveMonthData(toDate: englishDateFormatted));
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: () {
        context.read<MonthlyAggregateBloc>().add(FetchMonthlyAggregate());
        context.read<InitBloc>().add(FetchInitData());
        return Future.delayed(const Duration(milliseconds: 1200));
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<InitBloc, InitState>(
                builder: (context, state) {
                  if (state is InitLoading) {
                    //Get colors from theme
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

                    return SizedBox(
                      height: 40, // Fixed height to match your content
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo shimmer
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          // Text shimmer
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: baseColor,
                              highlightColor: highlightColor,
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is InitLoaded) {
                    final initData = state.initModel.data;
                    final clientId = initData!.clientId;
                    String todayDate =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                    DateTime now = DateTime.now();
                    DateTime oneMonthAgo =
                        DateTime(now.year, now.month - 1, now.day);
                    String dateFrom =
                        DateFormat('yyyy-MM-dd').format(oneMonthAgo);
                    UserSimplePreferences.setClientId(clientId.toString());
                    context.read<SummaryReportBloc>().add(FetchSummaryReport(
                        dateFrom: dateFrom,
                        dateTo: todayDate,
                        clientId:
                            UserSimplePreferences.getClientId().toString()));
                    print('Client Id; ${UserSimplePreferences.getClientId()}');
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: (state.imageBytes!.isEmpty ||
                                    state.imageBytes == null)
                                ? Image.asset('assets/images/mdabali.png')
                                : Image.memory(
                                    Uint8List.fromList(state.imageBytes!),
                                    height: 40,
                                    width: 40,
                                  )),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: CustomText(
                            text:
                                initData.clientName ?? 'Client name not found',
                            maxLine: 2,
                            textAlign: TextAlign.start,
                            textOverflow: TextOverflow.ellipsis,
                            letterSpacing: 1,
                            fontSize: 16,
                            weight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    );
                  } else if (state is InitFailure) {
                    return Center(
                      child: CustomText(
                        text: state.error,
                        maxLine: 2,
                        textOverflow: TextOverflow.ellipsis,
                        letterSpacing: 1,
                        fontSize: 14,
                        weight: FontWeight.w600,
                      ),
                    );
                  } else {
                    return Center(
                      child: CustomText(
                        text: "Something went wrong!",
                        textOverflow: TextOverflow.ellipsis,
                        letterSpacing: 1,
                        fontSize: 14,
                        weight: FontWeight.w600,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
              CustomText(
                text: 'All your transaction details',
                fontSize: 16,
                weight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              const SizedBox(
                height: 24,
              ),
              HeaderSection(),
              const SizedBox(
                height: 24,
              ),
              CustomText(
                text: 'Summary of successful transactions',
                fontSize: 16,
                color: colorScheme.onSurface,
                weight: FontWeight.w600,
              ),
              //   const SizedBox(
              //     height: 24,
              //   ),
              //   BarGraphCard(),
              const SizedBox(
                height: 24,
              ),
              PieChartCard(),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Transaction Trends',
                    fontSize: 16,
                    weight: FontWeight.bold,
                  ),
                  GestureDetector(
                    onTap: () => selectNepaliDate(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: colorScheme.onSurfaceVariant, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: colorScheme.primaryFixedDim,
                          ),
                          SizedBox(width: 8),
                          ValueListenableBuilder<NepaliDateTime?>(
                            valueListenable: selectedNepaliDate,
                            builder: (context, value, _) {
                              bool isToday(NepaliDateTime? date) {
                                if (date == null) return false;

                                final now = NepaliDateTime.now();
                                return date.year == now.year &&
                                    date.month == now.month &&
                                    date.day == now.day;
                              }

                              String text = (value == null || isToday(value))
                                  ? "Today"
                                  : "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
                              return Text(
                                text,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: value == null
                                      ? colorScheme.onSurfaceVariant
                                      : colorScheme.onSurface,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 16,
              ),
              //line chart for Utility
              UtilityLineChartSection(),
              const SizedBox(
                height: 24,
              ),
              //line chart for Dfs(Dr)
              DfsDrLineChartSection(),
              const SizedBox(
                height: 24,
              ),
              //line chart for Dfs(cr   )
              DfsCrLineChartSection(),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DfsCrLineChartSection extends StatelessWidget {
  const DfsCrLineChartSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiveMonthDataBloc, FiveMonthDataState>(
      builder: (context, state) {
        if (state is FiveMonthDataLoading) {
          return ShimmerLineChartCard();
        } else if (state is FiveMonthDataLoaded) {
          final dfsCrData = state.data.data?.dfsCredit ?? [];
          return LineChartCard(
            title: 'DFS(Cr)',
            dataPoints: dfsCrData
                .map((e) => e.amount ?? 0.0)
                .toList()
                .reversed
                .toList(),
            months:
                dfsCrData.map((e) => e.month ?? '').toList().reversed.toList(),
          );
        } else if (state is FiveMonthDataError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: state.message,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: 'Failed to load Data',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class UtilityLineChartSection extends StatelessWidget {
  const UtilityLineChartSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiveMonthDataBloc, FiveMonthDataState>(
      builder: (context, state) {
        if (state is FiveMonthDataLoading) {
          return ShimmerLineChartCard();
        } else if (state is FiveMonthDataLoaded) {
          final utilityData = state.data.data?.utility ?? [];
          return LineChartCard(
            title: 'Utility',
            dataPoints: utilityData
                .map((e) => e.amount ?? 0.0)
                .toList()
                .reversed
                .toList(),
            months: utilityData
                .map((e) => e.month ?? '')
                .toList()
                .reversed
                .toList(),
          );
        } else if (state is FiveMonthDataError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: state.message,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: 'Failed to load Data',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class DfsDrLineChartSection extends StatelessWidget {
  const DfsDrLineChartSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiveMonthDataBloc, FiveMonthDataState>(
      builder: (context, state) {
        if (state is FiveMonthDataLoading) {
          return ShimmerLineChartCard();
        } else if (state is FiveMonthDataLoaded) {
          final dfsDrData = state.data.data?.dfsDebit ?? [];
          return LineChartCard(
            title: 'DFS(Dr)',
            dataPoints: dfsDrData
                .map((e) => e.amount ?? 0.0)
                .toList()
                .reversed
                .toList(),
            months:
                dfsDrData.map((e) => e.month ?? '').toList().reversed.toList(),
          );
        } else if (state is FiveMonthDataError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: state.message,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: 'Failed to load Data',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
