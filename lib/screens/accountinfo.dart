import 'package:Flutter/components/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountInfo extends StatefulWidget {
  final data;

  const AccountInfo({Key key, this.data}) : super(key: key);
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  String fullName;
  String phoneNumber;
  String emailID;
  String firmDetail;
  String gstValue;
  String streetName;
  String cityName;
  String stateName;
  String pincode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    return Scaffold(
      body: Container(
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/Vector4.png",
                width: ScreenUtil().setWidth(143.85),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/Vector6.png",
                width: ScreenUtil().setWidth(164.4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 30.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: FadeInDownBig(
                        child: Text(
                          "Account Info",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy Black',
                            letterSpacing: 1.0,
                            fontSize: ScreenUtil()
                                .setSp(40, allowFontScalingSelf: true),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(25)),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: ScreenUtil().setHeight(325),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white.withOpacity(0.9),
                            ),
                            padding: EdgeInsets.all(25.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FadeInDownBig(
                                  child: Text(
                                    "Personal Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy Black',
                                      letterSpacing: 1.0,
                                      color: Colors.black,
                                      fontSize: ScreenUtil().setSp(20,
                                          allowFontScalingSelf: true),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(7.75),
                                ),
                                FadeInDownBig(
                                  child: RoundedInputField(
                                    hintText: "Full Name",
                                    // onChanged: (value) {

                                    // },
                                    onSubmitted: (value) {
                                      setState(() {
                                        fullName = value;
                                        print(fullName);
                                      });
                                    },
                                    icon: Icons.person,
                                    proceed: false,
                                  ),
                                ),
                                FadeInDown(
                                  child: RoundedInputField(
                                    hintText: "Enter Phone Number",
                                    onSubmitted: (value) {
                                      setState(() {
                                        phoneNumber = value;
                                        print(phoneNumber);
                                      });
                                    },
                                    // icon: Icons.person,
                                    proceed: false,
                                  ),
                                ),
                                FadeInDown(
                                  child: RoundedInputField(
                                    hintText: "Email-id",
                                    onSubmitted: (value) {
                                      setState(() {
                                        emailID = value;
                                        print(emailID);
                                      });
                                    },
                                    icon: Icons.mail,
                                    proceed: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Container(
                            height: ScreenUtil().setHeight(555),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white.withOpacity(0.9),
                            ),
                            padding: EdgeInsets.all(25.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FadeInDownBig(
                                  child: Text(
                                    "Firm Details!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy Black',
                                      letterSpacing: 1.0,
                                      color: Colors.black,
                                      fontSize: ScreenUtil().setSp(20,allowFontScalingSelf: true),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: ScreenUtil().setHeight(7.75)),
                                FadeInDown(
                                  child: RoundedInputField(
                                    hintText: "Firm Detail",
                                    onSubmitted: (value) {
                                      setState(() {
                                        firmDetail = value;
                                        print(firmDetail);
                                      });
                                    },
                                    icon: Icons.work,
                                    proceed: false,
                                  ),
                                ),
                                FadeInDown(
                                  child: RoundedInputField(
                                    hintText: "GST",
                                    onSubmitted: (value) {
                                      setState(() {
                                        gstValue = value;
                                        print(gstValue);
                                      });
                                    },
                                    icon: Icons.attach_money,
                                    proceed: false,
                                  ),
                                ),
                                FadeInDown(
                                  child: RoundedInputField(
                                    hintText: "Street",
                                    onSubmitted: (value) {
                                      setState(() {
                                        streetName = value;
                                        print(streetName);
                                      });
                                    },
                                    icon: Icons.streetview,
                                    proceed: false,
                                  ),
                                ),
                                FadeInDown(
                                  child: RoundedInputField(
                                    hintText: "City",
                                    onSubmitted: (value) {
                                      setState(() {
                                        print(cityName);
                                        cityName = value;
                                      });
                                    },
                                    icon: Icons.location_city,
                                    proceed: false,
                                  ),
                                ),
                                FadeInDown(
                                  child: RoundedInputField(
                                    hintText: "State",
                                    onSubmitted: (value) {
                                      setState(() {
                                        stateName = value;
                                        print(stateName);
                                      });
                                    },
                                    icon: Icons.location_city,
                                    proceed: false,
                                  ),
                                ),
                                FadeInDown(
                                  child: RoundedInputField(
                                    hintText: "Pincode",
                                    onSubmitted: (value) {
                                      setState(() {
                                        pincode = value;
                                        print(pincode);
                                      });
                                    },
                                    icon: Icons.pin_drop,
                                    proceed: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
