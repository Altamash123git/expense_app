import 'package:expense/Database.dart';
import 'package:expense/block_helper/block_event.dart';
import 'package:expense/block_helper/block_execute.dart';
import 'package:expense/block_helper/block_state.dart';
import 'package:expense/model/expensemodel.dart';
import 'package:expense/screens/signIn_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/each_date_expense.dart';
import 'home_page.dart';


class static_page extends StatefulWidget {
  @override
  State<static_page> createState() => _StaticDetailsState();
}

class _StaticDetailsState extends State<static_page> {

  DbHelper dbHelper= DbHelper.getInstance();
  List<FilterExpenseModel> mFilterData = [];
  final List<Map<String, dynamic>> Carddata = [
    {
      'name': 'Shop',
      'price': '-\$1190',
      'icon': Icon(
        Icons.shopping_basket,
        color: const Color(0xFF7783D6),
      ),
      'containerclr': const Color(0xFFCED6FF), // Store Color directly
    },
    {
      'name': 'Transportation',
      'price': '-\$890',
      'icon': Icon(
        Icons.car_rental_rounded,
        color: const Color(0xFFE89E9D),
      ),
      'containerclr': const Color(0xFFFAE6E7),
    },
    {
      'name': 'Transportation',
      'price': '-\$890',
      'icon': Icon(
        Icons.car_rental_rounded,
        color: const Color(0xFFE89E9D),
      ),
      'containerclr': const Color(0xFFFAE6E7),
    },
  ];
  List<DateFormat> mformat = [
    DateFormat("d MMM"),
    DateFormat.yMMM(),
    DateFormat.y()
  ];
  String initialSelectedmenu = "This Week";
  int initialSelected = 0;
  List<String> filtermenu = [
    "This Week",
    "This Month",
    "This Year",

  ];
@override
void initState(){
  super.initState();
  context.read<expensebloc>().add(getExpenseEvt());
  setState(() {

  });
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Statistic',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD7DDFF),
                            borderRadius: BorderRadius.circular(6)),
                       child:

                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'This Month',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: double.infinity,
                    height: 130,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6574D3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total expense',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 120,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF8490DC),
                                      borderRadius: BorderRadius.circular(25),
                                      // shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: '\$3734',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' / \$4000 per month',
                                            style: TextStyle(
                                                color: const Color(0xFFAAB1E5),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 300,
                                    // width: double.infinity,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color:
                                      Color(0xFF5867Bc),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  Positioned(
                                    child: Container(
                                      width: 240,
                                      // width: double.infinity,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEBC68F),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Expense Breakdown',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),

                      DropdownMenu(


                          inputDecorationTheme: InputDecorationTheme(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 1))),
                          initialSelection: filtermenu[0],

                          //initialSelectedmenu,
                          width: 120,
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
                              .toList()),
                    ],
                  ),
                ),SizedBox(height: 10,),
                Container(
                  //padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 350,child: BlocBuilder<expensebloc,expensestate>(builder: (c,state){
                    if(state is loading_state){
                      return CircularProgressIndicator();

                    }
                    if(state is loaded_state){
                      FilterExpenseDteWise(state.mdata);
                      var alldata= state.mdata;

                      if(state.mdata.isNotEmpty){
                        List<BarChartGroupData> mbars=[];

                    /*
                       for(int i=0;i<state.mdata.length;i ++){
                          mbars.add(BarChartGroupData(x: i,barRods: [BarChartRodData(toY: alldata[i].totalAmt.toDouble())]));
                        }*/

                        for(int i = 0; i<mFilterData.length; i++){
                          mbars.add(BarChartGroupData(x: i, barRods: [
                            BarChartRodData(toY:mFilterData[i].totalAmt.toDouble(),width: 20,borderRadius: BorderRadius.circular(5)),
                          ]) );
                        }
                        return BarChart(BarChartData(
                         barTouchData: BarTouchData(
                           touchTooltipData: BarTouchTooltipData(
                             getTooltipColor: (_)=>Colors.blueGrey,
                             tooltipMargin: -10,
                             getTooltipItem: (group, grpIdx,rod, rodIdx){
                               String toolTipName=
                                   //mFilterData[group.x].mexpense[rodIdx].expense_title;
                                   mFilterData[group.x].title;
                               return BarTooltipItem(toolTipName, TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 18,
                               ),);

                             }

                           )
                         ),
                            titlesData: FlTitlesData(

                              show: true,

                              rightTitles:  AxisTitles(
                                sideTitles: SideTitles(showTitles:false),
                              ),
                              topTitles:  AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles:  AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta){
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      space: 16,
                                      child: //Text(value.toString()),
                                      Text(
                                        (mFilterData[value.toInt()].title
                                            .toString())
                                      ),

                                    );

                                  },
                                  reservedSize: 35,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                 //maxIncluded: true,
                                  //minIncluded: true,

                                  showTitles: true,

                                  getTitlesWidget: (value, meta){
                                    return SideTitleWidget(

                                      axisSide: meta.axisSide,
                                      space: 1,

                                      child: Text(value.toString(),style: TextStyle(fontSize: 12),)

                                      //Text(alldata[value.toInt()].expene_type.toString()),

                                    );

                                  },

                                  reservedSize: 40,

                        ),


                        ),
                            ),
                          //borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                          barGroups: mbars,
                        ) );
                      /*  return BarChart(
                          BarChartData(
                            barTouchData: BarTouchTooltipData(
                              getTooltipColor:
                            )
                          )
                        );*/
                      }else{
                        return Center(
                          child: Text("no expense yet"),
                        );
                      }
                    }
                    return Container();

                }),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Spending Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Your expenses are devided into 6 categories',
                            style: TextStyle(
                                fontSize: 14, color: const Color(0xFF9396A9)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 318,
                                // width: double.infinity,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF65DA94),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 280,
                                  // width: double.infinity,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDA6565),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 260,
                                  // width: double.infinity,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF66C2DB),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 200,
                                  // width: double.infinity,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEBC68F),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 160,
                                  // width: double.infinity,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE78BBC),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 80,
                                  // width: double.infinity,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6574D2),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: SizedBox(
                    height: 400, // Provide a fixed height
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Carddata.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                              Border.all(color: const Color(0xFFB9D1FF)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Carddata[index]['containerclr'],
                                    ),
                                    child: Carddata[index]['icon'],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Carddata[index]['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          Carddata[index]['price'],
                                          style: TextStyle(
                                              color: const Color(0xFFF0A7D2),
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 11,
                        crossAxisSpacing: 11,
                        childAspectRatio: 3 / 2,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
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
            totalAmt += eachexp.expense_amt;
          } else {
            totalAmt -= eachexp.expense_amt;
          }
        }
        //print(" this is ${uniqueDates.length}");
      }

      mFilterData.add(FilterExpenseModel(
          title: eachdate, totalAmt: totalAmt.round(), mexpense: eachDayExp));

    }
  }
}