import 'dart:convert';

import 'package:adults_sell/registration/personal_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../const/colors.dart';
import '../const/fonts.dart';
import '../custom_widget/page_cover.dart';
import '../custom_widget/reg_input.dart';
import '../services/dialog_service.dart';
import 'forgot_password.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);

  MaskTextInputFormatter usernameMask =  MaskTextInputFormatter(mask: '0##-#######', filter: { "#": RegExp(r'[0-9]') });
  TextEditingController password = TextEditingController();
  final _scaffoldKey =  GlobalKey<ScaffoldState>();

  checkLogin(context)async{
    // Login? login = await getLogIn();
    // print(login?.toJson().toString());
    // if(login!=null){
    //   Provider.of<RegistrationProvider>(context,listen: false).loadLogin(login);
    //   if(login.isRegised!=null && login.isRegised!>0){
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
    //   }else{
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Profile()));
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    checkLogin(context);
    return PageCover(
      globleKey: _scaffoldKey,
        title: "LogIn",
        needBack: false,
        needBottom: true,
        needTop: false,
        backgroundType: 1,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40,left: 20,right: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset("assets/image/logo.png"),
              ),
              const SizedBox(height: 20),
              RegInput("User Name", "012-3456789", mask: usernameMask,inputType: TextInputType.phone),
              const SizedBox(height: 30),
              RegInput("Password", "***********",textController: password,inputType: TextInputType.text,isPassword: true,),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontFamily: Fonts.poppinsRegular,fontSize: 12,color: Colors.white),
                      )
                  )
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: TextButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: ()async{
                      if(usernameMask.getUnmaskedText().trim().isNotEmpty && password.text.trim().isNotEmpty) {
                        // Login? login = await ServerRequests().login(context, "0" + usernameMask.getUnmaskedText().trim(), password.text.trim());
                        // if (login != null && (login.id ?? 0) > 0) {
                        //   // login.id=3;
                        //   // await setLogIn(login);
                        //   print(jsonEncode(login));
                        //   Provider.of<RegistrationProvider>(context, listen: false).loadLogin(login);
                        //   if (login.isRegised != null && (login.isRegised ?? 0) > 0) {
                        //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
                        //   } else {
                        //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Profile()));
                        //   }
                        // } else {
                        //   showMessageDialog("Invalid username or password");
                        // }
                      }else{
                        showMessageDialog("Enter username and password ");
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontFamily: Fonts.poppinsBold,fontSize: 15,color: appColorMain),
                    )
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Like to register & become",
                    style: TextStyle(fontFamily: Fonts.poppinsRegular,fontSize: 12,color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(text: 'a rider ? ',
                          style: TextStyle(fontFamily: Fonts.poppinsRegular,fontSize: 12,color: Colors.white),
                      ),
                      TextSpan(text: 'Register Here',
                          style: TextStyle(fontFamily: Fonts.poppinsBold,fontSize: 13,color: Colors.white),
                          recognizer: TapGestureRecognizer()
                            ..onTap = ()async{
                             Navigator.push(context, MaterialPageRoute(builder: (context) => RegistorFirst()));
                            }
                      )
                    ]
                  ),softWrap: true,),
                ],
              )
            ],
          ),
        )
    );
  }
}
