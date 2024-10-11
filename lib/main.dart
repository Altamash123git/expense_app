import 'package:expense/Database.dart';
import 'package:expense/block_helper/block_execute.dart';
import 'package:expense/screens/home_page.dart';
import 'package:expense/screens/splash.dart';
import 'package:expense/screens/theme_manager_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {

  runApp(
    MultiBlocProvider(providers: [
      ChangeNotifierProvider(create: (_)=>Theme_manager()),
        BlocProvider(

        create:(_) =>  expensebloc(dbHelper: DbHelper.getInstance()),)

  ], child:MyApp())


  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: context.watch<Theme_manager>().getThemevalue()?ThemeMode.dark:ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: splash_screen()
    );
  }
}
