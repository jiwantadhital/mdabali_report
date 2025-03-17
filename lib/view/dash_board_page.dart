import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  int _selectedIndex=0;
  late final List<Widget> _pages;

  @override
  void initState() {
    // TODO: implement initState
    _pages=[
      _buildHomePage(),
      _buildTransactionPage(),
    _buildSMSPage(),
    _buildMDabbaliPage()];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<String> months =[
      'Baisakh',
       'Jestha',
        'Asar',
        'Shrawan'
    ];
    String dropDownValue='Baisakh';

    List<String> Appbar=[
      'mDabbali Next Gen Report',
      'Transaction Summary',
      'SMS Summary',
      'mDabbali Summary'
    ];
    return Scaffold(
      appBar:_selectedIndex==0?  AppBar(
        surfaceTintColor: Colors.grey[100],
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title:CustomText(text: 'mDabbali Next Gen Report ',
        fontSize: 18,
        color: Colors.blue,
        weight: FontWeight.bold,),
        centerTitle: true,
      ):_selectedIndex==1?AppBar(
        surfaceTintColor: Colors.grey[100],
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title:CustomText(text: Appbar[1],
        fontSize: 18,
        color: Colors.blue,
        weight: FontWeight.bold,),
        centerTitle: true,):_selectedIndex==2?AppBar(
        surfaceTintColor: Colors.grey[100],
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title:CustomText(text: Appbar[2],
        fontSize: 18,
        color: Colors.blue,
        weight: FontWeight.bold,),
        centerTitle: true,):AppBar(
        surfaceTintColor: Colors.grey[100],
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title:CustomText(text: Appbar[3],
        fontSize: 18,
        color: Colors.blue,
        weight: FontWeight.bold,),
        centerTitle: true,),
      backgroundColor: Colors.grey[100],
      body: AnimatedSwitcher(
        duration: const Duration(microseconds: 300),
        transitionBuilder: (child, animation) =>
         FadeTransition(opacity:animation,
         child: child,),
         child: _pages[_selectedIndex],
         ),
         bottomNavigationBar: _buildBottomNavBar(),
 
    );
  }
  Widget _buildHeaderSection() {
  return Column(
    children: [
      _buildSummaryCard(
        title: 'Utility Payment',
        amount: 'Rs 45,678.30',
        change: '+20% month over month',
        isPositive: true,
        icon: Icons.electric_bolt_rounded,
      ),
      SizedBox(height: 12),
      _buildSummaryCard(
        title: 'DFS(Dr)',
        amount: 'Rs 2,405',
        change: '+33% month over month',
        isPositive: true,
        icon: Icons.arrow_upward_rounded,
      ),
      SizedBox(height: 12),
      _buildSummaryCard(
        title: 'DFS(Cr)',
        amount: 'Rs 1,105',
        change: '-10% month over month',
        isPositive: false,
        icon: Icons.arrow_downward_rounded,
      ),
    ],
  );
}

Widget _buildSummaryCard({
  required String title,
  required String amount,
  required String change,
  required bool isPositive,
  required IconData icon,
}) {
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
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Color(0xFF4285F4).withOpacity(0.15),
          width: 1,
        ),
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
                  color: isPositive ? Color(0xFF34C759) : Color(0xFFFF3B30),
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
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFF4285F4).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                icon,
                                color: Color(0xFF4285F4),
                                size: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6C7A92),
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          amount,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C3E50),
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isPositive
                                ? Color(0xFF34C759).withOpacity(0.1)
                                : Color(0xFFFF3B30).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isPositive
                                    ? Icons.trending_up_rounded
                                    : Icons.trending_down_rounded,
                                color: isPositive ? Color(0xFF34C759) : Color(0xFFFF3B30),
                                size: 12,
                              ),
                              SizedBox(width: 4),
                              Text(
                                change,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isPositive ? Color(0xFF34C759) : Color(0xFFFF3B30),
                                ),
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
                                ? Color(0xFF34C759).withOpacity(0.1)
                                : Color(0xFFFF3B30).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isPositive
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            color: isPositive ? Color(0xFF34C759) : Color(0xFFFF3B30),
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

// If you still need the original _buildSummaryItem for compatibility elsewhere
Widget _buildSummaryItem({
  required String title,
  required String amount,
  required String change,
  required bool isPositive,
  required Color changeColor,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6C7A92),
            ),
          ),
          SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3E50),
            ),
          ),
          SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: changeColor,
            ),
          ),
        ],
      ),
      Icon(
        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
        color: changeColor,
        size: 20,
      ),
    ],
  );
}

//  Widget _buildHeaderSection(){
//   return Column(
//       children: [
//                   Card(
//                     elevation: 2,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         children: [
//                               _buildSummaryItem(
//                                 title: 'Utility Payment',
//                                 amount: 'Rs 45,678.30',
//                                 change:'+20% month over month',
//                                 isPositive: true,
//                                 changeColor: Colors.green),
//                         ],
//                       ),),
//                   ),
//                   const SizedBox(height: 10,),
//                    Card(
//                     color: Colors.white,
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         children: [
//                                 _buildSummaryItem(
//                                   title: 'DFS(Dr)',
//                                   amount: 'Rs 2,405',
//                                   change: '+33% month over month',
//                                   isPositive: true,
//                                   changeColor: Colors.green),
//                         ],
//                       ),),
//                   ),
//                   const SizedBox(height: 10,),
//                    Card(
//                     color: Colors.white,
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         children: [
//                                 _buildSummaryItem(
//                                   title: 'DFS(Cr)',
//                                   amount: 'Rs 1,105',
//                                   change: '-10% month over month',
//                                   isPositive: true,
//                                   changeColor: Colors.red),
                                
//                         ],
//                       ),),
//                   ),
           
//       ],
//   );
//  } 
 
// Widget _buildSummaryItem({
// required String title,
// required String amount,
// required String change,
// required bool isPositive,
// required Color changeColor,}){
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//             CustomText(text: title,
//             fontSize: 12,
//             color: Colors.grey[700],),
//             const SizedBox(height: 4,),
//             CustomText(
//               text: amount,
//               fontSize: 20,
//               color: Colors.black87,
//             ),
//             const SizedBox(height: 4,),
//             CustomText(
//               text:change,
//               fontSize: 10,
//               color: changeColor, ),
//             //  const SizedBox(height: 20,),
              
//         ],
//       )
//     ],
//   );
// }

Widget _buildBottomNavBar(){
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 10
      ),
      ],
    ),
    child: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index)=>setState(() {
        _selectedIndex=index;
      }),
      selectedItemColor: Colors.blue[700],
      unselectedItemColor: Colors.grey[600],
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items:const [
        BottomNavigationBarItem(icon: Icon(Icons.home),
        label: 'HomePage'),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz),
          label: 'Transaction'),
          BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'SMS'),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'mDabbali')
      ]),
  );
}
Widget _buildHomePage(){
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
           fontSize: 20,
           weight: FontWeight.w600,),
           const SizedBox(height: 24,),
         
                 
                  
        ],),
          Center(
            child: CustomText(text: 'All your transaction details',
                        fontSize: 18,
                        weight:FontWeight.w600,
                        color: Colors.black87,),
          ),
         const SizedBox(height: 24,),
           _buildHeaderSection(),
        const SizedBox(height: 24,),
      
           _PieChartCard(),
              const SizedBox(height: 24,),
               CustomText(text: 'Transaction Trends',
        fontSize: 20,
        weight: FontWeight.bold,),
        const SizedBox(height: 16,),
        _buildLineChartCard('Utility', [20000,25000,30000,35000,40000,45000]),
        const SizedBox(height: 24,),
          _buildLineChartCard('DFS(Dr)', [25000,30000,35000,40000,45000]),
                   const SizedBox(height: 24,),
               _buildLineChartCard('DFS(Cr)', [25000,30000,35000,40000,45000]),
               const SizedBox(height: 24,),

      ],
    ),),
  );
}
Widget _buildTransactionPage(){
  return SingleChildScrollView(
    child: Padding(padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
             _buildHeaderSection(),
        const SizedBox(height: 24,),
          CustomText(text: 'Transaction Summary',
        fontSize: 20,
        weight: FontWeight.w600,),
        _buildTransactionList(),
             
        const SizedBox(height: 24,),
       

      
        
      ],
    ),),
  );
}
Widget _buildSMSPage(){
  return SingleChildScrollView(
    child: Padding(padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderSection(),
        const SizedBox(height: 24,),
        CustomText(text: 'SMS Summary',
        fontSize: 20,
        weight: FontWeight.w600,),
        const SizedBox(height: 16,),
         _buildSMSCard(institute: 'Aarjan Saving and Credit Cooperative',
                       totalUsed: '100', 
                       rate:'11.13%',
                      totalAmount: '114',
                      availableBalance: '500'),
              ],
    ),),
  );
}
Widget _buildMDabbaliPage(){
  return SingleChildScrollView(
    child: Padding(padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderSection(),
        const SizedBox(height: 24,),
        CustomText(text: 'mDabali Summary',
        fontSize: 20,
        weight: FontWeight.w600,),
        const SizedBox(height: 16,),
          _buildMDabbaliCard(institute: 'Aarjan Saving and Credit Cooperative',
                           membersLimit:'500',
                           verifiedUser: '500',
                            closedUser: '500',
                             totalUser:'500')

      
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
Widget _buildSMSCard({
  required String institute,
  required  String totalUsed,
  required String rate,
  required String totalAmount,
  required String availableBalance,
}){
  return Card(
elevation: 0,
margin: EdgeInsets.symmetric(vertical: 8),
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12),
),
child: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient( begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4285F4),
              Color(0xFF64B5F6),
            ],
    ),
    border: Border.all(
      width: 1,
      color: Colors.blue
    ),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
         color: Color(0xFF4285F4).withOpacity(0.25),
              offset: Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
      ),
    ]
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // const SizedBox(height: 15,),
      // CustomText(text: institute,fontSize: 16,weight: FontWeight.bold,color: Colors.white,),
      // const SizedBox(height: 12,),
      SizedBox(height: 20,),
      _buildInstituteHeader(institute),
      const SizedBox(height: 16,),
      Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMetricRow('Total Used', totalUsed, Icons.summarize, Colors.white),
          const SizedBox(height: 12,),
            // _buildDetails('Total Used',
            //  totalUsed,
            //   Icons.message,
            //    Colors.white),
            // _buildMetricRow('Rate', rate.to, icon, color)
            _buildMetricRow('Rate', rate, Icons.percent, Colors.white),
            const SizedBox(height: 12,),
            _buildMetricRow('Total Amount', totalAmount, Icons.attach_money, Colors.white),
            const SizedBox(height: 12,),
              //  _buildDetails('Rate',
              //   rate,
              //    Icons.percent,
              //     Colors.white),
              //     _buildDetails('Total Amount',
              //      totalAmount,
              //       Icons.attach_money,
              //        Colors.white),
              _buildMetricRow('Available Balance',
               availableBalance,
                Icons.account_balance_wallet_rounded,
                 Colors.white,
                 isLast: true)
                    //  _buildDetails('Available Balance',
                    //   availableBalance,
                    //    Icons.account_balance_wallet_rounded,
                    //     Colors.white
                    //     ),
        ],
        
        ),
      ),
      const SizedBox(height: 20,)
    ],
  ),
),
  );
}

// Widget _buildMDabbaliCard({
//   required String institute,
//   required  int  membersLimit,
//   required int verifiedUser,
//   required int closedUser ,
//   required int totalUser,
// }){
//   return Card(
// elevation: 2,
// color: Colors.white,
// margin: EdgeInsets.symmetric(vertical: 8),
// shape: RoundedRectangleBorder(
//   borderRadius: BorderRadius.circular(12),
// ),
// child: Container(
//   decoration: BoxDecoration(
//     gradient: LinearGradient(colors: [
//       Colors.blue[500]!,
       
//         const Color.fromARGB(255, 129, 193, 245),
    
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight
//     ),
//     borderRadius: BorderRadius.circular(12),
//   ),
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       const SizedBox(height: 15,),
//       CustomText(text: institute,fontSize: 16,weight: FontWeight.bold,color: Colors.white,),
//       const SizedBox(height: 12,),
//       Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//           _buildDetails('Members Limit',
//            membersLimit,
//             Icons.card_membership,
//              Colors.white),
//              _buildDetails('Verified Users',
//               verifiedUser,
//                Icons.verified_user_sharp,
//                 Colors.white),
//                 _buildDetails('Closed Users',
//                  closedUser,
//                   Icons.person,
//                    Colors.white),
//                    _buildDetails('Total Users',
//                     totalUser,
//                      Icons.person_2,
//                       Colors.white
//                       ),
//                       const SizedBox(height: 12,)
//       ],
//       )
//     ],
//   ),
// ),
//   );
// }

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
Widget _buildMDabbaliCard({
  required String institute,
  required String membersLimit,
  required String verifiedUser,
  required String closedUser,
  required String totalUser,
}) {
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
              Color(0xFF4285F4),
              Color(0xFF64B5F6),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF4285F4).withOpacity(0.25),
              offset: Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildInstituteHeader(institute),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _buildMetricRow(
                    'Members Limit',
                    membersLimit,
                    Icons.card_membership,
                    Colors.white,
                  ),
                  SizedBox(height: 12),
                  _buildMetricRow(
                    'Verified Users',
                    verifiedUser,
                    Icons.verified_user_rounded,
                    Colors.white,
                  ),
                  SizedBox(height: 12),
                  _buildMetricRow(
                    'Closed Users',
                    closedUser,
                    Icons.person_off_rounded,
                    Colors.white,
                  ),
                  SizedBox(height: 12),
                  _buildMetricRow(
                    'Total Users',
                    totalUser,
                    Icons.people_rounded,
                    Colors.white,
                    isLast: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // _buildUsageIndicator(totalUser, membersLimit),
            // SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}

Widget _buildInstituteHeader(String institute) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
       
        Text(
          institute,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  );
}

Widget _buildMetricRow(String label, String value, IconData icon, Color color, {bool isLast = false}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 16,
                ),
              ),
              SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: color.withOpacity(0.9),
                ),
              ),
            ],
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
      if (!isLast)
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Divider(
            color: Colors.white.withOpacity(0.2),
            height: 1,
          ),
        ),
    ],
  );
}

// Widget _buildUsageIndicator(int totalUser, int membersLimit) {
//   final double percentage = (totalUser / membersLimit).clamp(0.0, 1.0);
  
//   return Container(
//     margin: EdgeInsets.symmetric(horizontal: 16),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Usage',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white.withOpacity(0.9),
//               ),
//             ),
//             Text(
//               '${(percentage * 100).toInt()}%',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8),
//         Stack(
//           children: [
//             Container(
//               height: 8,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//             Container(
//               height: 8,
//               width: percentage * (MediaQuery.of(Get.context!).size.width - 32),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
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
                    Text(
                      service,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3E50),
                        letterSpacing: 0.3,
                      ),
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
                      Text(
                        '${_calculateSuccessRate(successCount, pendingCount, failCount)}%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4285F4),
                        ),
                      ),
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
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6C7A92),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3E50),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Rs${_formatAmount(amount)}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
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
// Widget _buildTransactionCard(
//   String service,
//   int successCount,
//   int successAmount,
//   int pendingCount,
//   int pendingAmount,
//   int failCount,
//   int failAmount
// ){
// return Card(
//   elevation: 0,
//   margin: EdgeInsets.symmetric(vertical: 8),
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(12),
//   ),
//   child: Container(
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//            begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//         colors: [
//          Colors.white,
//               Color(0xFFF5F9FF),
//       ]),
//       boxShadow: [BoxShadow(
//        color: Color(0xFF4285F4).withOpacity(0.1),
//               offset: Offset(0, 4),
//               blurRadius: 12,
//               spreadRadius: 0,
//       )

//       ],
//        border: Border.all(
//             color: Color(0xFF4285F4).withOpacity(0.15),
//             width: 1.5,
//           ),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     padding: EdgeInsets.all(16),
//     child: Row(
//    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//  CustomText(text: service,fontSize: 16,weight: FontWeight.bold,color: Colors.blue,),
//         SizedBox(height: 8,),
//         _buildstat('Success', 
//         successCount,
//          successAmount,
//           Colors.green),
//           _buildstat('Pending',pendingCount, pendingAmount, Colors.orange),
//     _buildstat('Failure', failCount, failAmount, Colors.red),
//           ],
//         ),
       
//       // Icon(Icons.trending_up,color: Colors.white,size: 30,)

//       ],
//     ),
//   ),

// );
// }

// Widget _buildstat(String label, int count,int amount,Color color){
//   return Padding(padding: EdgeInsets.symmetric(vertical: 4),
//   child: Row(
//     children: [
//       Icon(Icons.circle,color: color,size: 10,),
//       const SizedBox(width: 4,),
//       CustomText(text: '$label: $count (Rs $amount)',
//       fontSize: 14,
//       color: Colors.blue)
//     ],
//   ),);
// }
Widget _buildLineChartCard(String title,List<double> dataPoints){
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
                  child: AspectRatio(
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
                      
                    ),),
                ),
                 const SizedBox(width: 10,),
                 Expanded(
                   child: Padding(
                    padding: EdgeInsets.only(bottom: 18,right: 15),
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
                   ),),
                 )
              
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

