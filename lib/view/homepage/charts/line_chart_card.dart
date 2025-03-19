import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../extracted_widgets/custom_text.dart';

class LineChartCard extends StatelessWidget {
  String title;
  List<double> dataPoints;
 LineChartCard({
    required this.title,
    required this.dataPoints,
    super.key});

  @override
  Widget build(BuildContext context) {
   return Card(
    elevation: 4,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16)
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(text: title,
                  fontSize: 16,
                  weight: FontWeight.bold,
                  color: Colors.blue[600],),
                ),
                const SizedBox(height: 8,),
                SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        drawHorizontalLine: true,
                        horizontalInterval: 5000,
                        getDrawingHorizontalLine: (value){
                          return FlLine(
                            color: Colors.grey.withOpacity(0.2),
                            strokeWidth: 1,
                          );
                        }
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                            interval: 10000,
                            reservedSize:70,
                            getTitlesWidget: (value, meta) {
                             return Padding(padding: EdgeInsets.only(right:0),
                             child: CustomText(text: 'Rs${value.toInt().toString()}',
                             fontSize: 12,
                             color: Colors.grey,),);
                            },),
                          
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval:1,
                              getTitlesWidget: (value, meta) {
                                switch(value.toInt()){
                                  case 0:
                                  return 
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: CustomText(text: 'Poush',
                                    color: Colors.blue[600],),
                                  );
                                  case 1:
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: CustomText(text: 'Magh',
                                    color: Colors.blue[600],),
                                  );
                                  case 2:
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: CustomText(text: 'Falgun',
                                    color: Colors.blue[600],),
                                  );
                                  case 3:
                                  return Padding(
                                    padding: const EdgeInsets.only(top:8 ),
                                    child: CustomText(text: 'Chaitra',
                                    color: Colors.blue[600],),
                                  );
                                  default:
                                 return CustomText(text: '');
                                }}
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            
                            ),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            )
                          ),
                        ),
                        borderData: FlBorderData(show: true,
                        ),
                        minX: 0,
                        maxX: 4,
                        minY: 0,
                        maxY: 50000,
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, dataPoints[0]),
                              FlSpot(1, dataPoints[1]),
                              FlSpot(2, dataPoints[2]),
                              FlSpot(3, dataPoints[3]),
                              FlSpot(4, dataPoints[4]),
                              
                        ],
                      isCurved: true,
                      curveSmoothness: 0.5,
                      color: Colors.blue[200],
                      dotData: FlDotData(show: true)
                      ),
                        ]),
                                  ),
                  ),)
      
      ],
      ),
    ),
  );
  }
}