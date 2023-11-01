import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../const/fonts.dart';
import '../custom_widget/page_cover.dart';
import '../custom_widget/reg_input.dart';
import '../registration_provider.dart';
import '../services/dialog_service.dart';
import 'otp_verify.dart';

class RegistorFirst extends StatelessWidget {

  final _scaffoldKey =  GlobalKey<ScaffoldState>();

  RegistorFirst({Key? key}) : super(key: key);

  loadInitData(RegistrationProvider provider,BuildContext context)async{
    if(provider.citiesList.isEmpty){
      await provider.loadCities(context);
    }
    if(provider.districtsList.isEmpty){
      await provider.loadDistricts(context);
    }
  }

  bool firstLoad = true;

  @override
  Widget build(BuildContext context) {
    RegistrationProvider provider = Provider.of<RegistrationProvider>(context);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp){
      if(firstLoad) {
        loadInitData(provider, context);
        firstLoad = false;;
      }
    });
    return PageCover(
        title: "LogIn",
        needBack: false,
        needBottom: true,
        needTop: false,
        globleKey: _scaffoldKey,
        backgroundType: 1,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset("assets/image/logo.png"),
                ),
                const SizedBox(height: 30),
                RegInput("Email", "Email@host.lk", textController: provider.emailController,inputType: TextInputType.emailAddress),
                const SizedBox(height: 30),
                RegInput("Phone Number (User Name)", "012-3456789", mask: provider.mobileNumberMask,textController: provider.mobileNumberController,inputType: TextInputType.phone),
                const SizedBox(height: 30),
                RegInput("Birth Day", "YYYY-MM-DD", mask: provider.dateMask,textController: provider.dateController,inputType: TextInputType.number),
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
                            onPressed: (){Navigator.pop(context);},
                            child: Text(
                              "Back",
                              style: TextStyle(fontFamily: Fonts.poppinsBold,fontSize: 15,color: appColorMain),
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
                              bool action = await provider.registorPersonalData(context);
                              if(action){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpVerify()));
                              }else{
                                showMessageDialog("Something Wrong");
                              }
                            },
                            child: Text(
                              "Next",
                              style: TextStyle(fontFamily: Fonts.poppinsBold,fontSize: 15,color: appColorMain),
                            )
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }



}
