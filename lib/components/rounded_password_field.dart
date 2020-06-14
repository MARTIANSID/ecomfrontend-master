import 'package:Flutter/components/text_field_container.dart';
import 'package:Flutter/constant/const.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: show ? false : true,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        style: TextStyle(
          // fontFamily: 'Varela',
          // fontSize: 16.0,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          hintStyle: TextStyle(fontFamily: 'Varela'),
          suffixIcon: GestureDetector(
            child: show ? Icon(
              Icons.visibility,
              color: kPrimaryColor,
            ) : Icon(
              Icons.visibility_off,
              color: kPrimaryColor,
            ),
            onTap: () {
              setState(() {
                show = !show;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
