import 'package:expense/Database.dart';
import 'package:expense/screens/login_page.dart';
import 'package:expense/screens/signIn_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../model/usermodel.dart';
import 'home_page.dart';

class signin extends StatefulWidget {
  @override
  State<signin> createState() => _loginpageState();
}

class _loginpageState extends State<signin> {
  DbHelper dbHelper = DbHelper.getInstance();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController paswrdcontroller = TextEditingController();
  bool ischecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor: Color(0xfff6f6f6),
        title: Text("Welcome"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xfff6f6f6),
          margin: EdgeInsets.all(40),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Create Account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  Icon(
                    Icons.waving_hand_rounded,
                    size: 35,
                    color: Colors.yellowAccent,
                  ),
                ],
              ),
              Text(
                  "Please register on our streamline, where you can\nconntinue uising our service"),
              SizedBox(
                height: 20,
              ),
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
                      )),
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
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
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
                      )),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Checkbox(
                    value: ischecked,
                    onChanged: _togglecheckbox,
                  ),
                  Text(
                    "i have read term and policy",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffE86A53),
                      //maximumSize: Size(500, 30),
                      minimumSize: Size(300, 40)),
                  onPressed: () async {
                    var check = await dbHelper.addnewuser(userModal(
                        uemail: emailcontroller.text,
                        uid: 0,
                        uname: namecontroller.text,
                        upass: paswrdcontroller.text));
                    if (check) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('account created succesfully')));
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (c) => login_page()));
                    } else {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>loginpage()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("already account created,  "),
                        action: SnackBarAction(
                            label: "log in",
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => login_page()));
                            }),
                      ));
                    }
                  },
                  child: Text(
                    "signin",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
              SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      //color: Colors.blue,
                      height: 2,
                      //thickness: 10,
                      indent: 2,
                      endIndent: 4,
                    ),
                  ),
                  Text("or"),
                  Expanded(
                    child: Divider(
                      height: 2,
                      indent: 2,
                      endIndent: 4,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(
                                "https://static-00.iconduck.com/assets.00/google-icon-2048x2048-pks9lbdv.png",
                              ),
                              fit: BoxFit.contain)),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(Icons.apple)),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.facebook,
                          color: Colors.blue,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (c) => login_page()));
                      },
                      child: Text(
                        "login  instead",
                        style: TextStyle(color: Color(0xffE86A53)),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _togglecheckbox(bool? value) {
    setState(() {
      value:
      ischecked = value ?? false;
    });
  }
}
