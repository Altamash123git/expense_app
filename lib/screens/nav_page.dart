import 'package:expense/screens/add_expense.dart';
import 'package:expense/screens/example.dart';
import 'package:expense/screens/statics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'login_page.dart';
class nav {

}

class nav_page extends StatefulWidget {
  const nav_page({super.key});

  @override
  State<nav_page> createState() => _nav_pageState();
}

class _nav_pageState extends State<nav_page> {
  List<Widget> pages=[ homepage(),static_page(),add_expense(), example()];
  int currindx=0;
  @override
  Widget build(BuildContext context) {
    return

      SafeArea(
        child: Scaffold(

        body:

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/img/bg_logoexpenseapp.png',
                    height: 40,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(
                          Icons.search,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: IconButton(
                          onPressed: () async {
                            var pref = await SharedPreferences.getInstance();
                            pref.setInt("UID", 0);

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (C) => login_page()));
                          },
                          icon: Icon(
                            Icons.exit_to_app,
                            size: 35,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            Expanded(

                child: pages[currindx]),
          ],
        ),
        
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.yellowAccent,
          elevation: 11,
          fixedColor: Colors.green,
          //Color(0xfff6f6f6),
          currentIndex: currindx,
        onTap: (index){setState(() {
          currindx=index;
        });
        
        
        },
            items: [BottomNavigationBarItem(icon:Icon(Icons.home,color: Colors.red,size: 25,),label: "" ),
              BottomNavigationBarItem(icon:Icon(Icons.graphic_eq, color: Colors.red,size: 25,) ,label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.add_circle_outlined,color: Colors.red,size: 35,),label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.notifications_active,size: 25,color: Colors.red,),label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle,color: Colors.red,size: 25,),label: ""),
            ]),
        
            ),
      );
  }
}

