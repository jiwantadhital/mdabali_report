import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class LineChartCard extends StatelessWidget {
  final String title;
  final List<double> dataPoints;
  final List<String> months;
  const LineChartCard(
      {required this.title,
      required this.dataPoints,
      super.key,
      required this.months});
  double getOptimalInterval(double maxValue) {
    if (maxValue <= 1000) {
      return 200; // Small values, smaller interval
    } else if (maxValue <= 5000) {
      return 1000; // Medium range
    } else if (maxValue <= 20000) {
      return 2000; // Larger range
    } else if (maxValue <= 50000) {
      return 5000; // Even larger
    } else if (maxValue <= 100000) {
      return 10000;
    } else if (maxValue <= 500000) {
      return 50000;
    } else if (maxValue <= 1000000) {
      return 100000;
    } else if (maxValue <= 5000000) {
      return 500000; // Very large values
    } else if (maxValue <= 10000000) {
      // 1 Crore
      return 1000000;
    } else if (maxValue <= 25000000) {
      // 2.5 Cr
      return 2500000;
    } else if (maxValue <= 50000000) {
      // 5 Cr
      return 5000000;
    } else if (maxValue <= 100000000) {
      // 10 Cr
      return 10000000;
    } else if (maxValue <= 250000000) {
      // 25 Cr
      return 25000000;
    } else if (maxValue <= 500000000) {
      // 50 Cr
      return 50000000;
    } else {
      return 100000000; // 10 Cr+
    }
  }

  double getMaxValue(List<double> dataPoints) {
    return dataPoints.isEmpty
        ? 0
        : dataPoints.reduce((a, b) => a > b ? a : b + 1000);
  }

  double getMinValue(List<double> dataPoints) {
    return dataPoints.isEmpty ? 0 : dataPoints.reduce((a, b) => a < b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    double maxValue = getMaxValue(dataPoints);
    double minValue = getMinValue(dataPoints);
    double interval = getOptimalInterval(maxValue);
    var colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 4,
      color: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: title,
                fontSize: 16,
                weight: FontWeight.bold,
                color: colorScheme.primaryFixed,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  LineChartData(
                      minY: (minValue ~/ interval) * interval, // Rounded minY
                      maxY: ((maxValue / interval).ceil()) *
                          interval, // Rounded max
                      minX: 0,
                      maxX: 4,
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          tooltipBgColor: colorScheme.primary,
                          getTooltipItems: (List<LineBarSpot> touchedSpots) {
                            return touchedSpots.map((spot) {
                              return LineTooltipItem(
                                'Rs ${spot.y.toInt().toString()}',
                                TextStyle(
                                  color: colorScheme.onPrimary,
                                  fontSize: 16,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          drawHorizontalLine: false,
                          horizontalInterval: interval,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color:
                                  colorScheme.onSurface.withValues(alpha: 0.3),
                              strokeWidth: 1,
                            );
                          }),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: interval,
                            reservedSize: 70,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: CustomText(
                                  text: 'Rs ${value.toInt().toString()}',
                                  fontSize: 12,
                                  color: colorScheme.onSurface,
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                if (index >= 0 && index < months.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, right: 10, left: 12),
                                    child: CustomText(
                                      text: months[index], // Use dynamic month
                                      color: colorScheme.primaryFixed,
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              }),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: false,
                        )),
                      ),
                      borderData: FlBorderData(
                          show: false,
                          border:
                              Border.all(color: colorScheme.onSurfaceVariant)),
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            dataPoints.length,
                            (index) =>
                                FlSpot(index.toDouble(), dataPoints[index]),
                          ),
                          preventCurveOverShooting: true,
                          belowBarData: BarAreaData(
                            show: true,
                            // color:LinearGradient(colors: colors)
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.5, 1.0],
                              colors: [
                                colorScheme.primary.withValues(alpha: 0.7),
                                colorScheme.primary.withValues(alpha: 0.3),
                                colorScheme.primary.withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                          isCurved: true,
                          curveSmoothness: 0.35,
                          color: colorScheme.primary,
                          dotData: const FlDotData(show: false),
                        ),
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShimmerLineChartCard extends StatelessWidget {
  const ShimmerLineChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var brightness = Theme.of(context).brightness;

    // Shimmer colors based on theme brightness
    Color baseColor = brightness == Brightness.light
        ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);

    Color highlightColor = brightness == Brightness.light
        ? colorScheme.onSurface
        : colorScheme.onSurface.withValues(alpha: 0.6);

    return Card(
      elevation: 4,
      color: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Shimmer
            Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                height: 20,
                width: 120,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Line Chart Shimmer
            Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
