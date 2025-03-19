import 'package:flutter/material.dart';

import '../extracted_widgets/custom_text.dart';
import '../homepage/header_section.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
   return SingleChildScrollView(
    child: Padding(padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //      HeaderSection(),
        // const SizedBox(height: 24,),
        //   CustomText(text: 'Transaction Summary',
        // fontSize: 20,
        // weight: FontWeight.w600,),
        _buildTransactionList(),
             
        const SizedBox(height: 24,),
       

      
        
      ],
    ),),
  );
  }
  
Widget _buildTransactionList(){
  return Column(
      children: [
         _buildTransactionCard('Data Pack', 6, 809, 110, 24546, 0, 0),
                _buildTransactionCard('Electricity', 96, 133986, 328, 72079, 1, 0),
                _buildTransactionCard('Internet', 8, 13670, 417, 95786, 6, 40122),
                _buildTransactionCard('TopUp', 1084, 117990, 425, 82956, 84, 6054),
                _buildTransactionCard('TV', 1, 846, 444, 54886, 2, 0),
                _buildTransactionCard('Water', 24, 16423, 112, 73677, 2, 3684),
                _buildTransactionCard('Bank_Transfer', 114, 3851498, 420, 213600, 392, 9008839),
                _buildTransactionCard('QR', 1095, 4036716, 477, 997777, 158, 1141924),
                _buildTransactionCard('Wallet', 201, 1679092, 495, 508556, 481, 2197637),
      ],
  );
}

Widget _buildTransactionCard(
  String service,
  int successCount,
  int successAmount,
  int pendingCount,
  int pendingAmount,
  int failCount,
  int failAmount
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 12),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color(0xFFF5F9FF),
            ],
          ),
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
            color: Color(0xFF4285F4).withOpacity(0.15),
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
                        color: Color(0xFF4285F4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _getServiceIcon(service),
                        color: Color(0xFF4285F4),
                        size: 22,
                      ),
                    ),
                    SizedBox(width: 12),
                    CustomText(text: service,
                    fontSize: 18,
                    weight: FontWeight.w700,
                    color:  Color(0xFF2C3E50),
                    letterSpacing: 0.3,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF4285F4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Color(0xFF4285F4),
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      CustomText(
                        text: '${_calculateSuccessRate(successCount, pendingCount, failCount)}',
                        fontSize: 14,
                        weight: FontWeight.w600,
                        color: Color(0xFF4285F4),),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 6,
                    spreadRadius: 0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatColumn('Success', successCount, successAmount, Color(0xFF34C759), Icons.check_circle_outline),
                  _buildVerticalDivider(),
                  _buildStatColumn('Pending', pendingCount, pendingAmount, Color(0xFFFF9500), Icons.hourglass_empty),
                  _buildVerticalDivider(),
                  _buildStatColumn('Failed', failCount, failAmount, Color(0xFFFF3B30), Icons.error_outline),
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

Widget _buildStatColumn(String label, int count, int amount, Color color, IconData icon) {
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
              color:Color(0xFF6C7A92) ,)
          ],
        ),
        SizedBox(height: 8),
        CustomText(text: count.toString(),
        fontSize: 18,
        weight: FontWeight.w800,
        color: Color(0xFF2C3E50),),
        SizedBox(height: 4),
        CustomText(
          text: 'Rs${_formatAmount(amount)}',
          fontSize: 14,
          weight: FontWeight.w600,
          color: color,),
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
    return  Icons.tv;
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