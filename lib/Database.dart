import 'package:expense/model/expensemodel.dart';
import 'package:expense/model/usermodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DbHelper {

   DbHelper._();
  static DbHelper getInstance()=> DbHelper._();
  ///login_id
  static final String login_uid="uid";
  ///table names
  static final  String user_table= "users";
  static final String expense_table= "expenses";
  static final String categgories_table= "categories";
  ///table_user_columns


   static final  String Column_user_id="uId";
   static final  String Column_user_email="uemail";
   static final  String Column_user_name="uname";
   static final  String Column_user_pass="upass";

   ///table_expense_column
   static final  String Column_expense_id= "expId";
   static final  String Column_expense_amount= "amt";
   static final  String Column_expense_date= 'date';
   static final String Column_expense_type= "type";
   static final String Column_expense_title= "title";
   static final String Column_expense_desc= "desc";
   static final String Column_expense_remaining_balance= "balance";

   ///table categories_column

   static final String Column_category_id = "cId";
   static final String Column_category_name="cName";
   static final String Column_category_img="img";



   Database? mdb;
   Future<Database> getdb() async{
     if(mdb !=null){
       return mdb!;
     }else {
       mdb= await openDb();
       return mdb!;
     }
   }
   Future<Database> openDb() async{
     var appdir=  await getApplicationDocumentsDirectory();
     var dbpath= join(appdir.path, "todo.db");
     return openDatabase(dbpath,version: 1, onCreate: (db,version){
       db.execute(
         "create table $user_table ( $Column_user_id integer primary key autoincrement, $Column_user_email  text unique , $Column_user_name text , $Column_user_pass text) "

       );
       db.execute(
         " create table $expense_table ( $Column_expense_id integer primary key autoincrement, $Column_user_id integer, $Column_category_id integer, $Column_expense_amount real, $Column_expense_date text, $Column_expense_title  text , $Column_expense_desc text, $Column_expense_remaining_balance real , $Column_expense_type text )");

       db.execute(
         " create table $categgories_table ( $Column_category_id integer primary key autoincrement, $Column_category_name text, $Column_category_img text ) ");

     });
  }
 Future<bool> addexpense(expenseModel addexpense)async {
     var uid= await getuid();
     addexpense.userId=uid;
     var db= await getdb();

    var rowseffected= await db.insert(expense_table, addexpense.toMap());
     print(" ye hai: ${addexpense.toMap()}");
    return rowseffected>0;
 }
 Future<List<expenseModel>> getexpense() async {

     var db= await getdb();
     var uid= await getuid();
     List<expenseModel> mdata=[];
   var data= await  db.query(expense_table,where: "$Column_user_id=?",whereArgs: ["$uid"]);
   for(Map<String,dynamic> eachMap in data  ){
     var expensemodel= expenseModel.fromMap(eachMap);
     mdata.add(expensemodel);
     print(expensemodel);
     print(" this is ${mdata[0].category_id}");
     //print(" this is: $mdata");
   }
   return mdata;
 }
 void update(expenseModel updatedata) async {
   var db= await getdb();
   db.update(expense_table, updatedata.toMap(), where: "$Column_expense_id =?", whereArgs: [
    " ${updatedata.expenseId }"]);

 }
 Future<bool> addnewuser( userModal newuser) async{
     var db= await getdb();
     bool authe=  await checkforuser(newuser.uemail);
     bool  accCreated= false;
     if(!authe){
     var rowseffected=  await  db.insert(user_table, newuser.toMap());
     accCreated= rowseffected>0;
     }
    return accCreated;
 }
Future<bool> checkforuser(String email) async{
     var db = await getdb();
   var data= await  db.query(user_table, where: "$Column_user_email= ?", whereArgs:  [email]);
   if(data.isNotEmpty){
     setuid(userModal.fromMap(data[0]).uid);
   }
   return data.isNotEmpty;
}
Future<bool> authenticateUser(String email, String pass) async{
     var db = await getdb();
     var data= await db.query(user_table, where: "$Column_user_email=? AND $Column_user_pass=? ", whereArgs: [email,pass]);
     if(data.isNotEmpty) {
       setuid(userModal.fromMap(data[0]).uid);
     }
     return data.isNotEmpty;
}
Future<int> getuid() async{
  var prefs= await  SharedPreferences.getInstance();
 return  prefs.getInt("UID")!;

}
  void setuid(int uid) async{


     var prefs= await  SharedPreferences.getInstance();
     prefs.setInt("UID", uid);
  }

  }



