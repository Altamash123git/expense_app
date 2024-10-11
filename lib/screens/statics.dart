import 'package:expense/Database.dart';
import 'package:expense/block_helper/block_event.dart';
import 'package:expense/block_helper/block_execute.dart';
import 'dart:math';
import 'package:expense/block_helper/block_state.dart';
import 'package:expense/model/expensemodel.dart';
import 'package:expense/screens/signIn_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../model/each_date_expense.dart';

class static_page extends StatefulWidget {
  @override
  State<static_page> createState() => _StaticDetailsState();
}

class _StaticDetailsState extends State<static_page> {
  DbHelper dbHelper = DbHelper.getInstance();
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
  void initState() {
    super.initState();
    context.read<expensebloc>().add(getExpenseEvt());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery= MediaQuery.of(context);
    bool isLandscape= MediaQuery.of(context).orientation==Orientation.landscape;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness==Brightness.light?Color(0xFFF6F6F6):Colors.black,
        body: SingleChildScrollView(
            child: isLandscape ?Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        beforeGraph(),
                        afeterGraph(),
                      ],
                    
                    ),
                  ),
                  //SizedBox(width: 10,),
                  Expanded(
                      flex: 3,
                      child: graphPart())
                ],

              ),
            ):Column(
              children: [
                beforeGraph(),
                graphPart(),
                afeterGraph(),

              ],

            )
        ),
      ),
    );
  }

  Widget graphPart(){
    return LayoutBuilder(
      builder: (context,constraints) {
        return Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
              child: Container(
                width: constraints.maxWidth ,
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Expense Breakdown',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width:constraints.maxWidth*0.22 ,
                      ),
                      DropdownMenu(
                          inputDecorationTheme: InputDecorationTheme(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 1))),
                          initialSelection: filtermenu[0],

                          //initialSelectedmenu,
                          //width: 120,
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
                              .map((element) => DropdownMenuEntry(
                              value: element, label: element))
                              .toList()),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              //color: Colors.blue,
              //padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 350,
              child: BlocBuilder<expensebloc, expensestate>(
                  builder: (c, state) {
                    if (state is loading_state) {
                      return CircularProgressIndicator();
                    }
                    if (state is loaded_state) {
                      FilterExpenseDteWise(state.mdata);
                      //var alldata= state.mdata;

                      if (state.mdata.isNotEmpty) {
                        List<BarChartGroupData> mbars = [];
                        List<PieChartSectionData> msection = [];

                        /*
                           for(int i=0;i<state.mdata.length;i ++){
                              mbars.add(BarChartGroupData(x: i,barRods: [BarChartRodData(toY: alldata[i].totalAmt.toDouble())]));
                            }*/

                        for (int i = 0; i < mFilterData.length; i++) {
                          mbars.add(BarChartGroupData(x: i, barRods: [
                            BarChartRodData(
                                toY: mFilterData[i].totalAmt.toDouble(),
                                width: 30,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                          ]));
                          msection.add(PieChartSectionData(
                              value: mFilterData[i].totalAmt.toDouble(),
                              title: mFilterData[i].title,
                              color: _getRandomColor(),
                              //showTitle: true,

                              radius: 100));
                        }

                        return  BarChart(BarChartData(
                          barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                  getTooltipColor: (_) => Colors.blueGrey,
                                  tooltipMargin: -10,
                                  getTooltipItem: (group, grpIdx, rod, rodIdx) {
                                    String toolTipName =
                                    //mFilterData[group.x].mexpense[rodIdx].expense_title;
                                    mFilterData[group.x].title;
                                    return BarTooltipItem(
                                      toolTipName,
                                      TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    );
                                  })),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    space: 16,
                                    child: //Text(value.toString()),
                                    Text((mFilterData[value.toInt()]
                                        .title
                                        .toString())),
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

                                getTitlesWidget: (value, meta) {
                                  return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      space: 1,
                                      child: Text(
                                        value.toString(),
                                        style: TextStyle(fontSize: 12),
                                      )

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
                        ));
                        /*  PieChart(PieChartData(
                              centerSpaceRadius: 50,

                              sectionsSpace: 10,
                              sections:msection
                            ));*/


                      } else {
                        return Center(
                          child: Text("no expense yet"),
                        );
                      }
                    }
                    return Container();
                  }),
            ),

          ],
        );
      }
    );
  }
  Widget beforeGraph(){
    return
      LayoutBuilder(
      builder: (context,constraints) {
        return 
          Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
              child:
              Container(
                width: constraints.maxWidth,
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  
                      Text(
                        'Statistic' ,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: constraints.maxWidth*0.22,
                      ),
                      Container(


                        decoration: BoxDecoration(
                            color: const Color(0xFFD7DDFF),
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              'This Month',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
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
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: constraints.maxWidth*0.35,
                width: constraints.maxWidth,
                alignment: Alignment.topLeft,


                //height: 130,
                decoration: BoxDecoration(
                  color: const Color(0xFF6574D3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 11),
                  child:
                  FittedBox(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: constraints.maxWidth*0.3,
                          child: FittedBox(
                            child: Text(
                              'Total expense',
                              style: TextStyle(
                                  fontSize:20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        Container(
                          width: constraints.maxWidth*0.7,
                          padding: EdgeInsets.all(11),
                          child: FittedBox(
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              //mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: constraints.maxWidth*0.8,
                          height: constraints.maxWidth*0.03,

                          child: FittedBox(
                            //fit: BoxFit.fill ,

                            child: Stack(
                              children: [
                                Container(
                                  width: 300,
                                  // width: double.infinity,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF5867Bc),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
                  );
      }
    );
  }
  Widget afeterGraph(){
    return  LayoutBuilder(
      builder: (context,constraints) {
        return Column(
          children: [  Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
            child: Container(
              width: constraints.maxWidth,
              child: FittedBox(
                child:
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
                              color:  Color(0xFF66C2DB),
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
                              color:  Color(0xFFEBC68F),
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
                              color:  Color(0xFF6574D2),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Carddata.length,
                itemBuilder: (context, index) {
                  return FittedBox(
                    //fit: BoxFit.,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                          Border.all(color: const Color(0xFFB9D1FF)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Row(
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
                              Column(
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
                            ],
                          ),
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
            ),],
        );
      }
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
  Color _getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

}
