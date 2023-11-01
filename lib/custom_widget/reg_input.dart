import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../const/fonts.dart';

class RegInput extends StatelessWidget {

  String? text;
  String? hint;
  int? type;
  bool? isMultiline;
  TextInputType? inputType;
  bool? isPassword;
  TextEditingController? textController;
  bool isView = true;
  List<MaskTextInputFormatter>? maskList;
  bool? isEnable;

  RegInput(this.text,this.hint,{Key? key,TextEditingController? textController,bool? isEnable,int? type,bool? isMultiline,bool? isPassword,TextInputType? inputType,MaskTextInputFormatter? mask}) : super(key: key){
    this.isMultiline = isMultiline??false;
    this.isPassword = isPassword??false;
    this.textController=textController??TextEditingController();
    this.type = type??1;
    this.inputType = inputType??TextInputType.text;
    this.isEnable = isEnable??true;
    if(mask==null){
      maskList=null;
    }else{
      maskList=[mask];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                fontFamily: Fonts.poppinsRegular,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(child: Divider(color: Colors.white,thickness: 1,))
          ],
        ),
        const SizedBox(height: 5),
        StatefulBuilder(builder: (context, setState) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 15),
              Expanded(
                child: TextField(
                  enabled: isEnable,
                  inputFormatters: maskList,
                  controller: textController,
                  textAlign: TextAlign.left,
                  obscureText: isPassword!?isView:false,
                  obscuringCharacter: "*",
                  cursorColor: Colors.black,
                  keyboardType: isMultiline!?TextInputType.multiline:inputType,
                  maxLines: isMultiline!?null:1,
                  decoration: InputDecoration.collapsed(hintText: hint,hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade200,
                    fontFamily: Fonts.poppinsRegular,
                  )),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    fontFamily: Fonts.poppinsRegular,
                  ),
                ),
              ),
              isPassword!?Center(
                child: IconButton(icon:Icon(isView?Icons.visibility_off:Icons.visibility,color:Colors.white),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    iconSize: 20,
                    constraints: const BoxConstraints(),
                    onPressed: (){
                      setState(() {
                        isView = !isView;
                      });
                    }),
              ):const SizedBox()
            ],
          );
        },)
      ],
    );
  }
}
