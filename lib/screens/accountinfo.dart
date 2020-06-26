import 'package:Flutter/components/rounded_input_field.dart';
import 'package:Flutter/providers/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailIDController = TextEditingController();
  TextEditingController firmDetailController = TextEditingController();
  TextEditingController gstValueController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController referenceController = TextEditingController();

  bool isLoading = false;

  bool autovalidate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    phoneNumberController.text =
        Provider.of<UserInfo>(context, listen: false).number.toString();
    fullNameController.text =
        Provider.of<UserInfo>(context, listen: false).fullname.toString();
    emailIDController.text =
        Provider.of<UserInfo>(context, listen: false).email.toString();
    firmDetailController.text =
        Provider.of<UserInfo>(context, listen: false).firm.toString();
    gstValueController.text =
        Provider.of<UserInfo>(context, listen: false).gst.toString();
    streetNameController.text =
        Provider.of<UserInfo>(context, listen: false).street.toString();
    cityNameController.text =
        Provider.of<UserInfo>(context, listen: false).city.toString();
    stateNameController.text =
        Provider.of<UserInfo>(context, listen: false).state.toString();
    pincodeController.text =
        Provider.of<UserInfo>(context, listen: false).pincode.toString();
  }

  GlobalKey<FormState> _key = GlobalKey();

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
                      child: Form(
                        key: _key,
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
                                  fontSize: ScreenUtil()
                                      .setSp(20, allowFontScalingSelf: true),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(7.75),
                            ),
                            FadeInDownBig(
                              child: RoundedInputField(
                                controller: fullNameController,
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
                            FadeInDownBig(
                              child: RoundedInputField(
                                controller: phoneNumberController,
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
                            FadeInDownBig(
                              child: RoundedInputField(
                                controller: emailIDController,
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
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            FadeInDownBig(
                              child: Text(
                                "Firm Details!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy Black',
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: ScreenUtil()
                                      .setSp(20, allowFontScalingSelf: true),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(7.75)),
                            FadeInDownBig(
                              child: RoundedInputField(
                                controller: firmDetailController,
                                hintText: "Firm Name",
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
                            FadeInDownBig(
                              child: RoundedInputField(
                                controller: gstValueController,
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
                            FadeInDownBig(
                              child: RoundedInputField(
                                controller: streetNameController,
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
                            FadeInDownBig(
                              child: RoundedInputField(
                                controller: cityNameController,
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
                            FadeInDownBig(
                              child: RoundedInputField(
                                controller: stateNameController,
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
                            FadeInDownBig(
                              child: RoundedInputField(
                                controller: pincodeController,
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
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                          ],
                        ),
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
