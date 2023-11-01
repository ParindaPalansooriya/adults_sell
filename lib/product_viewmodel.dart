
import 'dart:io';

import 'package:adults_sell/product.dart';
import 'package:flutter/material.dart';

import 'cart_viewmodel.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> listProduct =[];
  Map<String,Product> productMap = {};
  List<Product> listSearchProduct =[];
  List<Product> listCategoryProduct =[];
  Map<String,Product> listLikeProduct={};
  List<Product> listRecent = [];
  List<Product> listNewProduct =[];
  List<Product> listMostProduct =[];
  bool isLoading = false,isOutletChanged = false;

  List<Product> orderItems = [];


  Map<String,File?> listImageUrl = {};

  loadImagers(String key,File? image)async{
    listImageUrl[key] = image;
    notifyListeners();
  }

  List<CartItems?>? addProductToCartItems(List<CartItems?>? list){
    if(list==null){
      return [];
    }else {
      list.forEach((element) {
        if(element!=null) {
          if (productMap.containsKey(element.ItemId.toString())) {
            Product? product = productMap[element.ItemId.toString()];
            element.product = product;
            element.count = int.tryParse(element.OrderQuantity.toString()) ?? 0;
          } else {
            element.product = null;
            element.count = 0;
          }
        }
      });
      return list;
    }
  }


  Future<List<Product>> getListCategoryProductSearch(BuildContext context,String? text,String catId) async {
    isLoading = true;
    notifyListeners();
    List<Product> temp =[];
    if(text != null && text!=""){
      listCategoryProduct.forEach((element) {
        if(element.title!.toLowerCase().contains(text.toLowerCase())){
          temp.add(element);
        }
      });
    }else{
      temp.addAll(listCategoryProduct);
    }
    isLoading = false;
    notifyListeners();
    return temp;
  }

  Future<void> getListProductByCat(String cat) async {
    isLoading = true;
    notifyListeners();
    // listCategoryProduct = await ServerRequests().getProductByCatId(cat);
    // _setCatetory(listCategoryProduct);
    listCategoryProduct.clear();
    listProduct.forEach((element) {
      if(element.categoryId==cat){
        listCategoryProduct.add(element);
      }
    });
    isLoading = false;
    notifyListeners();
  }

   Future likeProduct (Product product)  async {
    print(product.title);
    if(product.id!=null && !listLikeProduct.containsKey(product)){
      listLikeProduct[product.id!]=product;
    }
  }

  Future unLikeProduct (Product product)  async {
    print(product.title);
    if(listLikeProduct.containsKey(product.id)){
      listLikeProduct.remove(product.id);
      // notifyListeners();
    }
    listNewProduct.forEach((element) {
      if(element.id == product.id){
        element.isLike=false;
      }
    });
    listMostProduct.forEach((element) {
      if(element.id == product.id){
        element.isLike=false;
      }
    });
  }

   addRecentView(Product product){
    if (listRecent.isEmpty || !listRecent.contains(product)) {
      if(listRecent.length >= 30){
        listRecent.removeAt(0);
      }
      listRecent.add(product);
    }
  }

}
