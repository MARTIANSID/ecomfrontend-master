

import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';
class TestimonyClass{
  var rating;
  var totalTestimony;
  List<dynamic> testimonies;
  TestimonyClass({this.rating,this.testimonies,this.totalTestimony});


}

class Testimony with ChangeNotifier{
  TestimonyClass userTestimony;

 final String  url='https://api.nakoda.daxy.in/testimony/';


  Future<void> getTestimony({ context}) async {
 
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      final responseData = json.decode(response.body);
      userTestimony= TestimonyClass(rating:responseData['overallRating'],
    totalTestimony:responseData['totalTestimonies'],
     testimonies :responseData['Testimonies']);
     //array of maps 

  
    } catch (err) {
      throw err;
    }
}
  Future<void> writeTestimony({ rating,comment,context}) async {
 
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
            
        },
        body: {
          "rating": rating.toString(),
          "comment":comment.toString(),
        }
      );

      
      notifyListeners();
     
     //array of maps 

  
    } catch (err) {
      throw err;
    }
}

}