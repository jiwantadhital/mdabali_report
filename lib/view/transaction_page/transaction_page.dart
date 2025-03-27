import 'package:flutter/material.dart';
import 'package:mdabali_report/resources/colors.dart';

import '../extracted_widgets/custom_text.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTransactionList(context = context),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(
    BuildContext context,
  ) {
    return Column(
      children: [
        _buildTransactionCard(context, 'Data Pack', 6, 809, 110, 24546, 0, 0),
        _buildTransactionCard(
            context, 'Electricity', 96, 133986, 328, 72079, 1, 0),
        _buildTransactionCard(
            context, 'Internet', 8, 13670, 417, 95786, 6, 40122),
        _buildTransactionCard(
            context, 'TopUp', 1084, 117990, 425, 82956, 84, 6054),
        _buildTransactionCard(context, 'TV', 1, 846, 444, 54886, 2, 0),
        _buildTransactionCard(context, 'Water', 24, 16423, 112, 73677, 2, 3684),
        _buildTransactionCard(
            context, 'Bank_Transfer', 114, 3851498, 420, 213600, 392, 9008839),
        _buildTransactionCard(
            context, 'QR', 1095, 4036716, 477, 997777, 158, 1141924),
        _buildTransactionCard(
            context, 'Wallet', 201, 1679092, 495, 508556, 481, 2197637),
      ],
    );
  }

  Widget _buildTransactionCard(
      BuildContext context,
      String service,
      int successCount,
      int successAmount,
      int pendingCount,
      int pendingAmount,
      int failCount,
      int failAmount) {
    var colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
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
                color: Color(0xFF4285F4).withOpacity(0.1),
                offset: Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.15),
              width: 1.5,
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryFixedDim.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _getServiceIcon(service),
                          color: colorScheme.primary,
                          //Color(0xFF4285F4),
                          size: 22,
                        ),
                      ),
                      SizedBox(width: 12),
                      CustomText(
                        text: service,
                        fontSize: 18,
                        weight: FontWeight.w700,
                        color: colorScheme.onSurface,
                        letterSpacing: 0.3,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryFixedDim.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: colorScheme.primary,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        CustomText(
                          text:
                              '${_calculateSuccessRate(successCount, pendingCount, failCount)}',
                          fontSize: 14,
                          weight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    kBoxShadow,
                    // BoxShadow(
                    //   color: Colors.black.withOpacity(0.03),
                    //   blurRadius: 6,
                    //   spreadRadius: 0,
                    // ),
                  ],
                ),
                padding: EdgeInsets.all(16),
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
      color: Colors.grey.withOpacity(0.2),
    );
  }

  Widget _buildStatColumn(
    String label,
    int count,
    int amount,
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
              SizedBox(width: 4),
              CustomText(
                text: label,
                fontSize: 12,
                weight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              )
            ],
          ),
          SizedBox(height: 10),
          CustomText(
            text: count.toString(),
            fontSize: 18,
            weight: FontWeight.w800,
            color: colorScheme.onSurface,
          ),
          SizedBox(height: 10),
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
        return Icons.money;
      case 'Electricity':
        return Icons.electrical_services;
      case 'Internet':
        return Icons.network_cell;
      case 'Topup':
        return Icons.arrow_upward;
      case 'TV':
        return Icons.tv;
      case 'Water':
        return Icons.water;
      case 'Bank_Transfer':
        return Icons.balance_sharp;
      case 'QR':
        return Icons.qr_code;
      case 'Wallet':
        return Icons.wallet;
      default:
        return Icons.receipt_long;
    }
  }

  String _formatAmount(int amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toString();
    }
  }

  int _calculateSuccessRate(int successCount, int pendingCount, int failCount) {
    int total = successCount + pendingCount + failCount;
    if (total == 0) return 0;
    return ((successCount / total) * 100).round();
  }
}
