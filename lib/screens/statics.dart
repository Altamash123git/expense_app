import 'package:expense/Database.dart';
import 'package:expense/model/expensemodel.dart';
import 'package:expense/screens/signIn_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

/*class static_page extends StatelessWidget {
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

    );
  }
}*/
class static_page extends StatefulWidget {
  @override
  State<static_page> createState() => _StaticDetailsState();
}

class _StaticDetailsState extends State<static_page> {
  DbHelper dbHelper= DbHelper.getInstance();
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
                        child: Row(
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
                      Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD7DDFF),
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Week',
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
}