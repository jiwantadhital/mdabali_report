import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdabali_report/bloc/monthly_aggregate_bloc/bloc/monthly_aggregate_bloc.dart';
import 'package:mdabali_report/utils/number_formatter.dart';

import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonthlyAggregateBloc, MonthlyAggregateState>(
      builder: (context, state) {
        if (state is MonthlyAggregateLoading) {
          return Column(
            children:
                List.generate(3, (index) => buildShimmerSummaryCard(context)),
          );
        } else if (state is MonthlyAggregateLoaded) {
          final aggergateData = state.monthlyAggregate.data;
          return Column(
            children: [
              buildSummaryCard(
                context: context,
                title: 'Utility Payment',
                currentMonthAmount: aggergateData?.utility?.currentMonth ?? 0,
                previousMonthAmount: aggergateData?.utility?.previousMonth ?? 0,
              ),
              SizedBox(height: 12),
              buildSummaryCard(
                context: context,
                title: 'DFS(Dr)',
                currentMonthAmount: aggergateData?.dfsDebit!.currentMonth ?? 0,
                previousMonthAmount:
                    aggergateData?.dfsDebit?.previousMonth ?? 0,
              ),
              SizedBox(height: 12),
              buildSummaryCard(
                context: context,
                title: 'DFS(Cr)',
                currentMonthAmount: aggergateData?.dfsCredit!.currentMonth ?? 0,
                previousMonthAmount:
                    aggergateData?.dfsCredit?.previousMonth ?? 0,
              ),
            ],
          );
        }
        if (state is MonthlyAggregateError) {
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

  Map<String, dynamic> calculateGrowth(
      num previousMonthAmount, num currentMonth) {
    if (previousMonthAmount == 0) {
      // Handle special case where previous value is zero to avoid division by zero
      return {
        'change': currentMonth > 0 ? '100%' : '0%',
        'isPositive': currentMonth > 0
      };
    }

    num percentageChange =
        ((currentMonth - previousMonthAmount) / previousMonthAmount) * 100;
    bool isPositive =
        percentageChange >= 0; // True if growth, false if decrement

    return {
      'change':
          '${percentageChange.abs().toStringAsFixed(2)}%', // Keep two decimal places
      'isPositive': isPositive,
    };
  }

  Widget buildSummaryCard({
    required BuildContext context,
    required String title,
    required num currentMonthAmount,
    required num previousMonthAmount,
  }) {
    var colorScheme = Theme.of(context).colorScheme;
    var result = calculateGrowth(previousMonthAmount, currentMonthAmount);
    String change = result['change'];
    bool isPositive = result['isPositive'];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4285F4).withValues(alpha: 0.1),
            offset: Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: colorScheme.surfaceContainer,
        //Colors.white,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color:
                        isPositive ? colorScheme.tertiary : colorScheme.error,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                text: title,
                                fontSize: 14,
                                weight: FontWeight.w500,
                                color: colorScheme.onSurface,
                                letterSpacing: 0.5,
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          CustomText(
                            text:
                                'Rs ${NumberFormatter.formatAmount(currentMonthAmount)}',
                            fontSize: 20,
                            weight: FontWeight.w700,
                            color: colorScheme.onSurface,
                            letterSpacing: 0.2,
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isPositive
                                  ? colorScheme.tertiaryFixedDim
                                  : colorScheme.error.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPositive
                                      ? Icons.trending_up_rounded
                                      : Icons.trending_down_rounded,
                                  color: isPositive
                                      ? colorScheme.tertiary
                                      : colorScheme.error,
                                  size: 12,
                                ),
                                SizedBox(width: 4),
                                CustomText(
                                  text: '$change over month',
                                  fontSize: 12,
                                  weight: FontWeight.w500,
                                  color: isPositive
                                      ? colorScheme.tertiary
                                      : colorScheme.error,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isPositive
                                  ? colorScheme.tertiaryFixedDim
                                  : colorScheme.error.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isPositive
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              color: isPositive
                                  ? colorScheme.tertiary
                                  : colorScheme.error,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildShimmerSummaryCard(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var brightness = Theme.of(context).brightness;

    // Determine shimmer colors based on theme brightness
    Color baseColor = brightness == Brightness.light
        ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);

    Color highlightColor = brightness == Brightness.light
        ? colorScheme.onSurface
        : colorScheme.onSurface.withValues(alpha: 0.6);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4285F4)
                .withValues(alpha: brightness == Brightness.light ? 0.1 : 0.2),
            offset: Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: colorScheme.surfaceContainer,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Shimmer for the left colored bar
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left column with title and values
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Title shimmer
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              width: 100,
                              height: 14,
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          // Amount shimmer
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              width: 140,
                              height: 20,
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          // Percentage change shimmer
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              width: 120,
                              height: 24,
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Right icon shimmer
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
