 import 'package:expense/model/expensemodel.dart';

abstract class expeneEvent{}

class addexpenseEvt extends expeneEvent{
   expenseModel expense;
addexpenseEvt({required this.expense});

/*
String title;
  int? uid;
  String desc;
  int amt;
  String type;
  String addedDate;
  addexpenseEvt({required this.title, required this.desc,required this.amt,required this.addedDate, required this.type,
  this.uid});
*/

}
class getExpenseEvt extends expeneEvent{}
