// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mdabali_report/bloc/summary_report_bloc/bloc/summary_report_bloc.dart';
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/resources/colors.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/nepali_date_range_picker_card.dart';
import 'package:mdabali_report/view/homepage/charts/pie_chart_shimmer.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class PieChartCard extends StatefulWidget {
  const PieChartCard({super.key});

  @override
  State<PieChartCard> createState() => _PieChartCardState();
}

class _PieChartCardState extends State<PieChartCard> {
  int touchedIndex = -1;

  bool _showAllOthers = false;
  NepaliDateTime? _startDate;
  NepaliDateTime? _endDate;
  @override
  void initState() {
    final today = NepaliDateTime.now();
    final oneMonthAgo = NepaliDateTime(
      today.month == 1 ? today.year - 1 : today.year,
      today.month - 1 <= 0 ? 12 : today.month - 1,
      today.day,
    );

    _startDate = oneMonthAgo;
    _endDate = today;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SummaryReportBloc, SummaryReportState>(
      builder: (context, state) {
        if (state is SummaryReportLoading) {
          return const PieChartShimmer();
        } else if (state is SummaryReportError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                const SizedBox(height: 8),
                CustomText(
                  text: state.error,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (state is SummaryReportLoaded) {
          final data = state.summaryReportModel.data;

          if (data == null || data.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          // Filter out entries with 0 successAmount
          final filteredData =
              data.where((item) => (item.successAmount ?? 0) > 0).toList();

          if (filteredData.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          double totalSuccessAmount = filteredData.fold(
              0.0, (sum, item) => sum + (item.successAmount ?? 0).toDouble());

          List<Color> generateDistinctColors(int count) {
            return List<Color>.generate(count, (index) {
              final hue = (360.0 / count) * index;
              return HSLColor.fromAHSL(1.0, hue, 0.6, 0.6).toColor();
            });
          }

          List<Color> chartColors = List<Color>.from(kMemberColorList);
          if (filteredData.length > chartColors.length) {
            chartColors.addAll(generateDistinctColors(
                filteredData.length - chartColors.length));
          }

          List<PieChartSectionData> sections = [];
          List<Widget> indicators = [];
          List<_OthersEntry> othersEntries = [];
          double othersAmount = 0.0;

          for (int i = 0; i < filteredData.length; i++) {
            final entry = filteredData[i];
            final amount = (entry.successAmount ?? 0).toDouble();

            if (amount == 0) continue;

            double percentage = totalSuccessAmount > 0
                ? (amount / totalSuccessAmount) * 100
                : 0.0;

            // Round percentage to 2 decimals to avoid showing 0.00% values
            double roundedPercentage =
                double.parse(percentage.toStringAsFixed(2));

            if (roundedPercentage == 0.0) {
              continue; // Skip entries that contribute too little to matter
            }

            if (percentage < 5.0) {
              othersAmount += amount;
              othersEntries.add(_OthersEntry(
                label: entry.services ?? 'Unknown',
                percentage: percentage,
              ));
              continue;
            }

            // Add to main pie sections
            sections.add(PieChartSectionData(
              color: chartColors[i % chartColors.length],
              value: roundedPercentage,
              title: roundedPercentage.toStringAsFixed(2),
              radius: touchedIndex == i ? 65.0 : 50.0,
              titleStyle: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ));

            indicators.add(_buildIndicator(
              color: chartColors[i % chartColors.length],
              text: entry.services ?? 'Unknown',
              percentage: '${roundedPercentage.toStringAsFixed(2)}%',
              context: context,
            ));
          }
          othersEntries.sort((a, b) => b.percentage.compareTo(a.percentage));

          double othersPercentage = totalSuccessAmount > 0
              ? (othersAmount / totalSuccessAmount) * 100
              : 0;

          if (othersEntries.isNotEmpty && othersPercentage > 0.0) {
            sections.add(PieChartSectionData(
              color: Colors.grey[400],
              value: othersPercentage,
              title: othersPercentage.toStringAsFixed(4),
              radius: 50.0,
              titleStyle: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ));

            indicators.add(_buildIndicator(
              color: Colors.grey,
              text: 'Others',
              percentage: '${othersPercentage.toStringAsFixed(3)}%',
              context: context,
            ));
          }

          return SizedBox(
            width: double.maxFinite,
            child: Card(
              elevation: 4,
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () async {
                          final range = await NepaliDateRangePicker.show(
                              context, _startDate!, _endDate!);
                          if (range != null) {
                            String startFormatted =
                                DateFormat('yyyy-MM-dd').format(range.start);
                            String endFormatted =
                                DateFormat('yyyy-MM-dd').format(range.end);
                            _startDate =
                                NepaliDateTime.fromDateTime(range.start);
                            _endDate = NepaliDateTime.fromDateTime(range.end);

                            context.read<SummaryReportBloc>().add(
                                FetchSummaryReport(
                                    dateFrom: startFormatted,
                                    dateTo: endFormatted,
                                    clientId:
                                        UserSimplePreferences.getClientId()
                                            .toString()));

                            _showAllOthers = false;
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.calendar_month,
                            size: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const SizedBox(width: 18),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: PieChart(PieChartData(
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0.8,
                              centerSpaceRadius: 80,
                              sections: sections,
                            )),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        bottom: 8,
                        right: 15,
                        left: 15,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: indicators.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3.5,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return indicators[index];
                            },
                          );
                        },
                      ),
                    ),
                    if (othersEntries.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                            thickness: 1,
                            color: Theme.of(context).dividerColor),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 12, left: 16, right: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: 'Others includes:',
                            fontSize: 14,
                            weight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final displayedEntries = _showAllOthers
                                ? othersEntries
                                    .where((e) => e.percentage > 0.0)
                                    .toList()
                                : othersEntries
                                    .where((e) => e.percentage > 0.0)
                                    .take(4)
                                    .toList();

                            return Wrap(
                              spacing: 24,
                              runSpacing: 8,
                              children: List.generate(
                                (displayedEntries.length / 2).ceil(),
                                (rowIndex) {
                                  final first = displayedEntries[rowIndex * 2];
                                  final second =
                                      rowIndex * 2 + 1 < displayedEntries.length
                                          ? displayedEntries[rowIndex * 2 + 1]
                                          : null;

                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child:
                                              _buildOthersItem(context, first)),
                                      if (second != null)
                                        Expanded(
                                            child: _buildOthersItem(
                                                context, second))
                                      else
                                        const Spacer(),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (othersEntries.length > 4)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showAllOthers = !_showAllOthers;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _showAllOthers ? 'Show less' : 'View all',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    _showAllOthers
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    size: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                    ],
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                const SizedBox(height: 8),
                CustomText(
                  text: 'Something went wrong',
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

  Widget _buildIndicator({
    required Color color,
    required String text,
    required String percentage,
    required BuildContext context,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle, // Circular shape for consistency
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: text.length > 15
                    ? '${text.substring(0, 12)}...'
                    : text, // Truncate if too long
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
                textOverflow: TextOverflow.ellipsis,
                maxLine: 1,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: percentage,
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildOthersItem(BuildContext context, _OthersEntry entry) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        text: '• ',
        fontSize: 14,
        weight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      Expanded(
        child: CustomText(
          text: '${entry.label}\n ${entry.percentage.toStringAsFixed(4)}%',
          fontSize: 13,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          maxLine: 3,
          textOverflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

class _OthersEntry {
  final String label;
  final double percentage;

  _OthersEntry({required this.label, required this.percentage});
}
