import 'package:Flutter/components/text_field_container.dart';
import 'package:Flutter/constant/const.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool proceed;
  final Color color;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final Function(String) onSubmitted;
  final Function onPressed;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.phone_android,
    this.color = kPrimaryLightColor,
    this.proceed,
    this.controller,
    this.onChanged,
    this.onPressed,
    this.onSubmitted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: color,
      child: Stack(
        children: <Widget>[
          TextField(
            enabled: proceed ? false : true,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            cursorColor: kPrimaryColor,
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 16.0,
            ),
            controller: controller,
            keyboardType: hintText == "Enter Phone Number" ||
                    hintText == "Enter OTP" ||
                    hintText == "Enter Commission"
                ? TextInputType.phone
                : TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(
                icon,
                color: Colors.black,
              ),
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
          proceed
              ? Positioned(
                  right: 0.0,
                  bottom: MediaQuery.of(context).size.height*0.0065,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.051,
                    width: MediaQuery.of(context).size.width*0.097,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.cyan,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: onPressed,
                    ),
                  ),
                )
              : SizedBox(
                  height: 0.0,
                )
        ],
      ),
    );
  }
}