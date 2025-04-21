import 'package:flutter/material.dart';

import '../extracted_widgets/custom_text.dart';
import 'charts/line_chart_card.dart';
import 'charts/pie_chart_card.dart';
import 'header_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child: Padding(padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius:BorderRadius.circular(8) 
            ),
            child:  Center(
              child:Image.asset('assets/images/arjan_logo.jpeg')
            ),
          ),
          const SizedBox(width:5,),
           CustomText(text:'Arjan saving and credit cooperative',
           textOverflow:TextOverflow.ellipsis,
           letterSpacing: 1,
           fontSize: 16,
           weight: FontWeight.w600,), 
           const SizedBox(height: 24,),
         
                 
                  
        ],),
        const SizedBox(height: 24,),
          CustomText(text: 'All your transaction details',
                      fontSize: 16,
                      weight:FontWeight.w600,
                      color: Colors.black87,),
         const SizedBox(height: 24,),
           HeaderSection(),
        const SizedBox(height: 24,),
      
           PieChartCard(),
              const SizedBox(height: 24,),
               CustomText(text: 'Transaction Trends',
        fontSize: 20,
        weight: FontWeight.bold,),
        const SizedBox(height: 16,),
        LineChartCard(title: 'Utility',dataPoints: [20000,25000,30000,35000,40000,45000],),
        const SizedBox(height: 24,),
        LineChartCard(title: 'DFS(Dr)', dataPoints:[25000,30000,35000,40000,45000]),
                    const SizedBox(height: 24,),
        LineChartCard(title: 'DFS(Cr)', dataPoints: [25000,30000,35000,40000,45000]),
               const SizedBox(height: 24,),

      ],
    ),),
  );
  }
}