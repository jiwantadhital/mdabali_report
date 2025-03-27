import 'package:flutter/material.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSummaryCard(
          context: context,
          title: 'Utility Payment',
          amount: 'Rs 45,678.30',
          change: '+20% month over month',
          isPositive: true,
          // icon: Icons.electric_bolt_rounded,
        ),
        SizedBox(height: 12),
        buildSummaryCard(
          context: context,
          title: 'DFS(Dr)',
          amount: 'Rs 2,405',
          change: '+33% month over month',
          isPositive: true,
          // icon: Icons.arrow_upward_rounded,
        ),
        SizedBox(height: 12),
        buildSummaryCard(
          context: context,
          title: 'DFS(Cr)',
          amount: 'Rs 1,105',
          change: '-10% month over month',
          isPositive: false,
          // icon: Icons.arrow_downward_rounded,
        ),
      ],
    );
  }

  Widget buildSummaryCard({
    required BuildContext context,
    required String title,
    required String amount,
    required String change,
    required bool isPositive,

    // required IconData icon,
  }) {
    var colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4285F4).withOpacity(0.1),
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
                              // Container(
                              //   padding: EdgeInsets.all(8),
                              //   decoration: BoxDecoration(
                              //     color: Color(0xFF4285F4).withOpacity(0.1),
                              //     borderRadius: BorderRadius.circular(10),
                              //   ),
                              //   child: Icon(
                              //     icon,
                              //     color: Color(0xFF4285F4),
                              //     size: 16,
                              //   ),
                              // ),
                              // SizedBox(width: 10),
                              CustomText(
                                text: title,
                                fontSize: 14,
                                weight: FontWeight.w500,
                                color: colorScheme.onSurface,
                                //Color(0xFF6C7A92),
                                letterSpacing: 0.5,
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          CustomText(
                            text: amount,
                            fontSize: 20,
                            weight: FontWeight.w700,
                            color: colorScheme.onSurface,
                            //Color(0xFF2C3E50),
                            letterSpacing: 0.2,
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isPositive
                                  ? colorScheme.tertiaryFixedDim
                                  : colorScheme.error.withOpacity(0.1),
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
                                  text: change,
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
                                  : colorScheme.error.withOpacity(0.1),
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
}
