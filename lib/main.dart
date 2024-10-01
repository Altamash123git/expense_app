import 'package:expense/Database.dart';
import 'package:expense/block_helper/block_execute.dart';
import 'package:expense/screens/home_page.dart';
import 'package:expense/screens/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


void main() {

  runApp(

      BlocProvider(
          create:(_) =>  expensebloc(dbHelper: DbHelper.getInstance()),
          child:
          const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: splash_screen()
    );
  }
}
