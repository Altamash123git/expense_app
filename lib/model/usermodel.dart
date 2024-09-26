import 'package:expense/Database.dart';

class userModal{
  int uid;
  String uemail;
  String upass;
  String uname;
  userModal({
    required this.uemail,
    required this.uid,
    required this.uname,
    required this.upass
});
  factory userModal.fromMap(Map<String,dynamic> map){
    return userModal(uemail: map[DbHelper.Column_user_email], uid: map[DbHelper.Column_user_id], uname: map[DbHelper.Column_user_name], upass: map[DbHelper.Column_user_pass]);
  }
  Map<String,dynamic> toMap(){
    return {
      DbHelper.Column_user_email:uemail,
      DbHelper.Column_user_name: uname,
      DbHelper.Column_user_pass: upass,

    };
  }
}