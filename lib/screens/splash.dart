import 'package:expense/screens/home_page.dart';
import 'package:expense/screens/login_page.dart';
import 'package:expense/screens/nav_page.dart';
import 'package:expense/screens/signIn_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {

  void initState(){
    super.initState();
    Timer(Duration(seconds: 5),()async{
var pref= await SharedPreferences.getInstance();
 //bool? check= pref.getBool(homepage.login_key);
 var get= pref.getInt("UID");
 print(get);

get==0 ||get== null ?Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>login_page())) :Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>nav_page()));
 /*if(check!=null){
   check ?  Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>nav_page())):Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>signin()));
 }else{
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>signin()));
 }*/

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
Container(
  height: 20,

    child: Image.asset("assets/img/Image20240925213656.jpg",color:  Theme.of(context).brightness==Brightness.light?Color(0xFFF6F6F6):Colors.black,)),
            Text("Monety")

          ],
        ),

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30,left: 10,right: 10),
                child: Image.asset("assets/img/Image20240925213523.png"),
        
              ),
              SizedBox(height: 10,),
              Text("Easy Way To Monitor\nYour Expenses", style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              SizedBox(height: 6,),
              Text("Safe your future by managing your\nexpense right now",style: TextStyle(fontSize: 20,color: Colors.grey),textAlign:TextAlign.center ,)
            ],
          ),
        ),
      ),
    );
  }
}
