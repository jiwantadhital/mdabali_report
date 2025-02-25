import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:path/path.dart';

import '../resources/images_constants.dart';

class DashBoardPage extends StatefulWidget {
   DashBoardPage({super.key});

 
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
   bool _isTransactionExpanded=false;
   bool _isSMSExpanded=false;
   bool _ismDabbaliExpanded=false;

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
        automaticallyImplyLeading: false,
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
                    child: Image.asset(ImagesConstants.arjnaLogo,scale: 1,)),
                ),
                const SizedBox(width: 12,),
                Expanded(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Arjan Saving and Credit cooperative',
                      fontSize: 20,
                      weight:FontWeight.bold,
                      color: Colors.black87,),
                   
                      ],
                  )),
                  
                 
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                  
                    const SizedBox(height: 24,),
                   CustomText(text: 'At a Glance',
                   
                  fontSize: 20,
                  weight: FontWeight.bold,
                  color: Colors.black87,),
                  const SizedBox(height: 10,),
                    const SizedBox(height: 24,),
                   _PieChartCard(),
                      const SizedBox(height: 24,),
                    CustomText(text: 'Transaction Summary',fontSize: 20,weight: FontWeight.bold,
                    color: Colors.black87,),
                    const SizedBox(height: 24,),
                    _buildExpandedSection(isExpanded: _isTransactionExpanded,
                     onTap:()=> setState(() {
                       _isTransactionExpanded=!_isTransactionExpanded;
                     }),
                    title: 'Transaction Details',
                    children: [
                _buildTransactionCard('Data Pack', 6, 809, 110, 24546, 0, 0),
                _buildTransactionCard('Electricity', 96, 133986, 328, 72079, 1, 0),
                _buildTransactionCard('Internet', 8, 13670, 417, 95786, 6, 40122),
                _buildTransactionCard('TopUp', 1084, 117990, 425, 82956, 84, 6054),
                _buildTransactionCard('TV', 1, 846, 444, 54886, 2, 0),
                _buildTransactionCard('Water', 24, 16423, 112, 73677, 2, 3684),
                _buildTransactionCard('BANK_TRANSFER', 114, 3851498, 420, 213600, 392, 9008839),
                _buildTransactionCard('QR', 1095, 4036716, 477, 997777, 158, 1141924),
                _buildTransactionCard('WALLET', 201, 1679092, 495, 508556, 481, 2197637),
                    ]),
                      const SizedBox(height: 24,),
                      CustomText(text: 'Transaction Trends',
            fontSize: 20,
            weight: FontWeight.bold,
            color: Colors.black87,
            ),
            const SizedBox(height: 24,),
                    _buildLineChartCard('Utility',
                    [25000,30000,35000,40000,45000]),
                    const SizedBox(height: 15,),
                    _buildLineChartCard('DFS(Dr)', [25000,30000,35000,40000,45000]),
                    const SizedBox(height: 15,),
                    _buildLineChartCard('DFS(Cr)', [25000,30000,35000,40000,45000]),
                 const SizedBox(height: 24,),
                 CustomText(text: 'mDabbali Details',
                 weight: FontWeight.bold,
                 fontSize: 20,
                 color: Colors.black87,),
                 const SizedBox(height: 5,),
                 Divider(thickness: 2,
                 color: Colors.black87,
                 indent: 20,
                 endIndent: 20,),
                 const SizedBox(height: 24,),
                 CustomText(text: 'SMS Summary',
                 fontSize: 20,
                 weight: FontWeight.bold,
                 color: Colors.black87,),
                 const SizedBox(height: 24,),
                 _buildExpandedSection(
                  isExpanded: _isSMSExpanded,
                   onTap: ()=> setState(() {
                     _isSMSExpanded=!_isSMSExpanded;
                   }),
                    title: 'SMS Details',
                    children: [
                      _buildSMSCard(institute: 'Aarjan Saving and Credit Cooperative Limited',
                       totalUsed: 100, 
                       rate:'11.13%',
                      totalAmount: 114,
                      availableBalance: 500),
                    ]),
                      const SizedBox(height: 24,),
                      CustomText(text: 'mDabbali Summary',
                      fontSize: 20,
                      weight: FontWeight.bold,
                      color: Colors.black87,
                      ),
                      const SizedBox(height: 24,),
                      _buildExpandedSection(
                        isExpanded: _ismDabbaliExpanded,
                         onTap: ()=> setState(() {
                           _ismDabbaliExpanded=!_ismDabbaliExpanded;
                         }),
                          title: 'mDabbali Details',
                           children: [
                          _buildMDabbaliCard(institute: 'Aarjan Saving and Credit Cooperative',
                           membersLimit:500,
                           verifiedUser: 500,
                            closedUser: 500,
                             totalUser:500)
                           ])               
          ],
        ),),
      ),
    );
  }

  Widget _buildExpandedSection({
    required bool isExpanded,
    required VoidCallback onTap,
    required String title,
    required List<Widget> children,
  }){

  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: title,
                fontSize: 18,
                weight: FontWeight.bold,
                color: Colors.blue[600],),
                Icon(isExpanded? Icons.expand_less:Icons.expand_more,color: Colors.blue[900],)
              ],
            ), ),
        ),
      ),
      AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: isExpanded?children.length * 120.0:0,
        child: SingleChildScrollView(
          

          child: Column(
            children:children,
          ),
        ),
        )
    ],
  );
  }
}
Widget _buildSMSCard({
  required String institute,
  required  int totalUsed,
  required String rate,
  required int totalAmount,
  required int availableBalance,
}){
  return Card(
elevation: 4,
color: Colors.white,
margin: EdgeInsets.symmetric(vertical: 8),
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12),
),
child: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [
      Colors.blue[100]!,
      Colors.blue[300]!,
    
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox(height: 15,),
      CustomText(text: institute,fontSize: 16,weight: FontWeight.bold,color: Colors.white,),
      const SizedBox(height: 12,),
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          _buildDetails('Total Used',
           totalUsed,
            Icons.message,
             Colors.white),
             _buildDetails('Rate',
              rate,
               Icons.percent,
                Colors.white),
                _buildDetails('Total Amount',
                 totalAmount,
                  Icons.attach_money,
                   Colors.white),
                   _buildDetails('Available Balance',
                    availableBalance,
                     Icons.account_balance_wallet_rounded,
                      Colors.white
                      )
      ],
      )
    ],
  ),
),
  );
}

Widget _buildMDabbaliCard({
  required String institute,
  required  int  membersLimit,
  required int verifiedUser,
  required int closedUser ,
  required int totalUser,
}){
  return Card(
elevation: 4,
color: Colors.white,
margin: EdgeInsets.symmetric(vertical: 8),
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12),
),
child: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [
      Colors.blue[100]!,
      Colors.blue[300]!,
    
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox(height: 15,),
      CustomText(text: institute,fontSize: 16,weight: FontWeight.bold,color: Colors.white,),
      const SizedBox(height: 12,),
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          _buildDetails('Members Limit',
           membersLimit,
            Icons.card_membership,
             Colors.white),
             _buildDetails('Verified Users',
              verifiedUser,
               Icons.verified_user_sharp,
                Colors.white),
                _buildDetails('Closed Users',
                 closedUser,
                  Icons.person,
                   Colors.white),
                   _buildDetails('Total Users',
                    totalUser,
                     Icons.person_2,
                      Colors.white
                      )
      ],
      )
    ],
  ),
),
  );
}

Widget _buildDetails(String label,dynamic value,IconData icon,Color color){
  return Padding(padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
  child:Row(
    children: [
      Icon(icon,color: color,size: 16,),
      const SizedBox(width: 8,),
      CustomText(text: '$label: $value',
      fontSize: 14,
      color: color,)
    ],
  ) ,);
}
Widget _buildTransactionCard(
  String service,
  int successCount,
  int successAmount,
  int pendingCount,
  int pendingAmount,
  int failCount,
  int failAmount
){
return Card(
  elevation: 4,
  margin: EdgeInsets.symmetric(vertical: 8),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        Colors.blue[100]!,
        Colors.blue[300]!
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight),
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.all(16),
    child: Row(
   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
 CustomText(text: service,fontSize: 16,weight: FontWeight.bold,color: Colors.white,),
        SizedBox(height: 8,),
        _buildstat('Success', 
        successCount,
         successAmount,
          Colors.green),
          _buildstat('Pending', pendingCount, pendingAmount, Colors.orange),
    _buildstat('Failure', failCount, failAmount, Colors.red),
          ],
        ),
       
      Icon(Icons.trending_up,color: Colors.white,size: 30,)

      ],
    ),
  ),

);
}
Widget _buildstat(String label, int count,int amount,Color color){
  return Padding(padding: EdgeInsets.symmetric(vertical: 4),
  child: Row(
    children: [
      Icon(Icons.circle,color: color,size: 10,),
      const SizedBox(width: 4,),
      CustomText(text: '$label: $count ($amount)',
      fontSize: 14,
      color: Colors.white,)
    ],
  ),);
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
Widget _buildLineChartCard(String title,List<double> dataPoints){
  return Card(
    elevation: 6,
    color: Colors.white,
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
              Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch(value.toInt()){
                              case 0:
                              return CustomText(text: '0');
                              case 1:
                              return CustomText(text: '20k');
                              case 2:
                              return CustomText(text: '30k');
                              case 3:
                              return CustomText(text: '4ok');
                              case 4:
                              return CustomText(text: '50k');
                              default:
                              return CustomText(text: '');
                            }
                          },),
                        
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              switch(value.toInt()){
                                case 0:
                                return CustomText(text: 'Poush',
                                color: Colors.blue[600],);
                                case 1:
                                return CustomText(text: 'Magh',
                                color: Colors.blue[600],);
                                case 2:
                                return CustomText(text: 'Falgun',
                                color: Colors.blue[600],);
                                case 3:
                                return CustomText(text: 'Chaitra',
                                color: Colors.blue[600],);
                                default:
                               return CustomText(text: '');
                              }
                            },
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
                      maxY: 55000,
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
                    color: Colors.blue[600],
                    dotData: FlDotData(show: true)
                    ),
                      ]),
                                ),
                ),)
    
    ],
    ),
  );
}

class _PieChartCard extends StatefulWidget {
 const _PieChartCard({super.key});

  @override
  State<_PieChartCard> createState() => __PieChartCardState();
}

class __PieChartCardState extends State<_PieChartCard> {
  int touchedIndex=-1;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      child: AspectRatio(
        aspectRatio: 1.3,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              const SizedBox(height: 10,),
             CustomText(text: 'Summary of successful transactions',
            color: Colors.grey[600],
            weight: FontWeight.bold,),
            const SizedBox(height: 24,),
            Row(
              children: [
               
                const SizedBox(width: 18,),
                
                
                Expanded(
                  child:AspectRatio(
                    aspectRatio: 1,
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
                      
                    ),)
                 ),
                 Padding(
                  padding: EdgeInsets.only(bottom: 18),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIndicator(color: Colors.brown, text: 'Data Pack: 41.9%'),
                    const SizedBox(height: 8,),
                    _buildIndicator(color: Colors.red, text: 'Electricity: 4%'),
                    const SizedBox(height: 8,),
                    _buildIndicator(color: Colors.pink, text: 'Internet: 8%'),
                    const SizedBox(height: 8,),
                    _buildIndicator(color: Colors.grey, text: 'TV: 0%'),
                    const SizedBox(height: 8,),
                    _buildIndicator(color: Colors.blue, text: 'Water: 5%'),
                    const SizedBox(height: 8,),
                    _buildIndicator(color: Colors.orange, text: 'Bank Transfer: 15%'),
                    const SizedBox(height: 8,),
                    _buildIndicator(color: Colors.purple, text: 'QR: 35%'),
                   
                  ],
                 ),)
              ],
            ),
          ],
        ) ,
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
      value: 3,
      title: '3',
      radius: touchedIndex==2?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==2?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
     PieChartSectionData(
      color: Colors.cyan,
      value: 40,
      title: '40',
      radius: touchedIndex==3?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==3?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
     PieChartSectionData(
      color: Colors.grey,
      value: 0,
      title: '0',
      radius: touchedIndex==4?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==4?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
     PieChartSectionData(
      color: Colors.blue,
      value: 5,
      title: '5',
      radius: touchedIndex==5?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==5?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
     PieChartSectionData(
      color: Colors.orange,
      value: 15,
      title: '15',
      radius: touchedIndex==6?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==6?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ),
     PieChartSectionData(
      color: Colors.purple,
      value: 35,
      title: '35',
      radius: touchedIndex==7?60.0:50.0,
      titleStyle: TextStyle(
        fontSize: touchedIndex==7?20.0:16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    )
  ];
}

Widget _buildIndicator({required Color color,required String text}){
  return Row(
    children: [
      Container(width: 16,height: 16,
      color: color,),
      const SizedBox(width: 8,),
      CustomText(text: text,fontSize: 14,color: Colors.black87,)
    ],
  );
}
}

