import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../const/colors.dart';
import '../const/fonts.dart';
import '../custom_widget/page_cover.dart';
import '../custom_widget/reg_input.dart';
import '../registration_provider.dart';
import '../services/dialog_service.dart';
import 'otp_verify.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  MaskTextInputFormatter usernameMask =  MaskTextInputFormatter(mask: '0##-#######', filter: { "#": RegExp(r'[0-9]') });
  final _scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    RegistrationProvider registrationProvider = Provider.of<RegistrationProvider>(context);
    return PageCover(
        title: "LogIn",
        needBack: false,
        globleKey: _scaffoldKey,
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
                      if(usernameMask.isFill()) {
                        int id = await registrationProvider.getUserByNumber(context, "0" + usernameMask.getUnmaskedText());
                        if (id > 0) {
                          registrationProvider.tempId = id;
                          bool? action = await registrationProvider.resendOTP(context,id: id.toString());
                          if(action){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpVerify()));
                          }else{
                            showMessageDialog("Somethings Wrong on Sending OTP");
                          }
                        } else {
                          showMessageDialog("Not Existing");
                        }
                      }else{
                        showMessageDialog("Wrong Mobile Number");
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
