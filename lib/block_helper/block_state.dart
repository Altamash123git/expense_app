import 'package:expense/model/expensemodel.dart';

abstract class expensestate{}

class loading_state extends expensestate{

}
class loaded_state  extends expensestate{
List<expenseModel> mdata;
loaded_state({required this.mdata});
}
class initialstate extends expensestate{}
class errorstate extends expensestate{
  String error_msg;
  errorstate({required this.error_msg});
}