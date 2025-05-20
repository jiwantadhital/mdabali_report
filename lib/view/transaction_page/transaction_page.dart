// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mdabali_report/bloc/summary_report_bloc/bloc/summary_report_bloc.dart';
import 'package:mdabali_report/data/shared_preferences/shared_preferences.dart';
import 'package:mdabali_report/resources/colors.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/nepali_date_range_picker_card.dart';
import 'package:mdabali_report/view/transaction_page/shimmer_transaction_cards.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
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
    var colorScheme = Theme.of(context).colorScheme;
    return RefreshIndicator(
      onRefresh: () {
        //this is to get today date and one month ago date
        final today = DateTime.now();
        final oneMonthAgo = DateTime(
          today.month == 1 ? today.year - 1 : today.year,
          today.month - 1 <= 0 ? 12 : today.month - 1,
          today.day,
        );
        //this is to hit fetch summary report event
        String startFormatted = DateFormat('yyyy-MM-dd').format(oneMonthAgo);
        String endFormatted = DateFormat('yyyy-MM-dd').format(today);

        //this is to show selected date in the calendar
        setState(() {
          _startDate = NepaliDateTime.fromDateTime(oneMonthAgo);
          _endDate = NepaliDateTime.fromDateTime(today);
        });
        context.read<SummaryReportBloc>().add(FetchSummaryReport(
            dateFrom: startFormatted.toString(),
            dateTo: endFormatted.toString(),
            clientId: UserSimplePreferences.getClientId().toString()));
        return Future.delayed(const Duration(milliseconds: 1200));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    final range = await NepaliDateRangePicker.show(
                        context, _startDate!, _endDate!);
                    if (range != null) {
                      // Format the start and end dates to 'yyyy-MM-dd' format
                      String startFormatted =
                          DateFormat('yyyy-MM-dd').format(range.start);
                      String endFormatted =
                          DateFormat('yyyy-MM-dd').format(range.end);
                      setState(() {
                        _startDate = NepaliDateTime.fromDateTime(range.start);
                        _endDate = NepaliDateTime.fromDateTime(range.end);
                      });
                      // ignore: use_build_context_synchronously
                      context.read<SummaryReportBloc>().add(FetchSummaryReport(
                          dateFrom: startFormatted,
                          dateTo: endFormatted,
                          clientId:
                              UserSimplePreferences.getClientId().toString()));
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                        const SizedBox(width: 8),
                        Text(
                          _startDate != null && _endDate != null
                              ? '${NepaliDateFormat('yyyy/MM/dd').format(_startDate!)} '
                                  'to ${NepaliDateFormat('yyyy/MM/dd').format(_endDate!)}'
                              : 'Select date Range',
                          style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildTransactionList(context = context),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionList(
    BuildContext context,
  ) {
    return BlocBuilder<SummaryReportBloc, SummaryReportState>(
      builder: (context, state) {
        if (state is SummaryReportLoading) {
          return const ShimmerTransactionList();
        } else if (state is SummaryReportLoaded) {
          final summaryReportData = state.summaryReportModel.data;
          int index = summaryReportData?.length ?? 0;
          return Column(
              children: List.generate(
                  index,
                  (index) => _buildTransactionCard(
                      context,
                      summaryReportData?[index].services ?? 'Not found',
                      summaryReportData?[index].successCount ?? 0,
                      summaryReportData?[index].successAmount ?? 0,
                      summaryReportData?[index].pendingCount ?? 0,
                      summaryReportData?[index].pendingAmount ?? 0,
                      summaryReportData?[index].failedCount ?? 0,
                      summaryReportData?[index].failedAmount ?? 0)));
        } else if (state is SummaryReportError) {
          return Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(
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

  Widget _buildTransactionCard(
      BuildContext context,
      String service,
      int successCount,
      double successAmount,
      int pendingCount,
      double pendingAmount,
      int failCount,
      double failAmount) {
    var colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4285F4).withValues(alpha: 0.1),
                offset: const Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.15),
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryFixedDim
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            _getServiceIcon(service),
                            color: colorScheme.primary,
                            //Color(0xFF4285F4),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomText(
                            text: service,
                            fontSize: 18,
                            weight: FontWeight.w700,
                            color: colorScheme.onSurface,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    kBoxShadow,
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatColumn(
                        'Success',
                        successCount,
                        successAmount,
                        colorScheme.tertiary,
                        Icons.check_circle_outline,
                        context),
                    _buildVerticalDivider(),
                    _buildStatColumn(
                        'Pending',
                        pendingCount,
                        pendingAmount,
                        colorScheme.inverseSurface,
                        Icons.hourglass_empty,
                        context),
                    _buildVerticalDivider(),
                    _buildStatColumn('Failed', failCount, failAmount,
                        colorScheme.error, Icons.error_outline, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 50,
      width: 1,
      color: Colors.grey.withValues(alpha: 0.2),
    );
  }

  Widget _buildStatColumn(
    String label,
    int count,
    double amount,
    Color color,
    IconData icon,
    BuildContext context,
  ) {
    var colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              const SizedBox(width: 4),
              CustomText(
                text: label,
                fontSize: 12,
                weight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              )
            ],
          ),
          const SizedBox(height: 10),
          CustomText(
            text: count.toString(),
            fontSize: 18,
            weight: FontWeight.w800,
            color: colorScheme.onSurface,
          ),
          const SizedBox(height: 10),
          CustomText(
            text: 'Rs ${_formatAmount(amount)}',
            fontSize: 14,
            weight: FontWeight.w600,
            color: color,
          ),
        ],
      ),
    );
  }

// Helper functions
  IconData _getServiceIcon(String service) {
    // Map service names to appropriate icons
    switch (service) {
      case 'Data Pack':
        return Icons.network_cell;
      case 'Electricity':
        return Icons.electrical_services;
      case 'Internet':
        return Icons.network_wifi_sharp;
      case 'Topup':
        return Icons.arrow_upward;
      case 'TV':
        return Icons.tv;
      case 'Water':
        return Icons.water;
      case 'BANK_TRANSFER':
        return Icons.compare_arrows_rounded;
      case 'QR':
        return Icons.qr_code;
      case 'WALLET':
        return Icons.wallet;
      case 'Landline':
        return Icons.phone;
      case 'Bus Ticket':
        return Icons.directions_bus;
      case 'Flight':
        return Icons.flight_takeoff;
      case 'Government Payment':
        return Icons.account_balance;
      case 'Insurance':
        return Icons.security_rounded;
      default:
        return Icons.receipt_long;
    }
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toString();
    }
  }

//   int _calculateSuccessRate(int successCount, int pendingCount, int failCount) {
//     int total = successCount + pendingCount + failCount;
//     if (total == 0) return 0;
//     return ((successCount / total) * 100).round();
//   }
}
