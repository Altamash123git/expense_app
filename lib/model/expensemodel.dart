import 'package:expense/Database.dart';

class expenseModel{
  int? userId;
  int? expenseId;
  int category_id;
  num expense_amt;
  String expense_date;
  String expense_desc;
  String expene_type;
String expense_title;
num expense_balance;
  expenseModel({
     this.userId,
    this.expenseId,
    required this.expense_amt,
    required this.expense_date,
    required this.expene_type,
    required this.expense_desc,
    required this.expense_title,
    required this.expense_balance,
   required this.category_id

});
  factory expenseModel.fromMap(Map<String,dynamic> map){
    return expenseModel(userId:map[DbHelper.Column_user_id], expenseId: map[DbHelper.Column_expense_id], expense_amt: map[DbHelper.Column_expense_amount], expense_date: map[DbHelper.Column_expense_date],expene_type: map[DbHelper.Column_expense_type], expense_desc: map[DbHelper.Column_expense_desc],expense_title:map[DbHelper.Column_expense_title],
        expense_balance: map[DbHelper.Column_expense_remaining_balance],
        category_id:map[DbHelper.Column_category_id]);
  }
  Map<String,dynamic> toMap(){
    return {
      DbHelper.Column_expense_date: expense_date,
      DbHelper.Column_expense_amount: expense_amt,
      //DbHelper.Column_expense_date:expense_date,
      DbHelper.Column_expense_desc:expense_desc,
      DbHelper.Column_expense_title:expense_title,
      DbHelper.Column_expense_type:expene_type,
      DbHelper.Column_expense_remaining_balance:expense_balance,
      DbHelper.Column_category_id:category_id,
      DbHelper.Column_user_id:userId,

    };
  }
}