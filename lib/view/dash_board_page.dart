
import 'package:flutter/material.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'homepage/home_page.dart';
import 'mdabali_page/mdabali_page.dart';
import 'sms_page/sms_page.dart';
import 'transaction_page/transaction_page.dart';

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
    _pages=[
      HomePage(),
      TransactionPage(),
      SmsPage(),
    MdabaliPage()];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<String> appBar=[
      'mDabali Next Gen Report',
      'Transaction Summary',
      'SMS Summary',
      'mDabali Summary'
    ];
    return Scaffold(
      appBar:_selectedIndex==0?  AppBar(
        surfaceTintColor: Colors.grey[100],
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title:CustomText(text: appBar[0],
        fontSize: 18,
        color: Colors.blue,
        weight: FontWeight.bold,),
        centerTitle: true,
      ):_selectedIndex==1?AppBar(
        surfaceTintColor: Colors.grey[100],
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title:CustomText(text: appBar[1],
        fontSize: 18,
        color: Colors.blue,
        weight: FontWeight.bold,),
        centerTitle: true,):_selectedIndex==2?AppBar(
        surfaceTintColor: Colors.grey[100],
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title:CustomText(text: appBar[2],
        fontSize: 18,
        color: Colors.blue,
        weight: FontWeight.bold,),
        centerTitle: true,):AppBar(
        surfaceTintColor: Colors.grey[100],
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title:CustomText(text: appBar[3],
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
  }}



