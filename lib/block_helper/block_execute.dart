import 'package:bloc/bloc.dart';
import 'package:expense/Database.dart';
import 'package:expense/block_helper/block_event.dart';
import 'package:expense/block_helper/block_state.dart';
import 'package:expense/model/expensemodel.dart';

class expensebloc extends Bloc<expeneEvent,expensestate>{
  DbHelper dbHelper;
  expensebloc({required this.dbHelper}) :super(initialstate()){

on<addexpenseEvt>((event, emit)async{
  emit(loading_state());
  bool check=
  
  await dbHelper.addexpense(event.expense );
if(check){
 var currentData= await dbHelper.getexpense();
  emit(loaded_state(mdata: currentData));
}else{
  emit(errorstate(error_msg: " Error:expense not added"));
}

});
on<getExpenseEvt>((event,emit)async{
  emit(loading_state());

  var currentData= await dbHelper.getexpense();
  emit(loaded_state(mdata: currentData));
});
  }
}

