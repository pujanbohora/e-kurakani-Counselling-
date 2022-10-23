import 'package:flutter/material.dart';


import '../../../../core/theme/colors.dart';

class BottNavAdmin extends StatefulWidget {
  const BottNavAdmin({ Key? key }) : super(key: key);

  @override
  State<BottNavAdmin> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottNavAdmin> {
  int currentindex = 0;
  final screens = [
    Center(child: Text('Home',style: TextStyle(fontSize: 50),),),
    Center(child: Text('Category',style: TextStyle(fontSize: 50),),),
    Center(child: Text('Request',style: TextStyle(fontSize: 50),),),
    Center(child: Text('Appointment',style: TextStyle(fontSize: 50),),),
    Center(child: Text('Settings',style: TextStyle(fontSize: 50),),)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(
        index: currentindex,
        children: screens),
         
       bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: CustomColors.primaryBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        
        unselectedFontSize: 10,
        selectedFontSize: 12,
        iconSize: 25,
        selectedLabelStyle: TextStyle(
           fontWeight: FontWeight.bold
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold
        ),

        currentIndex: currentindex,
        onTap: (index)=> setState(() =>currentindex = index,
        ),
        items: [
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label:"Home"
            ),

            BottomNavigationBarItem(
            icon:Icon(Icons.category),
            label:"Category"
            ),

            BottomNavigationBarItem(
            icon:Icon(Icons.message_outlined),
            label:"Request"
            ),

            BottomNavigationBarItem(
            icon:Icon(Icons.calendar_month),
            label:"Appointment"
           ),

            BottomNavigationBarItem(
            icon:Icon(Icons.settings),
            label:"Settings"
           )
        ])
       ,
      
    );
  }
}

