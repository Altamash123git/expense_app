import 'package:expense/main.dart';
import 'package:expense/screens/theme_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text('i am text'),

),
      body: SafeArea(child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Dark Mode'),
                  Text("Change theme mode here"),

                ],
              ),
              Switch.adaptive(value: context.watch<Theme_manager>().getThemevalue(), onChanged: (value)async{

                context.read<Theme_manager>().changeTheme(value);

              })
            ],
          )
        ],
      )),
    );
  }
}
