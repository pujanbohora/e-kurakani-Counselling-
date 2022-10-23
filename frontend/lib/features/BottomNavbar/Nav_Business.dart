import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

class BottNavBusiness extends StatefulWidget {
  const BottNavBusiness({ Key? key }) : super(key: key);

  @override
  State<BottNavBusiness> createState() => _BottNavBusinessState();
}

class _BottNavBusinessState extends State<BottNavBusiness> {
  int currentindex = 0;
  final screens = [
    Center(child: Text('Home',style: TextStyle(fontSize: 50),),),
    Center(child: Text('Counsellor',style: TextStyle(fontSize: 50),),),
    Center(child: Text('Appointment',style: TextStyle(fontSize: 50),),),
    Center(child: Text('Chats',style: TextStyle(fontSize: 50),),),
    Center(child: Text('Profile',style: TextStyle(fontSize: 50),),)];
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
        onTap: (index)=> setState(() =>currentindex = index),
        items: [
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label:"Home"
            ),

            BottomNavigationBarItem(
            icon:Icon(Icons.verified_user),
            label:"Counsellor"
           ),

            BottomNavigationBarItem(
            icon:Icon(Icons.calendar_month),
            label:"Appointment"
            ),

            BottomNavigationBarItem(
            icon:Icon(Icons.chat),
            label:"Chats"
           ),

            BottomNavigationBarItem(
            icon:Icon(Icons.person),
            label:"Profile"
           )
        ])
           );
  }
}
     