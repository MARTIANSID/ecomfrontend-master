import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        color: Color(0xFFFCFAF8),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [
        //       //Color(0xFFD06AA9),
        //       Color(0xFF73AEF5),
        //       Color(0xFF61A4F1),
        //       Color(0xFF478DE0),
        //       Color(0xFF398AE5),
        //     ],
        //     stops: [0.1, 0.4, 0.7, 0.9],
        //   ),
        // ),
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
