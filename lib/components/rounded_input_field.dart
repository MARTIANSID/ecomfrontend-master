import 'package:Flutter/components/text_field_container.dart';
import 'package:Flutter/constant/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool proceed;
  final Color color;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final Function(String) onSubmitted;
  final Function(String) validator;
  final Function onPressed;
  final String svg;
  final bool svgOrIcon;
  // final GlobalKey<FormState> keyForm;
  const RoundedInputField(
      {Key key,
      this.hintText,
      // this.keyForm,
      this.icon = Icons.phone_android,
      this.color = kPrimaryLightColor,
      this.proceed,
      this.svg,
      this.svgOrIcon = true,
      this.validator,
      this.controller,
      this.onChanged,
      this.onPressed,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    return TextFieldContainer(
      color: color,
      child: Stack(
        children: <Widget>[
          TextFormField(
            validator: validator,
            enabled: proceed ? false : true,
            onChanged: onChanged,
            onSaved: onSubmitted,
            cursorColor: kPrimaryColor,
            style: TextStyle(
              fontFamily: 'Gilroy Regular',
              fontSize: ScreenUtil().setSp(16, allowFontScalingSelf: true),
            ),
            controller: controller,
            keyboardType: hintText == "Enter Phone Number" ||
                    hintText == "Enter OTP" ||
                    hintText == "Enter Commission"
                ? TextInputType.phone
                : TextInputType.text,
            decoration: InputDecoration(
              icon: svgOrIcon
                  ? Icon(
                      icon,
                      color: Colors.black,
                    )
                  : SvgPicture.asset(
                      svg,
                      fit: BoxFit.contain,
                      height: ScreenUtil().setHeight(22),
                      width: ScreenUtil().setWidth(22),
                    ),
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
          // proceed
          //     ? Positioned(
          //         right: 0.0,
          //         bottom: ScreenUtil().setHeight(50.375),
          //         child: Container(
          //           height: ScreenUtil().setHeight(40),
          //           width: ScreenUtil().setWidth(40),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.cyan,
          //           ),
          //           child: IconButton(
          //             icon: Icon(
          //               Icons.edit,
          //               color: Colors.white,
          //             ),
          //             onPressed: onPressed,
          //           ),
          //         ),
          //       )
          //     : SizedBox(
          //         height: 0.0,
          //       )
        ],
      ),
    );
  }
}
