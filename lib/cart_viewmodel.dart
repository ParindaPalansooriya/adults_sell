

import 'dart:convert';

import 'package:adults_sell/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItems{
  Product? product;
  int count=0;

  int? ItemId;
  String? ItemName;
  double? OrderQuantity;
  double? Amount;

  CartItems(this.product, this.count);
  increaseCount(){count++;}
  decreaseCount(){count--;}
  setCount(int count){if(count>0){this.count=count;}}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemId'] = int.parse(product!.id??"0");
    data['ItemName'] = product!.title;
    data['OrderQuantity'] = double.parse(count.toString());
    data['Amount'] = ((product!.price??0)*count);
    return data;
  }

  CartItems.fromJason(Map<String, dynamic> json){
    ItemId = json['ItemId'];
    ItemName = json['ItemName'];
    OrderQuantity = json['OrderQuantity'];
    Amount = double.tryParse(json['Amount'].toString())??0.0;
  }

}

class CartViewModel extends ChangeNotifier {

  Map<String,CartItems> cartList = {};
  double discountPrice=0.0;
  int quntity=0;
  double totalAmount = 0;
  Map<int,String> orderStatus = {};
  String? copen;

  setDiscout(double discountPrice,String coupen){
    this.copen=coupen;
    this.discountPrice=discountPrice;
    notifyListeners();
  }

  List<CartItems> getCart(){
    return cartList.values.toList();
  }


  setCartList(List<CartItems?>? list){
    print(list!.length);
    double total = 0;
    if(list!=null) {
      list.forEach((element) {
        if (element!=null && element.product != null) {
          int qunt = int.parse(element.OrderQuantity!.toStringAsFixed(0));
          if(qunt<=(element.product!.currentStock??0)){
            element.count = qunt;
          }else{
            element.count = (element.product!.currentStock??0);
          }
          print(jsonEncode(element));
          if(element.count>0) {
            cartList[element.product!.id!] = element;
            total += ((element.product!.price ?? 0) * element.count);
          }
        }
      });
      quntity=cartList.length;
    }
    totalAmount = total;
    notifyListeners();
  }

  Future<List<CartItems>> checkCartList(List<CartItems?>? list)async{
    List<CartItems> listTemp =[];
    print(list!.length);
    if(list!=null) {
      list.forEach((element) {
        if (element!=null && element.product != null) {
          int qunt = int.parse(element.OrderQuantity!.toStringAsFixed(0));
          if(qunt<=(element.product!.currentStock??0)){
            element.count = qunt;
          }else{
            element.count = (element.product!.currentStock??0);
          }
          print(jsonEncode(element));
          if(element.count<=0) {
            listTemp.add(element);
          }
        }
      });
    }
    return listTemp;
  }

  updateCartWhenChangeOutlet(){

  }

  add(Product product){
    if(cartList.containsKey(product.id)){
      cartList[product.id!]!.increaseCount();
      totalAmount += product.price!;
    }else {
      cartList[product.id!]=CartItems(product, 1);
      quntity++;
      totalAmount += product.price!;
    }
    // totalAmount<0?totalAmount=0:totalAmount=totalAmount;
    notifyListeners();
  }

  int getQuntity(Product product){
    if(cartList.containsKey(product.id)){
      return cartList[product.id]!.count;
    }else{
      return 0;
    }
  }

  setQuntity(Product product,int count){
    if(count>0){
      if(checkInventory(product, count)){
        if(cartList.containsKey(product.id)){
          totalAmount += (product.price!*(count-cartList[product.id!]!.count));
          print((product.price!*(count-cartList[product.id!]!.count)).toString());
          cartList[product.id!]!.setCount(count);
        }else{
          cartList[product.id!]=CartItems(product, count);
          quntity++;
          totalAmount += (product.price!*count);
        }
        // totalAmount<0?totalAmount=0:totalAmount=totalAmount;
        notifyListeners();
        return 1;
      }else{
        // totalAmount<0?totalAmount=0:totalAmount=totalAmount;
        notifyListeners();
        return 0;
      }
    }else{
      remove(product.id!);
      // totalAmount<0?totalAmount=0:totalAmount=totalAmount;
      notifyListeners();
      return 2;
    }
  }

  remove(String id){
    if(cartList.containsKey(id)){
      totalAmount -= cartList[id]!.count * cartList[id]!.product!.price!;
      cartList[id]!.count=0;
      cartList.remove(id);
      quntity--;
    }
    // totalAmount<0?totalAmount=0:totalAmount=totalAmount;
    notifyListeners();
  }

  increaseQuntity(CartItems item, BuildContext context){
    if(checkInventory(item.product!, item.count+1)){
      item.increaseCount();
      totalAmount += item.product!.price??0;
      notifyListeners();
      return true;
    }else{
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 5), () {
              Navigator.of(context).pop(true);
            });
            return const AlertDialog(
              title: Text("Maximum purchase quantity reached",
                textAlign: TextAlign.center,
              ),
            );
          });
      notifyListeners();
      return false;
    }
  }

  decreaseQuntity(CartItems item){
    if(item.count<=1){
      remove(item.product!.id!);
    }else{
      if(checkInventory(item.product!, item.count-1)){
        item.decreaseCount();
        totalAmount -= item.product!.price??0;
        notifyListeners();
        return true;
      }
    }
    // totalAmount<0?totalAmount=0:totalAmount=totalAmount;
    notifyListeners();
    return false;
  }

  bool checkInventory(Product product,int count){
    if((product.amountProduct??0)>=count && (product.currentStock??0)>=count){
      return true;
    }
    return false;
  }




  clean(){
    totalAmount = 0;
    quntity = 0;
    cartList.clear();
    notifyListeners();
  }

  // addToCart(Product product, Inventory inventoryy) {
  //   productCount = 0;
  //
  //   if (listCart.isEmpty) {
  //     listCart.add(
  //       Cart().copyWith(
  //         product: product.copyWith(inventory: [inventoryy]),
  //       ),
  //     );
  //     productCount = listCart.length;
  //     print('EMPTY ${productCount}');
  //   } else {
  //     for (int i = 0; i < listCart.length; i++) {
  //       var index = listCart[i]
  //           .product
  //           ?.inventory
  //           ?.indexWhere((element) => element.id == inventoryy.id);
  //       debugPrint("INDEX ${index}");
  //       if (index != -1) {
  //         if (listCart[i].quantity < inventoryy.stockQuantity!) {
  //           listCart[i].quantity++;
  //         } else {
  //           message = "Số lượng không đủ";
  //         }
  //       } else {
  //         isFound = false;
  //       }
  //     }
  //     if (!isFound) {
  //       listCart.add(
  //         Cart().copyWith(
  //           product: product.copyWith(inventory: [inventoryy]),
  //         ),
  //       );
  //       notifyListeners();
  //     }
  //
  //     productCount += listCart.length;
  //     print('NOT EMPTY ${productCount}');
  //   }
  //   calculatePrice();
  //   notifyListeners();
  // }
  //
  // void calculatePrice() {
  //   total = 0;
  //   listCart.forEach((element) {
  //     total += element.product!.price! * element.quantity;
  //   });
  //   notifyListeners();
  // }
  //
  // Future increQuantity(Cart order, Inventory inventory) async {
  //   if (order.quantity < inventory.stockQuantity!) {
  //     order.quantity++;
  //   } else {
  //     message = "Số lượng ko đủ";
  //   }
  //   calculatePrice();
  //   notifyListeners();
  // }
  //
  //
  // void deceQuanity(Cart order) {
  //   if (order.quantity > 1) {
  //     order.quantity--;
  //   } else {}
  //   calculatePrice();
  //   notifyListeners();
  // }
  //
  // void removeCart(int index) {
  //   listCart.removeAt(index);
  //   if (productCount != 0) {
  //     productCount--;
  //   }
  //   calculatePrice();
  //   notifyListeners();
  // }
  //
  // void checkOutCart() {
  //   listOrder.add(Order(
  //       createAt: "12-10-2012",
  //       total: total.toString(),
  //       listItemCart: listCart,
  //       address: Address(
  //           userName: "KHOA",
  //           addressTitle1: "VO VAN VAN",
  //           addressTitle2: "9384932",
  //           phone: "97334324"),
  //       orderNumber: "098765456789"));
  // }
}
