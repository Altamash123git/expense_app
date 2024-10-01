import 'package:expense/model/expensemodel.dart';

class  FilterExpenseModel{
  String title;
  num totalAmt;
  List<expenseModel> mexpense;

  FilterExpenseModel({required this.title,required this.totalAmt, required this.mexpense});
}