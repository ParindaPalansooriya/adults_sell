import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../const/fonts.dart';
import '../custom_widget/page_cover.dart';
import '../custom_widget/reg_input.dart';
import '../registration_provider.dart';
import '../services/cache_service.dart';
import 'login.dart';

class SetPassword extends StatelessWidget {

  int type=0;

  SetPassword({Key? key,required this.type}) : super(key: key);

  TextEditingController password = TextEditingController();
  TextEditingController conPassword = TextEditingController();
  final _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    RegistrationProvider provider = Provider.of<RegistrationProvider>(context,listen: false);
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
              RegInput("Password", "***********", textController: password,inputType: TextInputType.text,isPassword: true,),
              const SizedBox(height: 30),
              RegInput("Confirm Password", "***********",textController: conPassword,inputType: TextInputType.text,isPassword: true,),
              const SizedBox(height: 40),
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
                      bool action = await provider.setPassword(context,password.text.trim(),conPassword.text.trim());
                      if(action){
                        provider.cleanRegistration();
                        await removeChach();
                        if(type==0){
                          // Navigator.pop(context,true);
                          // Navigator.pop(context,true);

                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (BuildContext context) => LogIn()), (
                              route) => false);
                        }else {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (BuildContext context) => LogIn()), (
                              route) => false);
                        }
                      }
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(fontFamily: Fonts.poppinsBold,fontSize: 15,color: appColorMain),
                    )
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        )
    );
  }
}
