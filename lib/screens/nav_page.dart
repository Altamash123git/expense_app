import 'package:expense/screens/statics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
class nav {

}

class nav_page extends StatefulWidget {
  const nav_page({super.key});

  @override
  State<nav_page> createState() => _nav_pageState();
}

class _nav_pageState extends State<nav_page> {
  List<Widget> pages=[ homepage(),static_page()];
  int currindx=0;
  @override
  Widget build(BuildContext context) {
    return

      SafeArea(
        child: Scaffold(
        body: pages[currindx],
        
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green,
          //Color(0xfff6f6f6),
          currentIndex: currindx,
        onTap: (index){setState(() {
          currindx=index;
        });
        
        
        },
            items: [BottomNavigationBarItem(icon:Icon(Icons.home,color: Colors.red,size: 25,),label: "" ),
              BottomNavigationBarItem(icon:Icon(Icons.graphic_eq, color: Colors.red,size: 25,) ,label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.add,color: Colors.red,size: 25,),label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle,color: Colors.red,size: 25,),label: ""),
            ]),
        
            ),
      );
  }
}

