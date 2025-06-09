import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdabali_report/bloc/sms_summary_bloc/bloc/sms_summary_bloc.dart';
import 'package:mdabali_report/bloc/topup_summary_bloc/bloc/topup_summary_bloc.dart';
import 'package:mdabali_report/utils/number_formatter.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class SmsPage extends StatefulWidget {
  const SmsPage({super.key});

  @override
  State<SmsPage> createState() => _SmsPageState();
}

class _SmsPageState extends State<SmsPage> {
  @override
  void initState() {
    context.read<TopupSummaryBloc>().add(FetchTopupSummary());
    context.read<SmsSummaryBloc>().add(FetchSmsSummary());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return RefreshIndicator(
      onRefresh: () {
        context.read<TopupSummaryBloc>().add(FetchTopupSummary());
        context.read<SmsSummaryBloc>().add(FetchSmsSummary());
        return Future.delayed(const Duration(milliseconds: 1200));
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'SMS Summary',
                fontSize: 16,
                weight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<SmsSummaryBloc, SmsSummaryState>(
                builder: (context, state) {
                  if (state is SmsSummaryLoading) {
                    return ShimmerTopupCard(context: context);
                  } else if (state is SmsSummaryLoaded) {
                    final smsData = state.smsSummaryModel.data;
                    return _buildSMSCard(
                        smsCount: smsData!.smsCount ?? 0,
                        rate: smsData.smsRate ?? 0,
                        totalAmount: smsData.totalAmount ?? 0,
                        availableBalance: smsData.availableCount ?? 0,
                        context: context);
                  } else if (state is SmsSummaryError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline,
                              color: Theme.of(context).colorScheme.error,
                              size: 24),
                          const SizedBox(height: 8),
                          CustomText(
                            text: state.error,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
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
                              color: Theme.of(context).colorScheme.error,
                              size: 24),
                          const SizedBox(height: 8),
                          CustomText(
                            text: 'Failed to load Data',
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 16,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomText(
                text: 'TopUp Summary',
                fontSize: 16,
                weight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<TopupSummaryBloc, TopupSummaryState>(
                builder: (context, state) {
                  if (state is TopupSummaryLoading) {
                    return ShimmerTopupCard(
                      context: context,
                    );
                  } else if (state is TopupSummaryLoaded) {
                    final topupData = state.topupSummaryModel.data;
                    return _buildTopupCard(
                        transactionAmount: topupData?.transactionAmount ?? 0,
                        remainingBalance: topupData?.remainingBalance ?? 0,
                        transactionCount: topupData?.transactionCount ?? 0,
                        context: context);
                  } else if (state is TopupSummaryError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline,
                              color: Theme.of(context).colorScheme.error,
                              size: 24),
                          const SizedBox(height: 8),
                          CustomText(
                            text: state.error,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
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
                              color: Theme.of(context).colorScheme.error,
                              size: 24),
                          const SizedBox(height: 8),
                          CustomText(
                            text: 'Failed to load Data',
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 16,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSMSCard({
    required BuildContext context,
    required int smsCount,
    required double rate,
    required double totalAmount,
    required int availableBalance,
  }) {
    var colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Stack(
        children: [
          // Main Card with Glassmorphism Effect
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  width: 1.5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  children: [
                    buildMetricRow(
                      'Sms Count',
                      smsCount.toString(),
                      Icons.sms_outlined,
                      colorScheme.onSurface,
                      iconBgColor:
                          colorScheme.onSurface.withValues(alpha: 0.15),
                    ),
                    // buildDivider(),
                    // buildMetricRow(
                    //   'SMS Rate',
                    //   'Rs $rate',
                    //   Icons.attach_money_outlined,
                    //   colorScheme.onSurface,
                    //   iconBgColor: Colors.greenAccent.withValues(alpha: 0.25),
                    // ),
                    buildDivider(),
                    buildMetricRow(
                      'Total Cost',
                      NumberFormatter.formatAmount(totalAmount),
                      Icons.money,
                      colorScheme.onSurface,
                      iconBgColor: Colors.redAccent.withValues(alpha: 0.5),
                    ),
                    buildDivider(),
                    buildMetricRow(
                      'Available Count',
                      NumberFormatter.formatAmount(availableBalance),
                      Icons.balance,
                      colorScheme.onSurface,
                      iconBgColor: Colors.amberAccent.withValues(alpha: 0.5),
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Decorative bubble circle
          //   Positioned(
          //     top: 10,
          //     right: -20,
          //     child: Container(
          //       width: 100,
          //       height: 100,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.blue.withValues(alpha: 0.1),
          //       ),
          //     ),
          //   ),
          //   Positioned(
          //     bottom: 20,
          //     left: -30,
          //     child: Container(
          //       width: 80,
          //       height: 80,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.blue.withValues(alpha: 0.1),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  Widget _buildTopupCard({
    required BuildContext context,
    required double transactionAmount,
    required double remainingBalance,
    required int transactionCount,
  }) {
    var colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Stack(
        children: [
          // Main Card with Glassmorphism Effect
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  children: [
                    Column(
                      children: [
                        buildMetricRow(
                          'Transaction Count',
                          transactionCount.toString(),
                          Icons.format_list_numbered_rtl_outlined,
                          colorScheme.onSurface,
                          iconBgColor: Colors.redAccent.withValues(alpha: 0.5),
                        ),
                        buildDivider(),
                        buildMetricRow(
                          'Transaction Amount',
                          'Rs ${NumberFormatter.formatAmount(transactionAmount)}',
                          CupertinoIcons.creditcard,
                          colorScheme.onSurface,
                          iconBgColor:
                              colorScheme.onSurface.withValues(alpha: 0.15),
                        ),
                        buildDivider(),
                        buildMetricRow(
                          'Available Balance',
                          'Rs ${NumberFormatter.formatAmount(remainingBalance)}',
                          Icons.balance,
                          colorScheme.onSurface,
                          iconBgColor:
                              Colors.greenAccent.withValues(alpha: 0.25),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Decorative bubble circle
          //   Positioned(
          //     top: 10,
          //     right: -20,
          //     child: Container(
          //       width: 100,
          //       height: 100,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.blue.withValues(alpha: 0.1),
          //       ),
          //     ),
          //   ),
          //   Positioned(
          //     bottom: 20,
          //     left: -30,
          //     child: Container(
          //       width: 80,
          //       height: 80,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.blue.withValues(alpha: 0.1),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  Widget buildMetricRow(
    String label,
    String value,
    IconData icon,
    Color color, {
    bool isLast = false,
    Color? iconBgColor,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                // Icon with Custom Background
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBgColor ?? Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 14),
                // Label Text
                Expanded(
                  child: CustomText(
                    text: label,
                    fontSize: 15,
                    weight: FontWeight.w500,
                    color: color.withValues(alpha: 0.9),
                  ),
                )
              ],
            ),
          ),
          // Value with Highlight
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: CustomText(
                text: value.toString(),
                fontSize: 16,
                weight: FontWeight.bold,
                color: color,
                letterSpacing: 0.1,
              )),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withValues(alpha: 0),
              Colors.blue.withValues(alpha: 0.5),
              Colors.blue.withValues(alpha: 0),
            ],
            stops: [0.0, 0.5, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}

class ShimmerTopupCard extends StatelessWidget {
  final BuildContext context;

  const ShimmerTopupCard({required this.context, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var brightness = Theme.of(context).brightness;

    Color baseColor = brightness == Brightness.light
        ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);

    Color highlightColor = brightness == Brightness.light
        ? colorScheme.onSurface
        : colorScheme.onSurface.withValues(alpha: 0.6);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              3,
              (index) => Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: baseColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Container(
                              height: 16,
                              color: baseColor,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Container(
                            height: 16,
                            width: 50,
                            color: baseColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (index < 2)
                        Container(
                          height: 1,
                          color: baseColor,
                        ),
                      const SizedBox(height: 10),
                    ],
                  )),
        ),
      ),
    );
  }
}
