import 'dart:convert';

import 'package:Flutter/providers/pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import 'http_exception.dart';

class User {
  String verified;
  String priced;
  String role;
  String street;
  String city;
  String state;
  String pincode;
  String fullname;
  User(
      {this.verified,
      this.priced,
      this.pincode,
      this.state,
      this.street,
      this.city,
      this.fullname,
      this.role});
}

class UserInfo with ChangeNotifier {
  bool verified;
  bool priced;
  var role;
  var street;
  var city;
  var state;
  var fullname;
  var gst;
  var number;
  var firm;
  var pincode;
  var email;

  final uurl="https://alexa.gemstory.in/";

  Future<dynamic> getuser(context) async {
    try {
      final response = await http.get(uurl+'/user/details',
          headers: {
            'Authorization':
                'Bearer ' + Provider.of<Auth>(context, listen: false).token
          });
      final responseData = json.decode(response.body);
        if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
      print(responseData);
     if(Provider.of<Pagination>(context,listen: false).isVerified) 
     {
      street = responseData['user']['additionalDetails']['address']['street'];
      city = responseData['user']['additionalDetails']['address']['city'];
      state = responseData['user']['additionalDetails']['address']['state'];
      verified = responseData['user']['verified'];
      priced = responseData['user']['priced'];   
      gst = responseData['user']['additionalDetails']['gst'];
      firm = responseData['user']['additionalDetails']['firm'];
      pincode = responseData['user']['additionalDetails']['address']['pincode'];
      priced = responseData['user']['priced'];
      email = responseData['user']['email'];
     }

        fullname = responseData['user']['fullName'];
      number = responseData['user']['number'];

      return responseData;
    } catch (err) {
      throw err;
    }
  }

  Future<dynamic> patchuser(
      {context, fullname, gst, firm, city, street, pincode, state}) async {
    try {
      final response = await http.patch(
        uurl+'/user',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
          "Content-Type": "application/json"
        },
        body: json.encode({
          "fullName": fullname,
          "gst": gst,
          "firm": firm,
          "city": city,
          "street": street,
          "pincode": pincode,
          "state": state,
        }),
      );
      final responseData = json.decode(response.body);
        if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
      return responseData;
      
    } catch (err) {
      throw err;
    }
  }

  Future<dynamic> completeSignUp(
      {context, fullname, gst, firm, city, street, pincode, state, reference, email}) async {
    try {
      final response = await http.post(
        uurl+'/user/completesignup',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
          "Content-Type": "application/json"
        },
        body: json.encode({
          "fullName": fullname,
          "gst": gst,
          "firm": firm,
          "city": city,
          "street": street,
          "pincode": pincode,
          "state": state,
          "reference": reference,
          "email": email,
        }),
      );
      final responseData = json.decode(response.body);
        if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
      await storeDate(DateTime.now().toString());

      return responseData;
    } catch (err) {
      throw err;
    }
  }
  Future<String> getDate()async{
     SharedPreferences cc = await SharedPreferences.getInstance();
      return cc.getString('date');




  }

  Future<void> storeDate(date)async{
    SharedPreferences cc = await SharedPreferences.getInstance();
    cc.setString('date', date);
   
    notifyListeners();


  }
    Future<String> getPriceDate()async{
     SharedPreferences  cc= await SharedPreferences.getInstance();
      return cc.getString('priceDate');




  }

  Future<void> storePricDate(date)async{
    SharedPreferences cc = await SharedPreferences.getInstance();
     cc.setString('priceDate', date);
   
    notifyListeners();


  }
  

  

}
