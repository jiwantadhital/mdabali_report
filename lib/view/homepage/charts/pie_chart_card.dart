
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../extracted_widgets/custom_text.dart';

class PieChartCard extends StatefulWidget {
 const PieChartCard({super.key});

  @override
  State<PieChartCard> createState() => _PieChartCardState();
}

class _PieChartCardState extends State<PieChartCard> {
  int touchedIndex=-1;
  
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    return SizedBox(
      //padding: EdgeInsets.all(8),
      // height: height,
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              const SizedBox(height: 24,),
             CustomText(text: 'Summary of successful transactions',
             fontSize: 18,
            color: Colors.grey[600],
            weight: FontWeight.bold,),
            const SizedBox(height: 24,),
            Row(
              children: [
               
                 const SizedBox(width: 18,),
                
                
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event,pieTouchResponse){
                            setState(() {
                              if(!event.isInterestedForInteractions|| pieTouchResponse==null||pieTouchResponse.touchedSection==null){
                                touchedIndex=-1;
                                return;
                              }
                              touchedIndex=pieTouchResponse.touchedSection!.touchedSectionIndex;
                            });
                          }
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: _getPieChartSections(),
                      )
                      
                    ),),
                ),
                 const SizedBox(width: 10,),
                
              
              ],
            ),
             Padding(
              padding: EdgeInsets.only(bottom: 18,right: 15),
             child: Wrap(
               spacing: 5,
               runSpacing: 8,
               direction: Axis.horizontal,
               alignment: WrapAlignment.start,
               children: [
                  _buildIndicator(color: Colors.brown, text: 'Data Pack: 41.9%'),
                  _buildIndicator(color: Colors.red, text: 'Electricity: 4%'),
                  _buildIndicator(color: Colors.pink, text: 'Internet: 8%'),
                  _buildIndicator(color: Colors.grey, text: 'TV: 0%'),
                  _buildIndicator(color: Colors.blue, text: 'Water: 5%'),
                  _buildIndicator(color: Colors.orange, text: 'Bank Transfer: 15%'),
                                                   _buildIndicator(color: Colors.purple, text: 'QR: 35%'),
               
               ],
             ))
          ],
          
        ),
      ),
    ); 
  }
  List<PieChartSectionData> _getPieChartSections(){
  return [
    PieChartSectionData(
      color: Colors.brown,
      value: 41.9,
      title: '41.9',
      radius: touchedIndex==0?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==0?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
     PieChartSectionData(
      color: Colors.red,
      value: 4,
      title: '4',
      radius: touchedIndex==1?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==1?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
     PieChartSectionData(
      color: Colors.pink,
      value: 8,
      title: '8',
      radius: touchedIndex==2?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==2?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
     PieChartSectionData(
      color: Colors.cyan,
      value: 0,
      title: '0',
      radius: touchedIndex==3?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==3?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
     PieChartSectionData(
      color: Colors.grey,
      value: 5,
      title: '5',
      radius: touchedIndex==4?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==4?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
     PieChartSectionData(
      color: Colors.blue,
      value: 15,
      title: '15',
      radius: touchedIndex==5?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==5?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
     PieChartSectionData(
      color: Colors.orange,
      value: 35,
      title: '35',
      radius: touchedIndex==5?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==5?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
    //  PieChartSectionData(
    //   color: Colors.purple,
    //   value: 35,
    //   title: '35',
    //   radius: touchedIndex==7?60.0:50.0,
    //   titleStyle: TextStyle(
    //     fontSize: touchedIndex==7?20.0:16.0,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.white,
    //   )
    // )
  ];
}

Widget _buildIndicator({required Color color,required String text}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        
        Container(width: 16,height: 16,
        color: color,),
        const SizedBox(width: 8,),
        CustomText(text: text,fontSize: 14,color: Colors.black87,)
      ],
    ),
  );
}
}
