import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    List<String> months =[
      'Baisakh',
       'Jestha',
        'Asar',
        'Shrawan'
    ];
    String dropDownValue='Baisakh';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: CustomText(text: 'm Dabbali Next Gen Report ',
        fontSize: 18,
        color: Colors.blue,),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
         padding: EdgeInsets.all(16),
        child: Column(
          children: [
           
            Row(
              children: [
                
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: CustomText(text: 'Logo',
                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                Expanded(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Arjan Saving and Credit cooperative',
                      fontSize: 16,
                      weight:FontWeight.bold,
                      color: Colors.black87,),
                   
                      ],
                  )),
                   Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
             Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(13)
              ),
               child: DropdownButton(
                focusColor: Colors.grey[100],
                value: dropDownValue,
                items: months.map((String months){
                  return DropdownMenuItem<String>(
                    value: months,
                    child:CustomText(text: months));
                }).toList(),
                onChanged:(String ? value){
                  setState(() {
                    dropDownValue= value!;
                  });
                },
                selectedItemBuilder:(BuildContext context){
                  return months.map((String value){
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(text: dropDownValue)
                      ,
                    );
                  }).toList();
               },
                underline: const SizedBox(),
                isExpanded: true,
                dropdownColor: Colors.grey[100],
                icon: Icon(Icons.keyboard_arrow_down,color: Colors.black,),
                ),
             )
            ],),
                 
              ],
            ),
                  
                  const SizedBox(height: 12,),
                   CustomText(text: 'All your transaction details',
                      fontSize: 18,
                      weight:FontWeight.bold,
                      color: Colors.black87,),
                   const SizedBox(height: 24,),
               
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                              _buildSummaryItem(
                                title: 'Utility Payment',
                                amount: 'Rs 45,678.30',
                                change:'+20% month over month',
                                isPositive: true,
                                changeColor: Colors.green),
                        ],
                      ),),
                  ),
                  const SizedBox(height: 10,),
                   Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                                _buildSummaryItem(
                                  title: 'DFS(Dr)',
                                  amount: 'Rs 2405',
                                  change: '+33% month over month',
                                  isPositive: true,
                                  changeColor: Colors.green),
                                  const SizedBox(height: 10,),
                        ],
                      ),),
                  ),
                  const SizedBox(height: 10,),
                   Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                                _buildSummaryItem(
                                  title: 'DFS(Cr)',
                                  amount: 'Rs 1105',
                                  change: '-10% month over month',
                                  isPositive: true,
                                  changeColor: Colors.red),
                                  const SizedBox(height: 10,),
                                
                        ],
                      ),),
                  ),
                     CustomText(text: 'At a Glance',
                  fontSize: 20,
                  weight: FontWeight.bold,
                  color: Colors.black87,),
                  const SizedBox(height: 10,),
                    _pieChartCard(),
                    const SizedBox(height: 10,),
                   _lineChartCard()                     
          ],
        ),),
      ),
    );
  }
}

Widget _buildSummaryItem({
required String title,
required String amount,
required String change,
required bool isPositive,
required Color changeColor,}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            CustomText(text: title,
            fontSize: 12,
            color: Colors.grey[700],),
            const SizedBox(height: 4,),
            CustomText(
              text: amount,
              fontSize: 20,
              color: Colors.black87,
            ),
            const SizedBox(height: 4,),
            CustomText(
              text:change,
              fontSize: 10,
              color: changeColor, ),
              const SizedBox(height: 20,),
              
        ],
      )
    ],
  );
}

Widget _lineChartCard(){
  return Container(
    width: double.maxFinite,
    child: Card(
      child: Padding(
        padding:EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: 'Transaction Trends',
            fontSize: 20,
            weight: FontWeight.bold,
            color: Colors.black87,
            ),
            const SizedBox(height: 16,),
    
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false,),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles=['Baisakh','Jestha','Asar','Shrawan'];
                          if(value.toInt()<titles.length){
                            return CustomText(text: titles[value.toInt()],);
                          }
                          return  CustomText(text: '');
                        },
                      )
                    ),
                  ),
                  lineBarsData:[
                    LineChartBarData(
                      spots: const[
                        FlSpot(0, 38000),
                        FlSpot(1, 42000),
                        FlSpot(2, 40000),
                        FlSpot(3, 408.90)
                      ],
                      isCurved: true,
                      color: Colors.blue[200]
                    )
                  ]
    
              ),
            ))
          ],
        ),),
        
    ),
  );
}


Widget _pieChartCard(){
  return Container(
    width: double.maxFinite,
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding:EdgeInsets.all(10),
        child: Column(
          children: [
            CustomText(text: 'Summary of successful transactions'),
            const SizedBox(height: 16,),
        
          
            SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.brown,
                      value: 41.9,
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white 
                      )
                    ),
                     PieChartSectionData(
                      color: Colors.deepOrange,
                      value: 4,
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white 
                      )
                    ),
                     PieChartSectionData(
                      color: Colors.grey[600],
                      value: 1,
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white 
                      )
                    ),
                     PieChartSectionData(
                      color: Colors.orange,
                      value: 3,
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white 
                      )
                    ),
                     PieChartSectionData(
                      color: Colors.blue,
                      value: 40,
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white 
                      )
                    ),
                     PieChartSectionData(
                      color: Colors.deepPurple,
                      value: 0,
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white 
                      )
                    ),
                     PieChartSectionData(
                      color: Colors.lightBlue,
                      value: 5,
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white 
                      )
                    ),
                     PieChartSectionData(
                      color: Colors.greenAccent,
                      value: 15,
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white 
                      )
                    ),
                     PieChartSectionData(
                      color: Colors.pink,
                      value: 35,
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white 
                      )
                    ),
                  
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 40, 
                )
              ),
            ),
             const SizedBox(height: 10,),
               Card(
            elevation: 8,
             child: Container(
              width: 200,
              decoration: BoxDecoration(
               color: Colors.grey[200],
               borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(text:'Data Pack: 41.9%',
                  fontSize: 15,
                  color:Colors.brown,),
                  const SizedBox(height:10,),
                  CustomText(text:'Electricity: 4%',
                  fontSize: 15,
                  color:Colors.deepOrange,),
                  const SizedBox(height:10,),
                   CustomText(text:'Flight:1%',
                  fontSize: 15,
                  color:Colors.grey[600],),
                  const SizedBox(height:10,),
                   CustomText(text:'Internet: 3%',
                  fontSize: 15,
                  color:Colors.orange,),
                  const SizedBox(height:10,),
                   CustomText(text:'TopUp: 40%',
                  fontSize: 15,
                  color:Colors.blue,),
                  const SizedBox(height:10,),
                   CustomText(text:'TV: 0%',
                  fontSize: 15,
                  color:Colors.purple,),
                  const SizedBox(height:10,),
                   CustomText(text:'Water: 5%',
                  fontSize: 15,
                  color:Colors.lightBlue,),
                  const SizedBox(height:10,),
                   CustomText(text:'Bank Transfer: 15%',
                  fontSize: 15,
                  color:Colors.greenAccent,),
                  const SizedBox(height:10,),
                   CustomText(text:'QR: 35%',
                  fontSize: 15,
                  color:Colors.pink,),
                  
                  
                ],
              ),
             ),
           ),
          ],
        ),),
    ),
  );
}