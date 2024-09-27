
import 'package:expense/model/usermodel.dart';
import 'package:expense/screens/login_page.dart';
import 'package:expense/screens/nav_page.dart';
import 'package:expense/screens/signIn_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Database.dart';
import 'home_page.dart';

class login_page extends StatefulWidget {


  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  @override
  DbHelper dbHelper= DbHelper.getInstance();

  TextEditingController namecontroller= TextEditingController();

  TextEditingController emailcontroller= TextEditingController();

  TextEditingController paswrdcontroller= TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(

            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: namecontroller,

              decoration: InputDecoration(
                  hintText: "Enter your good name",
                  label: Text("name"),
                  focusedBorder: OutlineInputBorder(),


                  border: OutlineInputBorder(
                    //borderSide:BorderSide.strokeAlignInside, ,
                    borderRadius: BorderRadius.circular(15),

                  )
              ),
            ),
          ),
          SizedBox(
            height: 10,

          ),
          Padding(

            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: emailcontroller,

              decoration: InputDecoration(
                  hintText: "Enter your email",
                  label: Text("email"),
                  focusedBorder: OutlineInputBorder(),


                  border: OutlineInputBorder(
                    //borderSide:BorderSide.strokeAlignInside, ,
                    borderRadius: BorderRadius.circular(15),

                  )
              ),
            ),
          ),SizedBox(height: 15,),
          Padding(

            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: paswrdcontroller,
              obscureText: true,


              decoration: InputDecoration(
                  hintText: "Enter Password",
                  label: Text("password"),

                  focusedBorder: OutlineInputBorder(),


                  border: OutlineInputBorder(
                    //borderSide:BorderSide.strokeAlignInside, ,
                    borderRadius: BorderRadius.circular(15),

                  )
              ),
            ),
          ),
          ElevatedButton(onPressed: ()async{
            var check = await dbHelper.authenticateUser(emailcontroller.text.toString(), paswrdcontroller.text.toString());
            if (check){
              var pref= await SharedPreferences.getInstance();
             var get= pref.getInt("UID");

             print(get);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>nav_page()));
            } else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("user not found, "), action: SnackBarAction(label: "create account", onPressed:(){Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>signin()));}),));
            }



          },
              child: Text("log  in")),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=>signin()));
          }, child:Text("didn't have accout, create one"))
        ],
      ),
    );

  }
}







