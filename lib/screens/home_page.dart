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
   bool isCategoryWise= false;

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
    "Category Wise"
  ];
  //List<String> expenseType=["Debit", "Credit", "Loan", "Lend", "Borrow"];
  String initialSelectedmenu = "This Week";
  @override
  void initState() {
    super.initState();
    context.read<expensebloc>().add(getExpenseEvt());
    setState(() {

    });
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
                        isCategoryWise= false;
                      } else if (value == filtermenu[1]) {

                        initialSelected = 1;
                      } else if (value == filtermenu[2]) {

                        initialSelected = 2;
                        isCategoryWise= false;
                      } else if (value == filtermenu[3]) {
                        setState(() {
                          //CategoryFilter(allExp);
                          isCategoryWise=true;
                        });
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
                isCategoryWise? CategoryFilter(state.mdata): FilterExpenseDteWise(state.mdata);


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
                            //height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                              Border.all(color: const Color(0xFFB9D1FF)),
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                              "-\u{20B9}${mFilterData[i]
                                                  .mexpense[childIdx]
                                                  .expense_amt}"),
                                          title: Text(
                                              "${mFilterData[i]
                                                  .mexpense[childIdx]
                                                  .expense_title}"),
                                          subtitle: Text(
                                              "${mFilterData[i]
                                                  .mexpense[childIdx]
                                                  .expense_desc}"),
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
      if(CatWiseExp.isNotEmpty) {
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
// import 'package:expenseapplication/bloc_helper/expense_bloc.dart';
// import 'package:expenseapplication/bloc_helper/expense_event.dart';
// import 'package:expenseapplication/bloc_helper/expense_state.dart';
// import 'package:expenseapplication/domain/app_constants.dart';
// import 'package:expenseapplication/models/expensemodel.dart';
// import 'package:expenseapplication/models/filter_expense_model.dart';
// import 'package:expenseapplication/ui/loginpage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class NavDashboard extends StatefulWidget {
//   @override
//   State<NavDashboard> createState() => _NavDashboardState();
// }

// class _NavDashboardState extends State<NavDashboard> {
//   List<FilterExpenseModel> mFilterData = [];
//   DateFormat dtFormat = DateFormat.yMMMEd();
//   DateFormat monthFormat = DateFormat.MMMEd();
//   DateFormat yearFormat = DateFormat.y();
//   String selectedFilter = "This Month";

//   @override
//   void initState() {
//     super.initState();
//     context.read<ExpenseBloc>().add(GetInitialExpensesEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.logout),
//                 onPressed: () async {
//                   // Get SharedPreferences instance
//                   var prefs = await SharedPreferences.getInstance();

//                   // Clear the saved user ID (UUID) to log out the user
//                   prefs.remove("UID");

//                   // Navigate to LoginPage
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginPage()),
//                   );
//                 },
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 25,
//                     backgroundColor: Colors.blueAccent,
//                     child: ClipOval(
//                       child: SizedBox(
//                         width: 40,
//                         height: 40,
//                         child: Image.asset(
//                           'assets/icons/ic_profileicon.png',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 8,
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Morning'),
//                       Text(
//                         'Yamamamoto Yukio',
//                         style: TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               // Container(
//               //   height: 40,
//               //   width: 120,
//               //   decoration: BoxDecoration(
//               //       color: const Color(0xFFD7DDFF),
//               //       borderRadius: BorderRadius.circular(6)),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.center,
//               //     children: [
//               //       Text(
//               //         'This Month',
//               //         style:
//               //             TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
//               //       ),
//               //       SizedBox(
//               //         width: 5,
//               //       ),
//               //       Icon(Icons.arrow_drop_down),
//               //     ],
//               //   ),
//               // ),

//               DropdownButton<String>(
//                 value: selectedFilter,
//                 items: [
//                   DropdownMenuItem(
//                       value: 'This Year', child: Text('This Year')),
//                   DropdownMenuItem(
//                       value: 'This Month', child: Text('This Month')),
//                   DropdownMenuItem(
//                       value: 'This Week', child: Text('This Week')),
//                   DropdownMenuItem(
//                       value: 'By Category', child: Text('By Category')),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     selectedFilter = value!;
//                     _applyFilter();
//                   });
//                 },
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Container(
//               width: double.infinity,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF6574D3),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15.0),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Expense Total',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             '\$3734',
//                             style: TextStyle(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 height: 20,
//                                 width: 40,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(3),
//                                     color: Colors.red),
//                                 child: Center(
//                                   child: Text(
//                                     '\+\$240',
//                                     style: TextStyle(
//                                         fontSize: 10, color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Center(
//                                 child: Text(
//                                   'than last month',
//                                   style: TextStyle(color: Colors.white),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: Image.asset(
//                       'assets/icons/ic_dashboardicon.png',
//                       width: 160,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
//             child: Text(
//               'Expense List',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//             ),
//           ),
//           Expanded(child: BlocBuilder<ExpenseBloc, ExpenseState>(
//             builder: (_, state) {
//               if (state is ExpenseLoadedState) {
//                 filterExpensesDateWise(state.mData);

//                 return ListView.builder(
//                     itemCount: mFilterData.length,
//                     itemBuilder: (_, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(6.0),
//                         child: Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: const Color(0xFFB9D1FF)),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 15.0, vertical: 10),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       mFilterData[index].title,
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       '\u{20B9}${mFilterData[index].totalAmt}',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10.0),
//                                   child: Divider(
//                                     color: const Color(0xFFB9D1FF),
//                                     thickness: 1,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 ListView.builder(
//                                     itemCount:
//                                         mFilterData[index].mExpenses.length,
//                                     shrinkWrap: true,
//                                     itemBuilder: (_, childIndex) {
//                                       var filterList = AppConstants.mCat
//                                           .where((element) =>
//                                               element.catId ==
//                                               mFilterData[index]
//                                                   .mExpenses[childIndex]
//                                                   .expense_cat_id)
//                                           .toList();

//                                       return Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 8.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                     height: 40,
//                                                     width: 35,
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               3),
//                                                       color: const Color(
//                                                           0xFFFAE6E7),
//                                                     ),
//                                                     child: Image.asset(
//                                                         filterList[0].catImg)),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                         mFilterData[index]
//                                                             .mExpenses[
//                                                                 childIndex]
//                                                             .expense_title,
//                                                         style: TextStyle(
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         )),
//                                                     Text(
//                                                       mFilterData[index]
//                                                           .mExpenses[childIndex]
//                                                           .expense_desc,
//                                                       style: TextStyle(
//                                                         fontSize: 12,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                             Text(
//                                                 '-\u{20B9}${mFilterData[index].mExpenses[childIndex].expense_amt}',
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: const Color(
//                                                         0xFFF0A7D2))),
//                                             // Display amount here
//                                           ],
//                                         ),
//                                       );
//                                     })
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     });
//               }
//               return Container();
//             },
//           )),
//         ],
//       ),
//     );
//   }

//   void filterExpensesDateWise(List<expenseModel> allExp) {
//     mFilterData.clear();
//     List<String> listUniqueDates = [];

//     for (expenseModel eachExp in allExp) {
//       DateTime eachDate =
//           DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expense_date));
//       String formattedDate = dtFormat.format(eachDate);

//       if (!listUniqueDates.contains(formattedDate)) {
//         listUniqueDates.add(formattedDate);
//       }
//     }

//     print(listUniqueDates);

//     for (String eachDate in listUniqueDates) {
//       num totalAmt = 0.0;
//       List<expenseModel> eachDateExp = [];

//       for (expenseModel eachExp in allExp) {
//         String eachExpDate = dtFormat.format(
//             DateTime.fromMillisecondsSinceEpoch(
//                 int.parse(eachExp.expense_date)));

//         if (eachExpDate == eachDate) {
//           eachDateExp.add(eachExp);

//           if (eachExp.expense_type == "Debit") {
//             totalAmt -= eachExp.expense_amt;
//           } else {
//             totalAmt += eachExp.expense_amt;
//           }
//         }
//       }

//       mFilterData.add(FilterExpenseModel(
//           title: eachDate, totalAmt: totalAmt, mExpenses: eachDateExp));
//     }
//   }
// }

/*
import 'package:expenseapplication/bloc_helper/expense_bloc.dart';
import 'package:expenseapplication/bloc_helper/expense_event.dart';
import 'package:expenseapplication/bloc_helper/expense_state.dart';
import 'package:expenseapplication/domain/app_constants.dart';
import 'package:expenseapplication/models/expensemodel.dart';
import 'package:expenseapplication/models/filter_expense_model.dart';
import 'package:expenseapplication/ui/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDashboard extends StatefulWidget {
  @override
  State<NavDashboard> createState() => _NavDashboardState();
}

class _NavDashboardState extends State<NavDashboard> {
  List<FilterExpenseModel> mFilterData = [];
  DateFormat dtFormat = DateFormat.yMMMEd();
  DateFormat monthFormat = DateFormat.MMMEd();
  DateFormat yearFormat = DateFormat.y();
  String selectedFilter = "This Month";

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(GetInitialExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  // Get SharedPreferences instance
                  var prefs = await SharedPreferences.getInstance();

                  // Clear the saved user ID (UUID) to log out the user
                  prefs.remove("UID");

                  // Navigate to LoginPage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
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
                        child: Image.asset(
                          'assets/icons/ic_profileicon.png',
                          fit: BoxFit.cover,
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
              // Container(
              //   height: 40,
              //   width: 120,
              //   decoration: BoxDecoration(
              //       color: const Color(0xFFD7DDFF),
              //       borderRadius: BorderRadius.circular(6)),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         'This Month',
              //         style:
              //             TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Icon(Icons.arrow_drop_down),
              //     ],
              //   ),
              // ),

              DropdownButton<String>(
                value: selectedFilter,
                items: [
                  DropdownMenuItem(
                      value: 'This Year', child: Text('This Year')),
                  DropdownMenuItem(
                      value: 'This Month', child: Text('This Month')),
                  DropdownMenuItem(
                      value: 'This Week', child: Text('This Week')),
                  DropdownMenuItem(
                      value: 'By Category', child: Text('By Category')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedFilter = value!;
                  });
                },
              ),
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
                                  style: TextStyle(color: Colors.white),
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
          Expanded(child: BlocBuilder<ExpenseBloc, ExpenseState>(
            builder: (_, state) {
              if (state is ExpenseLoadedState) {
                // filterExpensesDateWise(state.mData);
                _applyFilter(state.mData);

                return ListView.builder(
                    itemCount: mFilterData.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFB9D1FF)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mFilterData[index].title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\u{20B9}${mFilterData[index].totalAmt}',
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
                                    itemCount:
                                    mFilterData[index].mExpenses.length,
                                    shrinkWrap: true,
                                    itemBuilder: (_, childIndex) {
                                      var filterList = AppConstants.mCat
                                          .where((element) =>
                                      element.catId ==
                                          mFilterData[index]
                                              .mExpenses[childIndex]
                                              .expense_cat_id)
                                          .toList();

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 40,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          3),
                                                      color: const Color(
                                                          0xFFFAE6E7),
                                                    ),
                                                    child: Image.asset(
                                                        filterList[0].catImg)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        mFilterData[index]
                                                            .mExpenses[
                                                        childIndex]
                                                            .expense_title,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        )),
                                                    Text(
                                                      mFilterData[index]
                                                          .mExpenses[childIndex]
                                                          .expense_desc,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text(
                                                '-\u{20B9}${mFilterData[index].mExpenses[childIndex].expense_amt}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                        0xFFF0A7D2))),
                                            // Display amount here
                                          ],
                                        ),
                                      );
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              return Container();
            },
          )),
        ],
      ),
    );
  }

  // Apply selected filter
  void _applyFilter(List<expenseModel> allExpenses) {
    mFilterData.clear(); // Clear previous filtered data
    if (selectedFilter == 'This Year') {
      _filterByYear(allExpenses); // Filter by year, grouped by month
    } else if (selectedFilter == 'This Month') {
      _filterByMonth(allExpenses); // Filter by month, grouped by day
    } else if (selectedFilter == 'This Week') {
      _filterByWeek(allExpenses); // Filter by week, grouped by day
    } else if (selectedFilter == 'By Category') {
      _filterByCategory(allExpenses); // Filter by category
    }
  }

  // Filter by Year (grouped by month)
  void _filterByYear(List<expenseModel> allExpenses) {
    Map<String, num> monthlyTotals = {}; // Store total by month
    Map<String, List<expenseModel>> monthlyExpenses =
    {}; // Store expenses by month

    for (expenseModel expense in allExpenses) {
      DateTime date =
      DateTime.fromMillisecondsSinceEpoch(int.parse(expense.expense_date));
      String month = monthFormat.format(date); // Get the month (e.g., Jan, Feb)

      if (!monthlyTotals.containsKey(month)) {
        monthlyTotals[month] = 0;
        monthlyExpenses[month] = [];
      }

      monthlyTotals[month] = monthlyTotals[month]! + expense.expense_amt;
      monthlyExpenses[month]!.add(expense);
    }

    // Convert map data to list
    monthlyTotals.forEach((month, totalAmt) {
      mFilterData.add(FilterExpenseModel(
          title: month,
          totalAmt: totalAmt,
          mExpenses: monthlyExpenses[month]!));
    });
  }

  // Filter by Month (grouped by date)
  void _filterByMonth(List<expenseModel> allExpenses) {
    Map<String, num> dailyTotals = {}; // Store total by date
    Map<String, List<expenseModel>> dailyExpenses =
    {}; // Store expenses by date

    for (expenseModel expense in allExpenses) {
      DateTime date =
      DateTime.fromMillisecondsSinceEpoch(int.parse(expense.expense_date));
      String day = dtFormat.format(date); // Get the full date

      if (!dailyTotals.containsKey(day)) {
        dailyTotals[day] = 0;
        dailyExpenses[day] = [];
      }

      dailyTotals[day] = dailyTotals[day]! + expense.expense_amt;
      dailyExpenses[day]!.add(expense);
    }

    // Convert map data to list
    dailyTotals.forEach((day, totalAmt) {
      mFilterData.add(FilterExpenseModel(
          title: day, totalAmt: totalAmt, mExpenses: dailyExpenses[day]!));
    });
  }

  // Filter by Week (grouped by date)
  void _filterByWeek(List<expenseModel> allExpenses) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now
        .subtract(Duration(days: now.weekday - 1)); // Get the start of the week
    DateTime endOfWeek =
    startOfWeek.add(Duration(days: 6)); // Get the end of the week

    Map<String, num> weeklyTotals = {}; // Store total by date
    Map<String, List<expenseModel>> weeklyExpenses =
    {}; // Store expenses by date

    for (expenseModel expense in allExpenses) {
      DateTime date =
      DateTime.fromMillisecondsSinceEpoch(int.parse(expense.expense_date));
      if (date.isAfter(startOfWeek) && date.isBefore(endOfWeek)) {
        String day = dtFormat.format(date); // Get the full date

        if (!weeklyTotals.containsKey(day)) {
          weeklyTotals[day] = 0;
          weeklyExpenses[day] = [];
        }

        weeklyTotals[day] = weeklyTotals[day]! + expense.expense_amt;
        weeklyExpenses[day]!.add(expense);
      }
    }

    // Convert map data to list
    weeklyTotals.forEach((day, totalAmt) {
      mFilterData.add(FilterExpenseModel(
          title: day, totalAmt: totalAmt, mExpenses: weeklyExpenses[day]!));
    });
  }

  // Filter by Category
  void _filterByCategory(List<expenseModel> allExpenses) {
    Map<String, num> categoryTotals = {}; // Store total by category
    Map<String, List<expenseModel>> categoryExpenses =
    {}; // Store expenses by category

    for (expenseModel expense in allExpenses) {
      String category = AppConstants.mCat
          .firstWhere((e) => e.catId == expense.expense_cat_id)
          .catName; // Get category name

      if (!categoryTotals.containsKey(category)) {
        categoryTotals[category] = 0;
        categoryExpenses[category] = [];
      }

      categoryTotals[category] =
          categoryTotals[category]! + expense.expense_amt;
      categoryExpenses[category]!.add(expense);
    }

    // Convert map data to list
    categoryTotals.forEach((category, totalAmt) {
      mFilterData.add(FilterExpenseModel(
          title: category,
          totalAmt: totalAmt,
          mExpenses: categoryExpenses[category]!));
    });
  }
}
*/
