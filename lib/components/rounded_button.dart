import 'package:Flutter/constant/const.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final double textSize;
  final Function press;
  final bool isLoading;
  final Widget child;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.child,
    this.isLoading,
    this.color = kPrimaryLightColor,
    this.textColor = Colors.white,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: 5),
      // width: size.width * 0.8,
      height: size.height*0.07,
      width: size.width*0.13,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kPrimaryColor,
      ),
      child: isLoading ? child : IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        color: color,
        onPressed: press,
        // child: isLoading ? child : Text(
        //   text,
        //   style: TextStyle(color: textColor, fontSize: textSize,fontFamily: 'Varela'),
        // ),
      ),
    );
  }
}
