import 'package:expense/screens/signIn_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class static_page extends StatelessWidget {
  const static_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistic",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        actions: [],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  color: Color(0XFF6573D3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total expense",style: TextStyle(color: Colors.white,fontSize: 19 ),),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                         text: "3,734" ,style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold,color: Colors.white ),
                            ),
                          TextSpan(
                            text: "/ 4000 per month",style: TextStyle(color: Colors.grey )

                          )
                          ]
                        ),


                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 5,
                child: Container(

            ))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (C)=>homepage()));
            }, icon: Icon(Icons.home)),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=>static_page()));
            }, icon: Icon(Icons.graphic_eq)),
            IconButton(onPressed: (){}, icon: Icon(Icons.add,size: 25,)),
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
            IconButton(onPressed: ()async{
              var prefs= await  SharedPreferences.getInstance();
              prefs.setBool(homepage.login_key, false);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>signin()));
            }, icon: Icon(Icons.exit_to_app))
            //IconButton(onPressed: (){}, icon:Icon(Icons.meda))
          ],
        ),
      ),
    );
  }
}
