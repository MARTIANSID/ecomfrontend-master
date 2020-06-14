import 'package:Flutter/components/text_field_container_name.dart';
import 'package:Flutter/constant/const.dart';
import 'package:flutter/material.dart';

class RoundedInputFieldName extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputFieldName({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainerName(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        keyboardType: TextInputType.text,
        style: TextStyle(
          fontFamily: 'Varela',
          // fontSize: 16.0,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontFamily: 'Varela'),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
