import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth.dart';

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
  String role;
  String street;
  String city;
  String state;
  String fullname;
  String gst;
  int number;
  String firm;
  String pincode;

  Future<dynamic> getuser(context) async {
    try {
      final response = await http.get('https://api.nakoda.daxy.in/user/details',
          headers: {
            'Authorization':
                'Bearer ' + Provider.of<Auth>(context, listen: false).token
          });
      final responseData = json.decode(response.body);
      print(responseData);

      street = responseData['user']['additionalDetails']['address']['street'];
      city = responseData['user']['additionalDetails']['address']['city'];
      state = responseData['user']['additionalDetails']['address']['state'];
      verified = responseData['user']['verified'];
      priced = responseData['user']['priced'];
      fullname = responseData['user']['fullName'];
      number = responseData['user']['number'];
      gst = responseData['user']['additionalDetails']['gst'];
      firm = responseData['user']['additionalDetails']['firm'];
      pincode = responseData['user']['additionalDetails']['address']['pincode'];
      priced = responseData['user']['priced'];

      return responseData;
    } catch (err) {
      throw err;
    }
  }

  Future<dynamic> patchuser(
      {context, fullname, gst, firm, city, street, pincode, state}) async {
    try {
      final response = await http.patch(
        'https://api.nakoda.daxy.in/user',
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
          "state": state
        }),
      );
      final responseData = json.decode(response.body);
      return responseData;
    } catch (err) {
      throw err;
    }
  }
}
