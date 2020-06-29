import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionsDialog extends StatefulWidget {
  final int defValue;
  final int defValue1;
  final int defValue2;
  final int defValue3;
  final choicesBuild;
  final choiceColor;
  final choiceCertification;
  final choiceDiamondQuality;
  final void Function(int) valueChangeBuild;
  final void Function(int) valueChangeColor;
  final void Function(int) valueChangeCerti;
  final void Function(int) valueChangeDQ;

  const OptionsDialog(
      {Key key,
      this.defValue,
      this.defValue1,
      this.defValue2,
      this.defValue3,
      this.choicesBuild,
      this.choiceColor,
      this.choiceCertification,
      this.choiceDiamondQuality,
      this.valueChangeBuild,
      this.valueChangeColor,
      this.valueChangeCerti,
      this.valueChangeDQ})
      : super(key: key);

  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  int _defaultChoiceIndex;
  int _defaultChoiceIndex1;
  int _defaultChoiceIndex2;
  int _defaultChoiceIndex3;

  @override
  void initState() {
    super.initState();
    _defaultChoiceIndex = widget.defValue;
    _defaultChoiceIndex1 = widget.defValue1;
    _defaultChoiceIndex2 = widget.defValue2;
    _defaultChoiceIndex3 = widget.defValue3;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF34B0D9).withOpacity(0.2),
              Color(0xFF3685CB).withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          contentPadding: EdgeInsets.all(14.0),
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(525),
              width: ScreenUtil().setWidth(400),
              // width: 700.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(19),
                  ),
                  Center(
                    child: Text(
                      "Options",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gilroy Medium',
                        fontSize:
                            ScreenUtil().setSp(24, allowFontScalingSelf: true),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(19),
                  ),
                  Text(
                    'Color',
                    style: TextStyle(
                      fontFamily: 'Gilroy Medium',
                      fontSize: ScreenUtil().setSp(18),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 7.0,
                    children: List<Widget>.generate(widget.choiceColor.length,
                        (int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _defaultChoiceIndex1 = index;
                          });
                          widget.valueChangeColor(index);
                        },
                        child: Container(
                          // margin: EdgeInsets.only(right: 6.0),
                          height: ScreenUtil().setHeight(30),
                          width: ScreenUtil().setWidth(90),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(
                            //   color: Colors.black,
                            //   width: 1.0,
                            // ),
                            gradient: _defaultChoiceIndex1 != index
                                ? LinearGradient(
                                    colors: [
                                      Colors.black,
                                      Colors.black,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : LinearGradient(
                                    colors: [
                                      Color(0xFF34B0D9),
                                      Color(0xFF3685CB),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: _defaultChoiceIndex1 != index
                                    ? Colors.white
                                    : Color(0xFFD9EEF7),
                              ),
                              child: Center(
                                child: ShaderMask(
                                  shaderCallback: (bounds) =>
                                      _defaultChoiceIndex1 == index
                                          ? LinearGradient(
                                              colors: [
                                                Color(0xFF34B0D9),
                                                Color(0xFF3685CB),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ).createShader(
                                              Rect.fromLTWH(0, 0, bounds.width,
                                                  bounds.height),
                                            )
                                          : LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.black,
                                              ],
                                            ).createShader(
                                              Rect.fromLTWH(0, 0, bounds.width,
                                                  bounds.height),
                                            ),
                                  child: Text(
                                    widget.choiceColor[index],
                                    style: TextStyle(
                                        color: _defaultChoiceIndex1 == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily:
                                            _defaultChoiceIndex1 == index
                                                ? 'Gilroy Medium'
                                                : 'Gilroy Light'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(19),
                  ),
                  Text(
                    'Build',
                    style: TextStyle(
                      fontFamily: 'Gilroy Medium',
                      fontSize: ScreenUtil().setSp(18),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 7.0,
                    children: List<Widget>.generate(widget.choicesBuild.length,
                        (int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _defaultChoiceIndex = index;
                          });
                          widget.valueChangeBuild(index);
                        },
                        child: Container(
                          // margin: EdgeInsets.only(right: 6.0),
                          height: ScreenUtil().setHeight(30),
                          width: ScreenUtil().setWidth(90),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(
                            //   color: Colors.black,
                            //   width: 1.0,
                            // ),
                            gradient: _defaultChoiceIndex != index
                                ? LinearGradient(
                                    colors: [
                                      Colors.black,
                                      Colors.black,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : LinearGradient(
                                    colors: [
                                      Color(0xFF34B0D9),
                                      Color(0xFF3685CB),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: _defaultChoiceIndex != index
                                    ? Colors.white
                                    : Color(0xFFD9EEF7),
                              ),
                              child: Center(
                                child: ShaderMask(
                                  shaderCallback: (bounds) =>
                                      _defaultChoiceIndex == index
                                          ? LinearGradient(
                                              colors: [
                                                Color(0xFF34B0D9),
                                                Color(0xFF3685CB),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ).createShader(
                                              Rect.fromLTWH(0, 0, bounds.width,
                                                  bounds.height),
                                            )
                                          : LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.black,
                                              ],
                                            ).createShader(
                                              Rect.fromLTWH(0, 0, bounds.width,
                                                  bounds.height),
                                            ),
                                  child: Text(
                                    widget.choicesBuild[index],
                                    style: TextStyle(
                                        color: _defaultChoiceIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily: _defaultChoiceIndex == index
                                            ? 'Gilroy Medium'
                                            : 'Gilroy Light'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(19),
                  ),
                  Text(
                    'Certification',
                    style: TextStyle(
                      fontFamily: 'Gilroy Medium',
                      fontSize: ScreenUtil().setSp(18),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 7.0,
                    children: List<Widget>.generate(
                        widget.choiceCertification.length, (int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _defaultChoiceIndex2 = index;
                          });
                          widget.valueChangeCerti(index);
                        },
                        child: Container(
                          // margin: EdgeInsets.only(right: 6.0),
                          height: ScreenUtil().setHeight(30),
                          width: ScreenUtil().setWidth(90),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(
                            //   color: Colors.black,
                            //   width: 1.0,
                            // ),
                            gradient: _defaultChoiceIndex2 != index
                                ? LinearGradient(
                                    colors: [
                                      Colors.black,
                                      Colors.black,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : LinearGradient(
                                    colors: [
                                      Color(0xFF34B0D9),
                                      Color(0xFF3685CB),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: _defaultChoiceIndex2 != index
                                    ? Colors.white
                                    : Color(0xFFD9EEF7),
                              ),
                              child: Center(
                                child: ShaderMask(
                                  shaderCallback: (bounds) =>
                                      _defaultChoiceIndex2 == index
                                          ? LinearGradient(
                                              colors: [
                                                Color(0xFF34B0D9),
                                                Color(0xFF3685CB),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ).createShader(
                                              Rect.fromLTWH(0, 0, bounds.width,
                                                  bounds.height),
                                            )
                                          : LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.black,
                                              ],
                                            ).createShader(
                                              Rect.fromLTWH(0, 0, bounds.width,
                                                  bounds.height),
                                            ),
                                  child: Text(
                                    widget.choiceCertification[index],
                                    style: TextStyle(
                                        color: _defaultChoiceIndex2 == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily:
                                            _defaultChoiceIndex2 == index
                                                ? 'Gilroy Medium'
                                                : 'Gilroy Light'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(19),
                  ),
                  Text(
                    'Diamond Quality',
                    style: TextStyle(
                      fontFamily: 'Gilroy Medium',
                      fontSize: ScreenUtil().setSp(18),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 7.0,
                    children: List<Widget>.generate(
                        widget.choiceDiamondQuality.length, (int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _defaultChoiceIndex3 = index;
                          });
                          widget.valueChangeDQ(index);
                        },
                        child: Container(
                          // margin: EdgeInsets.only(right: 6.0),
                          height: ScreenUtil().setHeight(30),
                          width: ScreenUtil().setWidth(90),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(
                            //   color: Colors.black,
                            //   width: 1.0,
                            // ),
                            gradient: _defaultChoiceIndex3 != index
                                ? LinearGradient(
                                    colors: [
                                      Colors.black,
                                      Colors.black,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : LinearGradient(
                                    colors: [
                                      Color(0xFF34B0D9),
                                      Color(0xFF3685CB),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: _defaultChoiceIndex3 != index
                                    ? Colors.white
                                    : Color(0xFFD9EEF7),
                              ),
                              child: Center(
                                child: ShaderMask(
                                  shaderCallback: (bounds) =>
                                      _defaultChoiceIndex3 == index
                                          ? LinearGradient(
                                              colors: [
                                                Color(0xFF34B0D9),
                                                Color(0xFF3685CB),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ).createShader(
                                              Rect.fromLTWH(0, 0, bounds.width,
                                                  bounds.height),
                                            )
                                          : LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.black,
                                              ],
                                            ).createShader(
                                              Rect.fromLTWH(0, 0, bounds.width,
                                                  bounds.height),
                                            ),
                                  child: Text(
                                    widget.choiceDiamondQuality[index],
                                    style: TextStyle(
                                        color: _defaultChoiceIndex3 == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily:
                                            _defaultChoiceIndex3 == index
                                                ? 'Gilroy Medium'
                                                : 'Gilroy Light'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: ScreenUtil().setWidth(180),
                        height: ScreenUtil().setHeight(43),
                        // padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            'DONE',
                            style: TextStyle(
                              fontFamily: 'Gilroy Bold',
                              color: Colors.white,
                              fontSize: ScreenUtil()
                                  .setSp(18, allowFontScalingSelf: true),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/vector17.png'),
                          fit: BoxFit.contain,
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
