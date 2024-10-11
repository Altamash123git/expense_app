import 'package:expense/block_helper/block_event.dart';
import 'package:expense/block_helper/block_execute.dart';
import 'package:expense/block_helper/block_state.dart';
import 'package:expense/model/category_model.dart';
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
  State<homepage> createState() => homepageState();
}

class homepageState extends State<homepage> {
  List<FilterExpenseModel> mFilterData = [];

  // List<CategoryWiseModel> CatWise=[];
  bool isCategoryWise = false;

  DateFormat dtFormat = DateFormat.yMMMEd();
  DateFormat monthFormat = DateFormat.yMMM();
  DateFormat yearFormat = DateFormat.y();
  List<DateFormat> mformat = [
    DateFormat.yMMMEd(),
    DateFormat.yMMM(),
    DateFormat.y()
  ];

  int initialSelected = 0;
  var mediaQuery;
  var landscapeWidth;
  bool isLandscape=false;
  List<String> filtermenu = [
    "This Week",
    "This Month",
    "This Year",
    "Category Wise"
  ];
  //List<String> expenseType=["Debit", "Credit", "Loan", "Lend", "Borrow"];
  String initialSelectedmenu = "This Week";
  @override
  void initState() {
    super.initState();
    context.read<expensebloc>().add(getExpenseEvt());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    context.read<expensebloc>().add(getExpenseEvt());
     mediaQuery = MediaQuery.of(context);
     isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Safe to access size after layout is complete
      final size = mediaQuery.size;
      print("Screen size: ${size.width} x ${size.height}");
    });

    return Scaffold(
        backgroundColor: Theme.of(context).brightness==Brightness.light?Color(0xFFF6F6F6):Colors.black,
      body: SingleChildScrollView(

        child:

        Padding(


          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: isLandscape
              ? Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                flex: 3,
                child: beforeList(),
              ),
              Expanded(
                  flex: 3,
                  child: data()),
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              beforeList(),
              SizedBox(
                height: 10,
              ),

              data()
            ],
          ),
        ),
      )
    );

  }

  Widget beforeList() {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(

            //crossAxisAlignment: CrossAxisAlignment.stretch,


            children: [
              Container(
                width: constraints.maxWidth ,
                child: FittedBox(
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,

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
                      SizedBox(
                        width: constraints.maxWidth*0.18,
                      ),

                      FittedBox(
                        child: DropdownMenu(
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
                                  isCategoryWise = false;
                                } else if (value == filtermenu[1]) {
                                  initialSelected = 1;
                                } else if (value == filtermenu[2]) {
                                  initialSelected = 2;
                                  isCategoryWise = false;
                                } else if (value == filtermenu[3]) {
                                  setState(() {
                                    //CategoryFilter(allExp);
                                    isCategoryWise = true;
                                  });
                                }
                              });
                            },
                            dropdownMenuEntries: filtermenu
                                .map((element) =>
                                DropdownMenuEntry(value: element, label: element))
                                .toList()),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: constraints.maxWidth,

                decoration: BoxDecoration(
                  color: const Color(0xFF6574D3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FittedBox(
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child:
                          Column(
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
                                        style:
                                            TextStyle(fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      'than last month',
                                      style: TextStyle(color: Colors.white, fontSize: 16),
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

                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget data() {
    return
      Container(
        height: 500,
        child: LayoutBuilder(
          builder: (context,constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight*2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Expense List',
                      style: TextStyle(
                        fontSize: constraints.maxWidth*0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: BlocBuilder<expensebloc, expensestate>(builder: (c, state) {
                    if (state is loading_state) {
                      return Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is loaded_state) {
                      isCategoryWise
                          ? CategoryFilter(state.mdata)
                          : FilterExpenseDteWise(state.mdata);

                      //CategoryFilter(state.mdata);

                      //print(CatWise.length);
                      print(mFilterData.length);
                      //print(expenseType.length);

                      return ListView.builder(
                          itemCount: mFilterData.length,
                          itemBuilder: (c, i) {
                            //print(CatWise[i].title);
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                width: constraints.maxWidth,
                                //height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFFB9D1FF)),
                                ),
                                //width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: constraints.maxWidth,
                                        child: FittedBox(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                mFilterData[i].title,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),SizedBox(width: constraints.maxWidth*0.22,),
                                              Text(
                                                '\u{20B9}${mFilterData[i].totalAmt}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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

                                              leading:
                                                  Container(
                                                    //color: Colors.blue,
                                                    width: constraints.maxWidth*0.13,
                                                      //height: constraints.maxHeight,

                                                      child: FittedBox(
                                                          fit: BoxFit.cover,
                                                          child: Image.asset(filterList[0].Category_img, ))),
                                              trailing: Text(
                                                  "-\u{20B9}${mFilterData[i].mexpense[childIdx].expense_amt}" ,style: TextStyle(fontSize: constraints.maxWidth*0.055),),
                                              title: Text(
                                                  "${mFilterData[i].mexpense[childIdx].expense_title}",style: TextStyle(fontSize: constraints.maxWidth*0.05),),
                                              subtitle: Text(
                                                  "${mFilterData[i].mexpense[childIdx].expense_desc}", style: TextStyle(fontSize: constraints.maxWidth*0.04),),
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
                ],
              ),
            );
          }
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
    print(" unique date ka list :${uniqueDates.length}");
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
        //print(" this is ${uniqueDates.length}");
      }

      mFilterData.add(FilterExpenseModel(
          title: eachdate, totalAmt: totalAmt, mexpense: eachDayExp));
    }
  }

  void CategoryFilter(List<expenseModel> allExp) {
    mFilterData.clear();
    var category = AppConstant.mCat;

    for (catModel eachCat in category) {
      num totalAmt = 0.0;
      List<expenseModel> CatWiseExp = [];
      for (expenseModel eachExp in allExp) {
        if (eachExp.category_id == eachCat.CatId) {
          CatWiseExp.add(eachExp);
          if (eachExp.expene_type == "Debit") {
            totalAmt -= eachExp.expense_amt;
          } else {
            totalAmt += eachExp.expense_amt;
          }
        }
      }
      if (CatWiseExp.isNotEmpty) {
        mFilterData.add(FilterExpenseModel(
            title: eachCat.Category_name,
            totalAmt: totalAmt,
            mexpense: CatWiseExp));
      }
      print(" i am $category");
      // print(AppConstant.mCat.length);
    }
  }
}
