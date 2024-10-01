/*
import 'package:expense/Database.dart';
import 'package:expense/model/expensemodel.dart';
import 'package:expense/model/usermodel.dart';
import 'package:expense/screens/signIn_page.dart';
import 'package:expense/screens/statics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homepage extends StatefulWidget {
  static const String login_key = " is_loggedin";

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<Widget> pages = [homepage(), static_page()];
  int currindx = 0;
  DbHelper dbHelper = DbHelper.getInstance();
  List<expenseModel> _notes = [];

  String? selectedValue;
  int? totalexpense;
  @override
  void initState() {
    super.initState();
    getexpense();
  }

  void getexpense() async {
    _notes = await dbHelper.getexpense();
    setState(() {});
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
                items: <String>['this month', 'this week']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newvalue) {
                  setState(() {
                    selectedValue = newvalue;
                  });
                }),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expense total'),
                      Text(
                        totalexpense != 0 ? totalexpense.toString() : "null",
                        style: TextStyle(fontSize: 23),
                      )
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Expense List",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tuesday,14",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "-1380",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
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
                color: Colors.grey,

              ),
            )
          ],
        ),
      ),
    );
  }
}
*/
import 'package:expense/block_helper/block_event.dart';
import 'package:expense/block_helper/block_execute.dart';
import 'package:expense/block_helper/block_state.dart';
import 'package:expense/model/category_wise_model.dart';
import 'package:expense/model/expensemodel.dart';
import 'package:expense/screens/app_constants.dart';
import 'package:expense/screens/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/each_date_expense.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<FilterExpenseModel> mFilterData = [];
  List<CategoryWiseModel> CatWise=[];

  DateFormat dtFormat = DateFormat.yMMMEd();
  DateFormat monthFormat = DateFormat.yMMM();
  DateFormat yearFormat = DateFormat.y();
  List<DateFormat> mformat = [
    DateFormat.yMMMEd(),
    DateFormat.yMMM(),
    DateFormat.y()
  ];
  int initialSelected = 0;
  List<String> filtermenu = [
    "This Week",
    "This Month",
    "This Year",
  ];
  //List<String> expenseType=["Debit", "Credit", "Loan", "Lend", "Borrow"];
  String initialSelectedmenu = "This Week";
  @override
  void initState() {
    super.initState();
    context.read<expensebloc>().add(getExpenseEvt());
  }

  @override
  Widget build(BuildContext context) {
    //context.read<expensebloc>().add(getExpenseEvt());
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blueAccent,
                    child: ClipOval(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.network(
                          "https://w7.pngwing.com/pngs/7/618/png-transparent-man-illustration-avatar-icon-fashion-men-avatar-face-fashion-girl-heroes-thumbnail.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Morning'),
                      Text(
                        'Yamamamoto Yukio',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              DropdownMenu(
                  inputDecorationTheme: InputDecorationTheme(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1))),
                  initialSelection: filtermenu[0],
                  //initialSelectedmenu,
                  width: 150,

                  onSelected: (
                    value,
                  ) {
                    initialSelectedmenu = value!;
                    setState(() {
                      //initialSelected=value!;
                      if (value == filtermenu[0]) {
                        initialSelected = 0;
                      } else if (value == filtermenu[1]) {
                        initialSelected = 1;
                      } else if (value == filtermenu[2]) {
                        initialSelected = 2;
                      }
                    });
                  },
                  dropdownMenuEntries: filtermenu
                      .map((element) =>
                          DropdownMenuEntry(value: element, label: element))
                      .toList())
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF6574D3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expense Total',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '\$3734',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 20,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.red),
                                child: Center(
                                  child: Text(
                                    '\+\$240',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Center(
                                child: Text(
                                  'than last month',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/icons/ic_dashboardicon.png',
                      width: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
            child: Text(
              'Expense List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: BlocBuilder<expensebloc, expensestate>(builder: (c, state) {
              if (state is loading_state) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
              if (state is loaded_state) {
                FilterExpenseDteWise(state.mdata);
                CategoryFilter(state.mdata);
                print(filtermenu[0]);
                print(mformat.length);
                //print(expenseType.length);

                return ListView.builder(
                    itemCount: mFilterData.length,
                    itemBuilder: (c, i) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          //height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFB9D1FF)),
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mFilterData[i].title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\u{20B9}${mFilterData[i].totalAmt}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Divider(
                                    color: const Color(0xFFB9D1FF),
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: mFilterData[i].mexpense.length,
                                    itemBuilder: (c, childIdx) {
                                      var filterList = AppConstant.mCat
                                          .where((element) =>
                                              element.CatId ==
                                              mFilterData[i]
                                                  .mexpense[childIdx]
                                                  .category_id)
                                          .toList();
                                      return ListTile(
                                        leading: Image.asset(
                                            filterList[0].Category_img),
                                        trailing: Text(
                                            "-\u{20B9}${mFilterData[i].mexpense[childIdx].expense_amt}"),
                                        title: Text(
                                            "${mFilterData[i].mexpense[childIdx].expense_title}"),
                                        subtitle: Text(
                                            "${mFilterData[i].mexpense[childIdx].expense_desc}"),
                                      );
                                    }),
                               
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              return Container(
                child: Text("im here "),
              );
            }),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void FilterExpenseDteWise(List<expenseModel> allExp) {
    mFilterData.clear();
    List<String> uniqueDates = [];
    for (expenseModel eachexp in allExp) {
      String FormatedDate = mformat[initialSelected].format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(eachexp.expense_date)));
      //print(" it is $FormatedDate");
      if (!uniqueDates.contains(FormatedDate)) {
        uniqueDates.add(FormatedDate);
      }
    }
   // print(" unique date ka list :$uniqueDates");
    for (String eachdate in uniqueDates) {
      List<expenseModel> eachDayExp = [];
      num totalAmt = 0.0;

      for (expenseModel eachexp in allExp) {
        String eachExpDate = mformat[initialSelected].format(
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(eachexp.expense_date)));
        if (eachExpDate == eachdate) {
          eachDayExp.add(eachexp);
          if (eachexp.expene_type == "Debit") {
            totalAmt -= eachexp.expense_amt;
          } else {
            totalAmt += eachexp.expense_amt;
          }
        }
      }

      mFilterData.add(FilterExpenseModel(
          title: eachdate, totalAmt: totalAmt, mexpense: eachDayExp));
    }
  }
  void CategoryFilter(List<expenseModel> allExp){
    List catidList=[];
    for(expenseModel eachexp in allExp){
      int category= eachexp.category_id;
      if(!catidList.contains(category)){
        catidList.add(category);

      }
      for(int eachcatid in catidList ){
        List<expenseModel> CatWiseExp = [];
        num totalAmt = 0.0;
        for(expenseModel eachexp in allExp){
          int catid= eachexp.category_id;
          if(catid==eachcatid){
            CatWiseExp.add(eachexp);
            if (eachexp.expene_type == "Debit") {
              totalAmt -= eachexp.expense_amt;
            } else {
              totalAmt += eachexp.expense_amt;
            }
          }
          //print(eachexp);
        }
      CatWise.add(CategoryWiseModel(title: eachexp.expense_title, amt:totalAmt, mnewExpense:CatWiseExp));
       // mFilterData.add(CategoryWiseModel(title: title, amt: amt, mnewExpense: mnewExpense)
            //FilterExpenseModel(title: eachexp.expense_title, totalAmt: totalAmt, mexpense:CatWiseExp));
        //CatWise.add(FilterExpenseModel(title: eachexp.expense_title, totalAmt: totalAmt, mexpense:CatWiseExp));

      }
      print(catidList);

    }

  }
}
