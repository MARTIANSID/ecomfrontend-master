import 'dart:convert';
import 'package:Flutter/screens/appui.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth.dart';
class ExtraCart{
  String displayImage;
  String styleNumber;
}
class Cartt {
  Object product;//styleNumber,imageUrl,
  int quantity;
  String cert;
  String color;
  String diamond;
  String build;
  int colorValue;
  int diamondValue;
  int buildValue;
  int certValue;

  Cartt({
    this.product,
    this.quantity,
    this.cert,
    this.color,
    this.diamond,
    this.build,
    this.buildValue,
    this.certValue,
    this.colorValue,
    this.diamondValue,
  });
}

class Cart with ChangeNotifier {
  List<dynamic> cart = [];
  bool check;

  Future<void> addCart(
      {context,
      product,
      color,
      cert,
      diamond,
      build,
      quantity,
      colorValue,
      buildValue,
      diamondValue,
      certvalue,
      update}) async {
    int index;
    if (!update) {
      index = cart.indexWhere(
          (element) => element.product.styleNumber == product.styleNumber);

      if (index >= 0) {
        if (cart[index].color == color &&
            cart[index].build == build &&
            cart[index].diamond == diamond &&
            cart[index].cert == cert) {
          cart[index].quantity = cart[index].quantity + quantity;
          check=false;

        } else {
          cart.add(Cartt(
            product: product,
            quantity: quantity,
            cert: cert,
            color: color,
            diamond: diamond,
            build: build,
            buildValue: buildValue,
            colorValue: colorValue,
            certValue: certvalue,
            diamondValue: diamondValue,
          ));
          check=true;
        }
      } else {
        cart.add(Cartt(
          product: product,
          quantity: quantity,
          cert: cert,
          color: color,
          diamond: diamond,
          build: build,
          buildValue: buildValue,
          colorValue: colorValue,
          certValue: certvalue,
          diamondValue: diamondValue,
        ));
        check=true;
      }
    } else {
      index = cart.indexWhere(
          (element) => element.product.styleNumber == product.styleNumber);
      cart[index].build = build;
      cart[index].color = color;
      cart[index].diamond = diamond;
      cart[index].cert = cert;
      cart[index].colorValue = colorValue;
      cart[index].diamondValue = diamondValue;
      cart[index].buildValue = buildValue;
      cart[index].certValue = certvalue;
       cart[index].quantity=quantity;
       check=false;

      notifyListeners();
    }

    final url = 'https://alexa.gemstory.in/cart/add';
if(check)
{
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode({
          "styleNumber": product.styleNumber,
          "diamondQuality": diamond,
          "build": build,
          "certificate": cert,
          "color": color.toUpperCase(),
          "quantity": quantity
        }),
      );

      final responseData = json.decode(response.body);
      print(responseData);
      print(cart);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
}
else{
  try{
    final response=await http.patch(url,headers: {
        'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
          'Content-Type': 'application/json; charset=UTF-8',
    },
        body: json.encode({
         	"id":"5ef0c21003c6261e1c50f8b2",
          "diamondQuality": diamond,
          "build": build,
          "certificate": cert,
          "color": color.toUpperCase(),
          "quantity": quantity
        }),

    );

  }catch(err){
    throw err;
  }





}
  }

  Future<void> getCart({context}) async {
    final url = 'https://alexa.gemstory.in/';

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
         
        },
      );

      final responseData = json.decode(response.body);
      print(responseData);
      print(cart);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

 void buildChange(value,index){
   cart[index].buildValue=value;
   notifyListeners();

 } 
 void colorChange(value,index){
    cart[index].colorValue=value;
   notifyListeners();
   
 } 
 void certChange(value,index){
    cart[index].certValue=value;
   notifyListeners();
   
 } 
 void diamondChange(value,index){
    cart[index].diamondValue=value;
   notifyListeners();
   
 } 
 void decQuantity(index){
   cart[index].quantity=cart[index].quantity-1;
   notifyListeners();
 }
 void incQuantity(index){
    cart[index].quantity=cart[index].quantity+1;
   notifyListeners();

 }
}
