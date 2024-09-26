import 'package:expense/Database.dart';
import 'package:expense/model/expensemodel.dart';
import 'package:expense/model/usermodel.dart';
import 'package:expense/screens/signIn_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homepage extends StatefulWidget {
  static const String login_key=" is_loggedin";

  @override
  State<homepage> createState() => _homepageState();

}

class _homepageState extends State<homepage> {

  DbHelper dbHelper = DbHelper.getInstance();
  List<expenseModel> _notes = [];

  String? selectedValue;
  int? totalexpense;
  @override
  void initState(){
    super.initState();

  }
  void getexpense()async{
  final  data= await dbHelper.getexpense();
  setState(() {
    _notes= data;
  });


  }

  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       leading: CircleAvatar(),
       title: Text("Morning"),
       actions: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: DropdownButton(
             //alignment: Alignment.bottomCenter,
             elevation: 5,

             value: selectedValue,
           hint: Text("select duration"),
               items: <String>['this month','this week'].map<DropdownMenuItem<String>>((String value){
             return DropdownMenuItem<String>(

               value:  value,
               child: Text(value),
             );
           }).toList(), onChanged:(String? newvalue){
                 setState(() {
                   selectedValue=newvalue;

                 });

           } ),
         )
       ],

     ),
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,       children: [
           Expanded(
               flex: 10,
               child: Container(

                 padding: EdgeInsets.all(10),
                 margin: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                     color: Color(0xff6573D3),
                   border: Border.all(
                     width: 0.5,

                   ),
                   borderRadius: BorderRadius.circular(10)
                 ),
                 width: double.infinity,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text('Expense total'),
                 Text(totalexpense !=0 ? totalexpense.toString() : "null" ,style: TextStyle(fontSize: 23),)
               ],
             ),
           )),
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: Text("Expense List",style:  TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.w500,

             ),),
           ),
         Expanded(
           flex: 15,
           child: Container(
             padding: EdgeInsets.all(10),
             margin: EdgeInsets.all(10),
             decoration: BoxDecoration(
               border: Border.all(
                 width: 1,

               ),
               borderRadius: BorderRadius.circular(10)
             ),
             child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                   children: [
                     Text("Tuesday,14",style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.w400
                     ),),
                     Text("-1380",style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w400
                     ),),


                   ],
                 ),
                 Divider(

                   endIndent: 6,
                 )
               ],
             ),

           ),
         ),
         Expanded(
           flex: 5,
           child: Container(
child: ListView.builder(
    itemCount: _notes.length,

    itemBuilder: (c,i){
      var currdata= _notes[i];
  return ListTile(
    title:  Text(currdata.expense_amt.toString()),
  );
}),
           ),
         )


         ],
       ),
     ),
     bottomNavigationBar: BottomAppBar(
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           IconButton(onPressed: (){}, icon: Icon(Icons.home)),
           IconButton(onPressed: (){}, icon: Icon(Icons.graphic_eq)),
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
     floatingActionButton: FloatingActionButton(onPressed: (  )async{

       //dbHelper.addexpense(expenseModel(userId:, expenseId:DbHelper.Column_expense_id , expense_amt: expense_amt, expense_date: expense_date))
   },child:  Text("add"),),
   );
  }

}
