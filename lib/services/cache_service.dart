import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

Future setToken(String? value)async{
  if(value!=null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", value);
  }
}

Future<String> getToken()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey("token")) {
    String? data = prefs.getString("token");
    return data??"";
  }else{
    return "";
  }
}

Future setOrderIdForRecivedJob(int? value)async{
  if(value!=null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> list = await getOrderIdForRecivedJob();
    if(!list.contains(value)){
      list.add(value);
    }
    await prefs.setString("recivedJobs", jsonEncode(list));
  }
}

Future clearAllOrderIdForRecivedJob()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("recivedJobs", jsonEncode([]));
}

Future deleteOrderIdForRecivedJob(int? value)async{
  if(value!=null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> list = await getOrderIdForRecivedJob();
    if(list.contains(value)){
      list.remove(value);
    }
    await prefs.setString("recivedJobs", jsonEncode(list));
  }
}

Future<List<int>> getOrderIdForRecivedJob()async{
  List<int> list = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey("recivedJobs")){
    String? data = prefs.getString("recivedJobs");
    if(data!=null){
      List<dynamic> temp = jsonDecode(data);
      for (var element in temp) {
        print(element);
        list.add(int.tryParse(element.toString())??0);
      }
    }
  }
  return list;
}

// Future setLogIn(Login? value)async{
//   if(value!=null) {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString("login", jsonEncode(value));
//     print("save login");
//   }
// }
//
// Future<Login?> getLogIn()async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if(prefs.containsKey("login")) {
//     String? data = prefs.getString("login");
//     if(data!=null) {
//       Login? login = Login.fromJson(jsonDecode(data));
//       return login;
//     }
//     return null;
//   }else{
//     return null;
//   }
// }
//
// Future<int> getLogInId()async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if(prefs.containsKey("login")) {
//     String? data = prefs.getString("login");
//     if(data!=null) {
//       Login? login = Login.fromJson(jsonDecode(data));
//       return login.id??0;
//     }
//     return 0;
//   }else{
//     return 0;
//   }
// }

Future removeChach()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey("token")){
    await prefs.remove("token");
  }
  if(prefs.containsKey("login")){
    await prefs.remove("login");
  }
}