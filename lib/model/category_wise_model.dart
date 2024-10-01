import 'package:expense/model/expensemodel.dart';

class CategoryWiseModel{
  String title;
  num amt;
  List<expenseModel> mnewExpense;
  CategoryWiseModel({required this.title,required this.amt, required this.mnewExpense});
}