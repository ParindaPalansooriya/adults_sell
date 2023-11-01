import 'dart:async';

import 'package:adults_sell/registration/set_password.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../const/colors.dart';
import '../const/fonts.dart';
import '../custom_widget/page_cover.dart';
import '../custom_widget/reg_input.dart';
import '../registration_provider.dart';
import '../services/dialog_service.dart';

class OtpVerify extends StatefulWidget {

  const OtpVerify({Key? key}) : super(key: key);

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  MaskTextInputFormatter otpMask =  MaskTextInputFormatter(mask: '# # # - # # #', filter: { "#": RegExp(r'[0-9]') });
  Timer? _timer;
  int count = 0;
  int maxCount = 60*2;
  final _scaffoldKey =  GlobalKey<ScaffoldState>();
  var conn = TextEditingController();

  int resendattept = 0;

  @override
  void dispose() {
    if(_timer!=null){
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_)async{
      startTimer();
    });
    super.initState();
  }

  startTimer(){
    count = maxCount;
    if(_timer!=null && _timer!.isActive){
      _timer!.cancel();
    }
    _timer= Timer.periodic(const Duration(seconds: 1), (timer) {
      print("object");
      setState(() {
        count--;
      });
      if(count<=0){
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RegistrationProvider provider = Provider.of<RegistrationProvider>(context,listen: false);
    return PageCover(
        title: "OTP",
        needBack: false,
        needBottom: true,
        needTop: false,
        globleKey: _scaffoldKey,
        backgroundType: 1,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40,left: 20,right: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset("assets/image/logo.png"),
              ),
              const SizedBox(height: 30),
              RegInput("OTP", "0 0 0 - 0 0 0",inputType: TextInputType.number,mask: otpMask,textController: conn,),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "OTP will expired in "+(count/60).toString().split(".").first.padLeft(2,"0")+":"+(count%60).toStringAsFixed(0).padLeft(2,"0")+" sec",
                    style: TextStyle(fontFamily: Fonts.poppinsRegular,fontSize: 12,color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed:count>0?null:()async{
                            if(resendattept<6) {
                              resendattept++;
                              bool action = await provider.resendOTP(context);
                              if (action) {
                                if (count <= 0) {
                                  setState(() {
                                    startTimer();
                                  });
                                }
                              } else {
                                showMessageDialog("Some thing wrong on resend OTP");
                              }
                            }else{
                              showMessageDialog("Some thing wrong on Your mobile number. Please go back and change your mobile number");
                            }
                          },
                          child: Text(
                            "Resend",
                            style: TextStyle(fontFamily: Fonts.poppinsBold,fontSize: 15,color: count>0?Colors.grey.shade400:appColorMain),
                          )
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: ()async{
                            bool action = await provider.verifyOTP(context, otpMask.getUnmaskedText());
                            if(action){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SetPassword(type: 0)));
                            }else{
                              showMessageDialog("Wrong OTP!");
                            }
                          },
                          child: Text(
                            "Verify",
                            style: TextStyle(fontFamily: Fonts.poppinsBold,fontSize: 15,color: appColorMain),
                          )
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
