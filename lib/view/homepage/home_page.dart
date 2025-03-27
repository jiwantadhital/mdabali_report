import 'package:flutter/material.dart';
import 'package:mdabali_report/resources/images_constants.dart';

import '../extracted_widgets/custom_text.dart';
import 'charts/line_chart_card.dart';
import 'charts/pie_chart_card.dart';
import 'header_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  ImagesConstants.arjnaLogo,
                  height: 30,
                  width: 30,
                )),
                const SizedBox(
                  width: 5,
                ),
                CustomText(
                  text: 'Arjan saving and credit cooperative',
                  textOverflow: TextOverflow.ellipsis,
                  letterSpacing: 1,
                  fontSize: 16,
                  weight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            CustomText(
              text: 'All your transaction details',
              fontSize: 16,
              weight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
            const SizedBox(
              height: 24,
            ),
            HeaderSection(),
            const SizedBox(
              height: 24,
            ),
            CustomText(
              text: 'Summary of successful transactions',
              fontSize: 16,
              color: colorScheme.onSurface,
              weight: FontWeight.w600,
            ),
            const SizedBox(
              height: 24,
            ),
            PieChartCard(),
            const SizedBox(
              height: 24,
            ),
            CustomText(
              text: 'Transaction Trends',
              fontSize: 16,
              weight: FontWeight.bold,
            ),
            const SizedBox(
              height: 16,
            ),
            LineChartCard(
              title: 'Utility',
              dataPoints: [20000, 25000, 30000, 35000, 40000, 45000],
            ),
            const SizedBox(
              height: 24,
            ),
            LineChartCard(
                title: 'DFS(Dr)',
                dataPoints: [25000, 30000, 35000, 40000, 45000]),
            const SizedBox(
              height: 24,
            ),
            LineChartCard(
                title: 'DFS(Cr)',
                dataPoints: [25000, 30000, 35000, 40000, 45000]),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
