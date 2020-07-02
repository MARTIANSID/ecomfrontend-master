import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth.dart';
import 'http_exception.dart';
class Order{

}

class Orders with ChangeNotifier{
  Future<void> getOrders({context}) async{
    
  try {
      final response = await http.get(
        '',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      final responseData=json.decode(response.body);


    } on SocketException {
      throw 'No Internet';
      
    } 
    catch (err) {
      throw err;
    }
  }
  
  
}
