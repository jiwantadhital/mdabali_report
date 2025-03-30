import 'dart:ui';

import 'package:flutter/material.dart';

import '../extracted_widgets/custom_text.dart';

class SmsPage extends StatelessWidget {
  const SmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HeaderSection(),
            // const SizedBox(height: 24,),
            // CustomText(text: 'SMS Summary',
            // fontSize: 20,
            // weight: FontWeight.w600,),
            // const SizedBox(height: 16,),
            _buildSMSCard(
                institute: 'Aarjan Saving and Credit Cooperative',
                totalUsed: '100',
                rate: '11.13%',
                totalAmount: '114',
                availableBalance: '500',
                context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildSMSCard({
    required BuildContext context,
    required String institute,
    required String totalUsed,
    required String rate,
    required String totalAmount,
    required String availableBalance,
  }) {
    var colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Stack(
        children: [
          // Main Card with Glassmorphism Effect
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: colorScheme.primary.withOpacity(0.3), width: 1.5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.1),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      // buildInstituteHeader(institute),

                      SizedBox(height: 24),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            buildMetricRow(
                              'Total Used',
                              totalUsed,
                              Icons.add,
                              colorScheme.onSurface,
                              iconBgColor:
                                  colorScheme.onSurface.withOpacity(0.15),
                            ),
                            buildDivider(),
                            buildMetricRow(
                              'Rate',
                              rate,
                              Icons.percent,
                              colorScheme.onSurface,
                              iconBgColor: Colors.greenAccent.withOpacity(0.25),
                            ),
                            buildDivider(),
                            buildMetricRow(
                              'Total Amount',
                              totalAmount,
                              Icons.money,
                              colorScheme.onSurface,
                              iconBgColor: Colors.redAccent.withOpacity(0.5),
                            ),
                            buildDivider(),
                            buildMetricRow(
                              'Available Balance',
                              availableBalance,
                              Icons.balance,
                              colorScheme.onSurface,
                              iconBgColor: Colors.amberAccent.withOpacity(0.5),
                              isLast: true,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Decorative bubble circle
          Positioned(
            top: 10,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInstituteHeader(String institute) {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        children: [
          // Badge with Container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
              border: Border.all(
                color: Colors.blue.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Institute Icon
                // Container(
                //   padding: EdgeInsets.all(8),
                //   decoration: BoxDecoration(
                //     color: Colors.white.withOpacity(0.2),
                //     shape: BoxShape.circle,
                //   ),
                //   child: Icon(
                //     Icons.school_rounded,
                //     color: Colors.white,
                //     size: 18,
                //   ),
                // ),
                // SizedBox(width: 12),
                // Institute Name with Text Shadow,
                CustomText(
                  text: institute,
                  fontSize: 15,
                  weight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 0.5,
                )
              ],
            ),
          ),
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
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Icon with Custom Background
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBgColor ?? Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 2),
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
              SizedBox(width: 14),
              // Label Text
              CustomText(
                text: label,
                fontSize: 15,
                weight: FontWeight.w500,
                color: color.withOpacity(0.9),
              )
            ],
          ),
          // Value with Highlight
          Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: CustomText(
                text: value.toString(),
                fontSize: 16,
                weight: FontWeight.bold,
                color: color,
                letterSpacing: 0.5,
              )),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0),
              Colors.blue.withOpacity(0.5),
              Colors.blue.withOpacity(0),
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
