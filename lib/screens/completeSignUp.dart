import 'package:Flutter/components/rounded_input_field.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompleteSignUp extends StatefulWidget {
  @override
  _CompleteSignUpState createState() => _CompleteSignUpState();
}

class _CompleteSignUpState extends State<CompleteSignUp> {
  String fullName;
  String phoneNumber;
  String emailID;
  String firmDetail;
  String gstValue;
  String streetName;
  String cityName;
  String stateName;
  String pincode;
  String reference;

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

  bool isButtonLoading = false;

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
        Provider.of<UserInfo>(context, listen: false).fullname;
  }

  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 411.42857142857144,
      height: 774.8571428571429,
      allowFontScaling: true,
    );
    return Scaffold(
      body: Container(
        height: ScreenUtil().setHeight(775),
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: FadeInDown(
                        child: Text(
                          "Complete Sign-Up",
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy Bold',
                            letterSpacing: 1.0,
                            fontSize: ScreenUtil()
                                .setSp(34, allowFontScalingSelf: true),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(40)),
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
                            FadeInDown(
                              child: Text(
                                "Personal Details",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy Medium',
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
                            FadeInDown(
                              child: RoundedInputField(
                                hintText: "Full Name",
                                controller: fullNameController,
                                // onChanged: (value) {

                                // },
                                onSubmitted: (value) {
                                  setState(() {
                                    fullName = value;
                                    print(fullName);
                                  });
                                },
                                validator: (value) {
                                  if (value.length < 3) {
                                    return "Name Error";
                                  } else if (value.isEmpty) {
                                    return "Enter Your Name";
                                  }
                                  return null;
                                },
                                icon: Icons.person_outline,
                                proceed: false,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                hintText: "Enter Phone Number",
                                controller: phoneNumberController,
                                proceed: true,
                                onSubmitted: (value) {
                                  setState(() {
                                    phoneNumber = value;
                                    print(phoneNumber);
                                  });
                                },
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                hintText: "Email-id",
                                validator: (value) {
                                  if (!RegExp(
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                      .hasMatch(value)) {
                                    return "Check your Email-ID";
                                  } else if (value.isEmpty) {
                                    return "Enter Email-ID";
                                  }
                                  return null;
                                },
                                controller: emailIDController,
                                onSubmitted: (value) {
                                  setState(() {
                                    emailID = value;
                                    print(emailID);
                                  });
                                },
                                icon: Icons.mail_outline,
                                proceed: false,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                hintText: "Reference",
                                controller: referenceController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter Reference";
                                  }
                                  return null;
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    reference = value;
                                    print(reference);
                                  });
                                },
                                icon: Icons.people_outline,
                                proceed: false,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            FadeInDown(
                              child: Text(
                                "Firm Details",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy Medium',
                                  letterSpacing: 1.0,
                                  color: Colors.black,
                                  fontSize: ScreenUtil()
                                      .setSp(20, allowFontScalingSelf: true),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(7.75)),
                            FadeInDown(
                              child: RoundedInputField(
                                hintText: "Firm Name",
                                controller: firmDetailController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter Firm Name";
                                  }
                                  return null;
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    firmDetail = value;
                                    print(firmDetail);
                                  });
                                },
                                svgOrIcon: false,
                                svg: "assets/icons/workOutline.svg",
                                proceed: false,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                hintText: "GST (OPTIONAL)",
                                validator: (value) {
                                  if (value.isNotEmpty) {
                                    if (!RegExp(
                                            r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$')
                                        .hasMatch(value)) {
                                      return "Enter Correct GST Value";
                                    }
                                  }
                                  return null;
                                },
                                controller: gstValueController,
                                onSubmitted: (value) {
                                  setState(() {
                                    gstValue = value;
                                    print(gstValue);
                                  });
                                },
                                svgOrIcon: false,
                                svg: "assets/icons/taxes.svg",
                                proceed: false,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                hintText: "Street",
                                controller: streetNameController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter Street Name";
                                  }
                                  return null;
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    streetName = value;
                                    print(streetName);
                                  });
                                },
                                svgOrIcon: false,
                                svg: "assets/icons/streetView.svg",
                                proceed: false,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                hintText: "City",
                                controller: cityNameController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter City Name";
                                  }
                                  return null;
                                },
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter State Name";
                                  }
                                  return null;
                                },
                                controller: stateNameController,
                                onSubmitted: (value) {
                                  setState(() {
                                    stateName = value;
                                    print(stateName);
                                  });
                                },
                                svg: "assets/icons/realEstate.svg",
                                svgOrIcon: false,
                                proceed: false,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                hintText: "Pincode",
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter Pincode";
                                  } else if (value.length != 6) {
                                    return "Enter Proper Pincode";
                                  }
                                  return null;
                                },
                                controller: pincodeController,
                                onSubmitted: (value) {
                                  setState(() {
                                    pincode = value;
                                    print(pincode);
                                  });
                                },
                                icon: Icons.person_pin,
                                proceed: false,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            // Container(
                            //   height: ScreenUtil().setHeight(555),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(20.0),
                            //     color: Colors.white.withOpacity(0.9),
                            //   ),
                            //   padding: EdgeInsets.all(25.0),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: <Widget>[],
                            //   ),
                            // ),
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
      floatingActionButton: isButtonLoading
          ? Container(
              width: ScreenUtil().setWidth(120.0),
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage('assets/images/vector17.png'),
                //   fit: BoxFit.contain,
                // ),
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF34B0E9),
                    Color(0xFF3685CB),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.all(15.0),
              child: Center(child: CircularProgressIndicator()))
          : GestureDetector(
              onTap: () async {
                if (_key.currentState.validate()) {
                  _key.currentState.save();
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    setState(() {
                      isButtonLoading = true;
                    });
                    await Provider.of<UserInfo>(context, listen: false)
                        .completeSignUp(
                      context: context,
                      fullname: fullName,
                      email: emailID,
                      city: cityName,
                      firm: firmDetail,
                      gst: gstValue,
                      pincode: pincode,
                      reference: reference,
                      state: stateName,
                      street: streetName,
                    );
                  } catch (err) {
                    dataSelect(context, 'Alert!', '$err', 'OK', () {
                      Navigator.pop(context);
                    });
                  } finally {
                    setState(() {
                      isButtonLoading = false;
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                  }
                }
              },
              child: Container(
                width: ScreenUtil().setWidth(120.0),
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage('assets/images/vector17.png'),
                  //   fit: BoxFit.contain,
                  // ),
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF34B0E9),
                      Color(0xFF3685CB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.done_outline,
                      color: Colors.white,
                      size: ScreenUtil().setSp(23, allowFontScalingSelf: true),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Text(
                      'Submit',
                      style: TextStyle(
                        fontFamily: 'Gilroy Medium',
                        fontSize:
                            ScreenUtil().setSp(15, allowFontScalingSelf: true),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
