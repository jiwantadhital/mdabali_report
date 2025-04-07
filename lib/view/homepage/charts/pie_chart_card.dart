import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mdabali_report/bloc/summary_report_bloc/bloc/summary_report_bloc.dart';
import 'package:mdabali_report/resources/colors.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/date_range_picker_card.dart';
import 'package:mdabali_report/view/homepage/charts/pie_chart_shimmer.dart';

class PieChartCard extends StatefulWidget {
  const PieChartCard({super.key});

  @override
  State<PieChartCard> createState() => _PieChartCardState();
}

class _PieChartCardState extends State<PieChartCard> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<SummaryReportBloc, SummaryReportState>(
      builder: (context, state) {
        if (state is SummaryReportLoading) {
          return PieChartShimmer();
        } else if (state is SummaryReportError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
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

          double totalSuccessAmount = data.fold(
              0.0, (sum, item) => sum + (item.successAmount ?? 0).toDouble());

          List<Color> chartColors = kMemberColorList;

          List<PieChartSectionData> sections = [];
          List<Widget> indicators = [];

          for (int i = 0; i < data.length; i++) {
            double percentage = totalSuccessAmount > 0
                ? ((data[i].successAmount ?? 0) / totalSuccessAmount) * 100
                : 0;

            sections.add(PieChartSectionData(
              color: chartColors[i % chartColors.length],
              value: percentage,
              title: percentage.toStringAsFixed(1),
              radius: touchedIndex == i ? 65.0 : 50.0,
              titleStyle: TextStyle(
                fontSize: touchedIndex == i ? 12.0 : 12.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ));

            indicators.add(_buildIndicator(
              color: chartColors[i % chartColors.length],
              text: '${data[i].services}',
              percentage: '${percentage.toStringAsFixed(1)} %',
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
                          final range =
                              await ThreeMonthRangePicker.show(context);
                          if (range != null) {
                            // Format the start and end dates to 'yyyy-MM-dd' format
                            String startFormatted = DateFormat('yyyy-MM-dd')
                                .format(range.startDate!);
                            String endFormatted = DateFormat('yyyy-MM-dd')
                                .format(range.endDate ?? range.startDate!);
                            // ignore: use_build_context_synchronously
                            context.read<SummaryReportBloc>().add(
                                FetchSummaryReport(
                                    dateFrom: startFormatted,
                                    dateTo: endFormatted));
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 8),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const SizedBox(width: 18),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: PieChart(PieChartData(
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0.5,
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
                          top: 40, bottom: 20, right: 15, left: 15),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics:
                                NeverScrollableScrollPhysics(), // Prevents scrolling inside GridView
                            itemCount: indicators.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Two columns
                              childAspectRatio:
                                  3.5, // Adjust to keep the layout balanced
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
                SizedBox(height: 8),
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
