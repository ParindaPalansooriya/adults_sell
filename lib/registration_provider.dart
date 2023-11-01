import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegistrationProvider with ChangeNotifier{

  MaskTextInputFormatter mobileNumberMask =  MaskTextInputFormatter(mask: '0##-#######', filter: { "#": RegExp(r'[0-9]') });
  MaskTextInputFormatter dateMask =  MaskTextInputFormatter(mask: '####-##-##', filter: { "#": RegExp(r'[0-9]') });
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Map<String,dynamic> citiesList = {};
  Map<String,dynamic> districtsList = {};
  List<bool> finished = [true,false,false,false];

  int tempId = 0;
  String tempOTP = "";

  int finishedSteps = 1;

  Future loadCities(BuildContext context)async{
    citiesList.clear();
    for(int i=0; i<10;i++){
      citiesList["city"+i.toString()] = i;
    }
    notifyListeners();
  }

  Future loadDistricts(BuildContext context)async{

  }

  setCity(int index){
    cityController.text = citiesList.keys.elementAt(index);
    notifyListeners();
  }

  setDistrict(int index){
    districtController.text = districtsList.keys.elementAt(index);
    notifyListeners();
  }

  cleanRegistration(){
     mobileNumberMask.clear();
     dateMask.clear();
     fullNameController.clear();
     emailController.clear();
     nicController.clear();
     addressController.clear();
     cityController.clear();
     districtController.clear();
     mobileNumberController.clear();
     dateController.clear();
     citiesList.clear();
     districtsList.clear();
  }

  Future<bool> registorPersonalData(BuildContext context)async{

    return true;
  }

  bool checkReg(){
    bool dateCheck = dateMask.isFill();
    // bool mobileCheck = mobileNumberMask.isFill();
    // bool emailCheck = Validations().email(emailController.text.trim());
    bool nameCheck = fullNameController.text.trim().isNotEmpty;
    bool nicCheck = nicController.text.trim().isNotEmpty;
    bool addressCheck = addressController.text.trim().isNotEmpty;
    bool cityCheck = cityController.text.trim().isNotEmpty;
    bool districtCheck = districtController.text.trim().isNotEmpty;
    return dateCheck && /*mobileCheck && emailCheck && */nameCheck && nicCheck && addressCheck && cityCheck && districtCheck;
  }

  Future<bool> verifyOTP(BuildContext context,String otp)async{
    return true;
  }

  Future<bool> resendOTP(BuildContext context,{String? id})async{
    return true;
  }

  Future<int> getUserByNumber(BuildContext context,String number)async{
    return 1;
  }

  Future<bool> setPassword(BuildContext context,String pass1,String pass2)async{
    return true;
  }
}