import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../const/colors.dart';
import '../const/fonts.dart';

class PageCover extends StatefulWidget {

  String title;
  bool needBack;
  bool needBottom;
  var needTop;
  int? backgroundType; // 1=appColor, 2=white, 3=image
  Widget body;
  EdgeInsets? padding;
  Key? globleKey;


  PageCover({required this.title, required this.needBack, required this.needBottom, required this.body, Key? key,this.globleKey,this.needTop,this.padding,this.backgroundType}): super(key: key);

  @override
  _PageCoverState createState() => _PageCoverState();
}

class _PageCoverState extends State<PageCover> {
  bool checked=false;
  String appLocalVersion = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget mainDrawer(){
    return Scaffold(
      backgroundColor: appColorMain,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: appColorMain,
                height: 50,
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height:20),
                        // InkWell(
                        //   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));},
                        //   child: Text( "Profile",
                        //     style: TextStyle(fontSize: 12,fontFamily: Fonts.poppinsBold,color: Colors.grey.shade700),
                        //   ),
                        // ),
                        // const SizedBox(height:10),
                        // InkWell(
                        //   onTap: ()async{
                        //     await removeChach();
                        //     RegistrationProvider provider = Provider.of<RegistrationProvider>(context,listen: false);
                        //     provider.cleanOtherAll();
                        //     provider.cleanRegistration();
                        //     provider.cleanTemp();
                        //     provider.clearFiles();
                        //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        //         builder: (BuildContext context) => LogIn()), (route) => false);
                        //     },
                        //   child: Text( "Logout",
                        //     style: TextStyle(fontSize: 12,fontFamily: Fonts.poppinsBold,color: Colors.grey.shade700),
                        //   ),
                        // ),
                        // const SizedBox(height:10),
                        // InkWell(
                        //   onTap: (){},
                        //   child: Text( "Profile",
                        //     style: TextStyle(fontSize: 12,fontFamily: Fonts.poppinsBold,color: Colors.grey.shade700),
                        //   ),
                        // ),
                        // const SizedBox(height:10),
                        // InkWell(
                        //   onTap: (){},
                        //   child: Text( "Profile",
                        //     style: TextStyle(fontSize: 12,fontFamily: Fonts.poppinsBold,color: Colors.grey.shade700),
                        //   ),
                        // ),
                      ],
                    ),
                  )
              ),
              FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Container();
                    }
                    appLocalVersion = snapshot.data!.version;
                    return Text( "V $appLocalVersion",
                      style: TextStyle(fontSize: 12,fontFamily: Fonts.poppinsRegular,color: widget.backgroundType==1?Colors.white:Colors.grey.shade700),
                    );
                  },
              ),
              // StatefulBuilder(builder: (context, setState) {
              //   PackageInfo.fromPlatform().then((value) {
              //     setState((){
              //       appLocalVersion = value.version;
              //     });
              //   });
              //
              // },),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.globleKey??GlobalKey<ScaffoldState>(),
      drawer: Padding(
        padding:  EdgeInsets.only(right: (MediaQuery.of(context).size.width/4)),
        child: Container(
          color: Colors.white,
          child: mainDrawer(),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: /*widget.backgroundType==null || widget.backgroundType==2 ? Colors.white: widget.backgroundType==1?*/appColorMain/*: Colors.transparent*/,
      body: SafeArea(
          child: Column(
            children: [
              widget.needTop==null || widget.needTop?Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 25, 15),
                color: appColorMain,
                child: Row(
                  children: [
                    widget.needBack?SizedBox(
                      width: 40,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ):const SizedBox(width: 0),
                    Expanded(child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                    // SizedBox(
                    //   width: 40,
                    //   child: IconButton(
                    //     padding: EdgeInsets.zero,
                    //     constraints: const BoxConstraints(),
                    //     onPressed: () => Navigator.pop(context),
                    //     icon: const Icon(
                    //       Icons.menu,
                    //       size: 20,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ):const SizedBox(),
              Expanded(child: Container(
                color: widget.backgroundType==null || widget.backgroundType==2 ? Colors.white: widget.backgroundType==1?appColorMain: Colors.transparent,
                padding: widget.padding??EdgeInsets.zero,
                child: widget.body,
              )),
              widget.needBottom?Container(
                color: widget.backgroundType==null || widget.backgroundType==2 ? Colors.white: widget.backgroundType==1?appColorMain: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) {
                        if(snapshot.hasError){
                          return Container();
                        }
                        appLocalVersion = snapshot.data!.version;
                        return Text( "V $appLocalVersion",
                          style: TextStyle(fontSize: 12,fontFamily: Fonts.poppinsRegular,color: widget.backgroundType==1?Colors.white:Colors.grey.shade700),
                        );
                      },
                    ),
                  ],
                ),
              ):const SizedBox()
            ],
          )
      ),
    );
  }
}
