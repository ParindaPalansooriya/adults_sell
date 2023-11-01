import 'package:adults_sell/const/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../cart_viewmodel.dart';
import '../const/colors.dart';
import '../product.dart';
import '../product_viewmodel.dart';

class ProductListItem extends StatefulWidget {
  final Product? product;
  final int? index;

  const ProductListItem({Key? key,this.product, this.index}) : super(key: key);

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {

  int count = 0;

  @override
  void initState() {
    count = Provider.of<CartViewModel>(context,listen: false).getQuntity(widget.product!);
    super.initState();
  }

  var formatter = NumberFormat('###,###,###.00');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
            builder: (context,size) {
              return Stack(
                children: [
                  InkWell(
                    onTap: ()async{},
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10,right: 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: widget.product!.urlImage![0]!=null?Image.network(
                          widget.product!.urlImage![0]!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Padding(
                            padding: const EdgeInsets.all(40),
                            child: Image.asset(
                              "assets/image/no-image.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ):Padding(
                          padding: const EdgeInsets.all(40),
                          child: Image.asset(
                            "assets/image/no-image.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget.product!.currentStock!>0?const SizedBox():Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black45
                    ),
                    child: SvgPicture.asset("assets/image/stok_out.svg"),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            widget.product!.isLike =! widget.product!.isLike!;
                            if(widget.product!.isLike!){
                              Provider.of<ProductViewModel>(context,listen: false).likeProduct(widget.product!);
                            }else{
                              Provider.of<ProductViewModel>(context,listen: false).unLikeProduct(widget.product!);
                            }
                          });
                        },
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  offset: const Offset(1, 1),
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Icon(
                              widget.product!.isLike! ?Icons.favorite  :  Icons.favorite_border,
                              color:  widget.product!.isLike! ?  primaryColorRed : primaryColorGray,
                              size: 19,
                            ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: ()async{
                        Provider.of<ProductViewModel>(context,listen: false).addRecentView(widget.product!);
                        await showChooseSize(context, widget.product);
                        setState(() {});
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(widget.product!.category!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: Fonts.poppinsMedium,
                                fontSize: 11,
                                color: Colors.grey.shade500
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(widget.product!.title!,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: TextStyle(
                                  fontFamily: Fonts.poppinsBold,
                                  fontSize: 13
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text( formatter.format(widget.product!.price??0),
                style: TextStyle(
                    fontFamily: Fonts.poppinsBold,
                    fontSize: 14,
                    color: primaryColorRed
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              (widget.product!.r_price??0)>(widget.product!.price??0)?Text( formatter.format(widget.product!.r_price??0),
                style: TextStyle(
                    fontFamily: Fonts.poppinsBold,
                    fontSize: 10,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 8,
                    color: Colors.grey.shade600
                )):const SizedBox(),
              SizedBox(
                height: (widget.product!.r_price??0)>(widget.product!.price??0)?8:0,
              ),
              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: count<=0?Colors.grey.shade300:Colors.yellow.shade800
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: (){
                        int code = Provider.of<CartViewModel>(context,listen: false)
                            .setQuntity(widget.product!, count-1);
                        setState(() {
                          if(code==1){
                            count--;
                          }
                          if(code==2){
                            count=0;
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                        child: const Icon(
                          Icons.remove,
                          size: 10,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(count.toString(),style: const TextStyle(color: Colors.black,fontSize: 15),),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                        child: const Icon(
                          Icons.add,
                          size: 10,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Future showChooseSize(BuildContext ctx,Product? product){
    return  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
          print(widget.product!.toJson().toString());
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height/3,
                    child: widget.product!.urlImage![0]!=null?Image.network(
                      widget.product!.urlImage![0]!,
                      fit: BoxFit.cover,
                    ):Padding(
                      padding: const EdgeInsets.all(40),
                      child: Image.asset(
                        "assets/image/no-image.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.product!.title!,
                                style: TextStyle(
                                    fontFamily: Fonts.poppinsBold,
                                    fontSize: 15
                                ),
                              ),
                            ),
                            Text(
                              widget.product!.price!.toStringAsFixed(2),
                              style: TextStyle(
                                  fontFamily: Fonts.poppinsBold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.product!.category!,
                                style: TextStyle(
                                  fontFamily: Fonts.poppinsRegular,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                    color: Colors.grey
                                ),
                              ),
                            ),

                            (widget.product!.r_price??0)>(widget.product!.price??0)?Text( formatter.format(widget.product!.r_price??0),
                              style: TextStyle(
                                fontFamily: Fonts.poppinsBold,
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 8,
                                color: Colors.grey.shade600
                            )):const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        widget.product!.description!=null?Text(
                          widget.product!.description!,
                          style: TextStyle(
                              fontFamily: Fonts.poppinsRegular,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Colors.grey
                          ),
                        ):const SizedBox(),
                        SizedBox(
                          height: widget.product!.description!=null?5:0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: count<=0?Colors.grey.shade300:Colors.yellow.shade800
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: InkWell(
                                        onTap: (){
                                          int code = Provider.of<CartViewModel>(context,listen: false)
                                              .setQuntity(widget.product!, count-1);
                                          setState(() {
                                            if(code==1){
                                              count--;
                                            }
                                            if(code==2){
                                              count=0;
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                                          child: const Icon(
                                            Icons.remove,
                                            size: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(count.toString(),style: const TextStyle(color: Colors.black,fontSize: 15),),
                                  Expanded(
                                    child: Center(
                                      child: InkWell(
                                        onTap: (){
                                          int code = Provider.of<CartViewModel>(context,listen: false)
                                              .setQuntity(widget.product!, count+1);
                                          setState(() {
                                            if(code==1){
                                              count++;
                                            }
                                            if(code==2){
                                              count=0;
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                                          child: const Icon(
                                            Icons.add,
                                            size: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },);
      },
    );
  }

}
