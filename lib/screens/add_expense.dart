import 'package:expense/block_helper/block_event.dart';
import 'package:expense/block_helper/block_execute.dart';
import 'package:expense/block_helper/block_state.dart';
import 'package:expense/main.dart';
import 'package:expense/model/expensemodel.dart';
import 'package:expense/screens/app_constants.dart';
import 'package:expense/screens/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class add_expense extends StatefulWidget {
  const add_expense({super.key});

  @override
  State<add_expense> createState() => _add_expenseState();
}

class _add_expenseState extends State<add_expense> {
  int selectedIndex=-1;
  List<expenseModel> data=[];
  DateTime? selectedDate;
  List<String> expenseType=["Debit", "Credit", "Loan", "Lend", "Borrow"];
  String selectedExpenseType="Debit";
  DateFormat mdtformt=DateFormat.yMMMEd();
  TextEditingController titlecontroller=TextEditingController();
  TextEditingController desccontroller=TextEditingController();
  TextEditingController amtcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<expensebloc>().add(getExpenseEvt());
    if(selectedIndex>=0){
      titlecontroller.text= AppConstant.mCat[selectedIndex].Category_name;
    }
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [
              TextField(
                controller: titlecontroller,
                decoration: mTextfilDecor(hint: "enter your expense title", label: "title"),
        
              ),
              mspacer(),
              TextField(
                controller: desccontroller,
                decoration: mTextfilDecor(hint: "enter your expense desc", label: "desc"),
        
              ),
              mspacer(),
              TextField(
                controller: amtcontroller,
                decoration: mTextfilDecor(hint: "enter your expense amt", label: "amount"),
        
              ),
              mspacer(),
              OutlinedButton(
        
                style: OutlinedButton.styleFrom(
                  maximumSize: Size(double.infinity, 60),
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
        
                  )
                ),
        
                  onPressed: (){
                  showModalBottomSheet(context: context, builder: (c){
                    return Container(
                      padding: EdgeInsets.all(11),
                      child: GridView.builder(
                          itemCount:   AppConstant.mCat.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder:(c,index){
        
                        return InkWell(
                          onTap: (){
                            selectedIndex=index;
                            setState(() {
        
                            });
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                            Image.asset(AppConstant.mCat[index].Category_img,width: 50,height: 50,),
                              Text(AppConstant.mCat[index].Category_name)
                            ],
                          ),
                        );
                      }),
                    );
                  });
                  }, child: selectedIndex>=0? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppConstant.mCat[selectedIndex].Category_img,width: 50,height: 50,),
                  mspacer(),
                  Text(AppConstant.mCat[selectedIndex].Category_name),
                ],
              ):Text("Choose your Category")),
              mspacer(),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(onPressed: ()async{
                  selectedDate= await showDatePicker(context: context, firstDate:DateTime.now().subtract(Duration(days: 721)), lastDate:DateTime.now());
                  setState(() {

                  });
                }, child: Text(mdtformt.format((selectedDate?? DateTime.now())))),
              ),

              DropdownMenu(
                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                      width: 1
                    )
                  )
                ),
                initialSelection: selectedExpenseType,
                width: MediaQuery.of(context).size.width-22,
                label: Text("Type"),
                  onSelected: (value){
                    selectedExpenseType=value!;
                  },
                  dropdownMenuEntries: expenseType.map((element)=>DropdownMenuEntry(value: element, label: element)).toList()),
              mspacer(),
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1),
                          minimumSize: Size(double.infinity, 60),
                          maximumSize: Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21))),
                      onPressed: () async {
                        if(selectedIndex>=0&& titlecontroller.text.isNotEmpty && desccontroller.text.isNotEmpty && amtcontroller.text.isNotEmpty){
                          final expenses= expenseModel(expense_amt:double.parse(amtcontroller.text.toString()), expense_date: (selectedDate?? DateTime.now()).millisecondsSinceEpoch.toString(), expene_type: selectedExpenseType, expense_desc: desccontroller.text, expense_title: titlecontroller.text,expense_balance:0,category_id: AppConstant.mCat[selectedIndex].CatId );
                          context.read<expensebloc>().add(addexpenseEvt(expense: expenses));
                          print(expenses);
                          print({
                            (selectedDate ?? DateTime.now())
                                .millisecondsSinceEpoch
                                .toString()
                          });
                        }

                        //Navigator.pop(context);
                      },


                      child: Text("Add Expense"))),

        
            ],
        
          ),
        ),
      ),
    );
  }
}
