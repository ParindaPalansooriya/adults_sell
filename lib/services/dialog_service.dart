import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../const/colors.dart';
import '../const/fonts.dart';
import '../main.dart';

showLoadingDialog(String? section){
  return showDialog<int?>(
    useSafeArea: false,
    context: navigatorKey.currentContext!,
    barrierDismissible: true,
    barrierColor: Colors.white,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: dialogBackground,
      insetPadding: EdgeInsets.zero,
      content: StatefulBuilder(builder: (context, setState) {
        // double size = MediaQuery.of(context).size.width/3;
        return Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: Lottie.asset("assets/image/loading.json"),
                ),
                section!=null?Text(
                  section,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: Fonts.poppinsMedium,fontSize: 15,color: appColorMain,),
                ):const SizedBox(),
              ],
            ),
          ),
        );
      },),
    ),
  );
}

showConnectionLostSnakBar(){
  const snackBar = SnackBar(
    backgroundColor: Colors.red,
    duration: Duration(seconds: 5),
    content: Text('Connection Lost!'),
  );
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
}

Future<bool?>? showMessageDialog(String massage){
  return showDialog<bool>(
    useSafeArea: true,
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: AlertDialog(
        backgroundColor: dialogBackground,
        content: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(massage),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColorMain,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),),
                        onPressed:()async{
                          Navigator.pop(context,true);
                        },
                        child: Text('Cancel'.toUpperCase(),style: const TextStyle(color: Colors.white),),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Future<bool?>? showImagePickDialog(){
  return showDialog<bool>(
    useSafeArea: true,
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: AlertDialog(
        backgroundColor: dialogBackground,
        content: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Your Image Source"),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: IconButton(
                          onPressed: (){Navigator.pop(context,false);},
                          icon: const Icon(Icons.add_photo_alternate,color: appColorMain,size: 40)
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: IconButton(
                          onPressed: (){Navigator.pop(context,true);},
                          icon: const Icon(Icons.add_a_photo,color: appColorMain,size: 40)
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Future<bool?>? showExitDialog(){
  return showDialog<bool>(
    useSafeArea: true,
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: AlertDialog(
        backgroundColor: dialogBackground,
        content: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Do you want to exit?"),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: appColorMain,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),),
                        onPressed:()async{Navigator.pop(context,false);},
                        child: Text('No'.toUpperCase()),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: appColorMain,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),),
                        onPressed:()async{
                          Navigator.pop(context,true);
                        },
                        child: Text('Yes'.toUpperCase()),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Future<bool?>? showCashReturnDialog(context){
    return showDialog<bool>(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: AlertDialog(
          backgroundColor: dialogBackground,
          content: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Did you return full amount to outlet?"),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: appColorMain,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),),
                          onPressed:()async{Navigator.pop(context,false);},
                          child: Text('No'.toUpperCase()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: appColorMain,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),),
                          onPressed:()async{Navigator.pop(context,true);},
                          child: Text('Yes'.toUpperCase()),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

class SearchListObject{
  bool isSelected=false;
  String text;
  SearchListObject(this.text);

}

Future<List<int>?> showSearchDialog(context,List<String> listPara, {bool? isMulti})async{
  TextEditingController _text = TextEditingController();
  List<SearchListObject> searchResList=[];
  List<SearchListObject> mainList=listPara.map((e) => SearchListObject(e)).toList();
  List<int> selectedList =[];
  searchResList.addAll(mainList);
  return showDialog<List<int>?>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: dialogBackground,
      content: StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          height: MediaQuery.of(context).size.height/2.5,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: TextField(
                  controller: _text,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.grey,
                  style: TextStyle(color: Colors.grey.shade800,fontSize: 12),
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: "Type Here To Search",
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
                    border: InputBorder.none,
                  ),
                  onChanged: (vale){
                    setState((){
                      if(vale.isEmpty){
                        print(vale.toString());
                        searchResList.clear();
                        searchResList.addAll(mainList);
                      }else{
                        searchResList.clear();
                        for (var element in mainList) {
                          print(element.toString());
                          if(element.text.isNotEmpty){
                            if(element.text.toLowerCase().contains(vale.toLowerCase())){
                              searchResList.add(element);
                            }
                          }
                        }
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(searchResList.length, (index){
                        return GestureDetector(
                            onTap: (){
                              int selectedIndex = listPara.indexOf(searchResList[index].text);
                              if(isMulti!=null && isMulti){
                                setState((){
                                  if(selectedList.contains(selectedIndex)){
                                    selectedList.remove(selectedIndex);
                                    mainList.firstWhere((element) => element==searchResList[index]).isSelected=false;
                                  }else{
                                    selectedList.add(selectedIndex);
                                    mainList.lastWhere((element) => element==searchResList[index]).isSelected=true;
                                  }
                                });
                              }else{
                                Navigator.pop(context,[selectedIndex]);
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                          searchResList[index].text,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: searchResList[index].isSelected?Fonts.poppinsBold:Fonts.poppinsMedium,
                                              color: searchResList[index].isSelected?appColorMain:Colors.grey.shade500
                                          ),
                                          softWrap: true,
                                        )
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                              ],
                            )
                        );
                      }),
                    ),
                  )
              ),
              isMulti!=null && isMulti?const SizedBox(height: 10):const SizedBox(),
              isMulti!=null && isMulti?SizedBox(
                height: 30,
                width: double.infinity,
                child: TextButton(
                    style: ElevatedButton.styleFrom(
                      primary: appColorMain,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: (){
                      Navigator.pop(context,selectedList);
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(fontFamily: Fonts.poppinsBold,fontSize: 12,color: Colors.white),
                    )
                ),
              ):const SizedBox(),
            ],
          ),
        );
      },),
    ),
  );
}