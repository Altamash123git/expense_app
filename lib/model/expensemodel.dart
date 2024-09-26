import 'package:expense/Database.dart';

class expenseModel{
  int userId;
  int expenseId;
  int expense_amt;
  String expense_date;

  expenseModel({
    required this.userId,
    required this.expenseId,
    required this.expense_amt,
    required this.expense_date,
});
  factory expenseModel.fromMap(Map<String,dynamic> map){
    return expenseModel(userId:map[DbHelper.Column_expense_date], expenseId: map[DbHelper.Column_expense_id], expense_amt: map[DbHelper.Column_expense_amount], expense_date: map[DbHelper.Column_expense_date]);
  }
  Map<String,dynamic> toMap(){
    return {
      DbHelper.Column_expense_date: userId,
      DbHelper.Column_expense_amount: expense_amt,
      DbHelper.Column_expense_date:expense_date



    };
  }
}