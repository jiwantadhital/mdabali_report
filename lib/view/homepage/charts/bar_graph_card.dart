// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mdabali_report/bloc/summary_report_bloc/bloc/summary_report_bloc.dart';
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/resources/colors.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/date_range_picker_card.dart';
import 'package:shimmer/shimmer.dart';

class BarGraphCard extends StatefulWidget {
  const BarGraphCard({super.key});

  @override
  State<BarGraphCard> createState() => _BarGraphCardState();
}

class _BarGraphCardState extends State<BarGraphCard> {
  @override
  Widget build(BuildContext context) {
    double getOptimalInterval(double maxValue) {
      if (maxValue <= 1000) {
        return 100; // Small values, smaller interval
      } else if (maxValue <= 5000) {
        return 500; // Medium range
      } else if (maxValue <= 20000) {
        return 2000; // Larger range
      } else if (maxValue <= 50000) {
        return 5000; // Even larger
      } else if (maxValue <= 100000) {
        return 20000; // Even larger
      } else {
        return 20000; // Very large values
      }
    }

    double getMaxValue(List<double> dataPoints) {
      return dataPoints.isEmpty
          ? 0
          : dataPoints.reduce((a, b) => a > b ? a : b + 1000);
    }

    var colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<SummaryReportBloc, SummaryReportState>(
      builder: (context, state) {
        if (state is SummaryReportLoading) {
          return ShimmerBarCard();
        } else if (state is SummaryReportLoaded) {
          final barGraphData = state.summaryReportModel.data;
          final List<double> successValues =
              barGraphData!.map((e) => e.successCount!.toDouble()).toList();

          final double maxYValue = getMaxValue(successValues);
          final double interval = getOptimalInterval(maxYValue);
          return Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 16, top: 16),
            decoration: BoxDecoration(
              boxShadow: [kBoxShadow],
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () async {
                      final range = await ThreeMonthRangePicker.show(context);
                      if (range != null) {
                        // Format the start and end dates to 'yyyy-MM-dd' format
                        String startFormatted =
                            DateFormat('yyyy-MM-dd').format(range.startDate!);
                        String endFormatted = DateFormat('yyyy-MM-dd')
                            .format(range.endDate ?? range.startDate!);
                        // ignore: use_build_context_synchronously
                        context.read<SummaryReportBloc>().add(
                            FetchSummaryReport(
                                dateFrom: startFormatted,
                                dateTo: endFormatted,
                                clientId: UserSimplePreferences.getClientId()
                                    .toString()));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 18,
                            color: colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                AspectRatio(
                  aspectRatio: 1.3,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      width: barGraphData.length > 9
                          ? barGraphData.length * 66
                          : barGraphData.length * 78,
                      child: BarChart(
                        BarChartData(
                          maxY: barGraphData
                                  .map((e) => e.successAmount!)
                                  .reduce(max)
                                  .toDouble() *
                              1.1,
                          alignment: BarChartAlignment.spaceBetween,
                          barGroups: barGraphData.map((data) {
                            final index = barGraphData.indexOf(data);
                            List<Color> chartColors = kMemberColorList;

                            return BarChartGroupData(
                              x: index,
                              barsSpace: 10,
                              barRods: [
                                BarChartRodData(
                                    toY: data.successAmount!.toDouble(),
                                    color:
                                        chartColors[index % chartColors.length],
                                    width: 24,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6))),
                              ],
                            );
                          }).toList(),
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.black87,
                              fitInsideVertically: true,
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                  rod.toY.toString(),
                                  TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: interval * 20,
                                reservedSize: 80,
                                getTitlesWidget: (value, meta) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 0, top: 8),
                                    child: CustomText(
                                      text: 'Rs ${value.toInt().toString()}',
                                      fontSize: 12,
                                      color: colorScheme.onSurface,
                                    ),
                                  );
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ), // Hides top data
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  if (index >= 0 &&
                                      index < barGraphData.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 18, left: 20),
                                      child: Text(
                                        barGraphData[index].services!,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: colorScheme.onSurface),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                              show: true,
                              border:
                                  Border.all(color: Colors.grey, width: 0.6)),
                          gridData: const FlGridData(show: true),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is SummaryReportError) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ShimmerBarCard extends StatelessWidget {
  const ShimmerBarCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    final Color baseColor = brightness == Brightness.light
        ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);
    final Color highlightColor = brightness == Brightness.light
        ? colorScheme.onSurface
        : colorScheme.onSurface.withValues(alpha: 0.6);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 16, top: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // Calendar button (date range picker)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_month,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Bar chart area with correct aspect ratio
            AspectRatio(
              aspectRatio: 1.3,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: 600, // Simulating width based on barGraphData logic
                  child: Stack(
                    children: [
                      // Grid background
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.6),
                        ),
                      ),

                      // Left titles (Y-axis values)
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(5, (index) {
                            return Container(
                              width: 60,
                              height: 10,
                              margin: const EdgeInsets.only(left: 10),
                              color: baseColor,
                            );
                          }),
                        ),
                      ),

                      // Bar graph content
                      Positioned(
                        left: 80, // After the y-axis labels
                        right: 0,
                        top: 0,
                        bottom: 30, // Leave space for x-axis labels
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(8, (index) {
                            // Create bars with varying heights
                            final height = 50.0 + (index % 4) * 30.0;
                            return Container(
                              width: 24,
                              height: height,
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      // Bottom titles (X-axis labels)
                      Positioned(
                        left: 80, // Align with the bars
                        right: 0,
                        bottom: 0,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(8, (index) {
                            return Container(
                              width: 40,
                              height: 10,
                              color: baseColor,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
