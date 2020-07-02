import 'package:Flutter/components/rounded_input_field.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/widgets/snackbar.dart';
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
  bool editFields = false;

  bool autovalidate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
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
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
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
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(35),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              editFields = !editFields;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  editFields ? Icons.cancel : Icons.edit,
                                  color: Colors.black,
                                  size: ScreenUtil()
                                      .setSp(15, allowFontScalingSelf: true),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(8),
                                ),
                                Text(
                                  editFields ? 'Cancel' : 'Edit Account',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy Regular',
                                    fontSize: ScreenUtil()
                                        .setSp(14, allowFontScalingSelf: true),
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
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
                            FadeInDown(
                              child: RoundedInputField(
                                controller: fullNameController,
                                hintText: "Full Name",
                                validator: (value) {
                                  if (value.length < 3) {
                                    return "Name Error";
                                  } else if (value.isEmpty) {
                                    return "Enter Your Name";
                                  }
                                  return null;
                                },
                                // onChanged: (value) {
                                //   fullNameController.text = value;
                                // },
                                onSubmitted: (value) {
                                  setState(() {
                                    fullName = value;
                                    print(fullName);
                                  });
                                },
                                icon: Icons.person,
                                proceed: !editFields,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                controller: phoneNumberController,
                                hintText: "Enter Phone Number",
                                // onChanged: (value) {
                                //   gstValueController.text=value;
                                // },
                                onSubmitted: (value) {
                                  setState(() {
                                    phoneNumber = value;
                                    print(phoneNumber);
                                  });
                                },
                                // icon: Icons.person,
                                proceed: true,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                controller: emailIDController,
                                hintText: "Email-id",
                                // onChanged: (value) {
                                //   gstValueController.text=value;
                                // },
                                onSubmitted: (value) {
                                  setState(() {
                                    emailID = value;
                                    print(emailID);
                                  });
                                },
                                icon: Icons.mail,
                                proceed: true,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            FadeInDown(
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
                            FadeInDown(
                              child: RoundedInputField(
                                controller: firmDetailController,
                                hintText: "Firm Name",
                                onSubmitted: (value) {
                                  setState(() {
                                    firmDetail = value;
                                    print(firmDetail);
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter Firm Name";
                                  }
                                  return null;
                                },
                                icon: Icons.work,
                                proceed: !editFields,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                controller: gstValueController,
                                hintText: "GST",
                                onSubmitted: (value) {
                                  setState(() {
                                    gstValue = value;
                                    print(gstValue);
                                  });
                                },
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
                                icon: Icons.attach_money,
                                proceed: !editFields,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                controller: streetNameController,
                                hintText: "Street",
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
                                icon: Icons.streetview,
                                proceed: !editFields,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                controller: cityNameController,
                                hintText: "City",
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter City Name";
                                  }
                                  return null;
                                },
                                // onChanged: (value) {
                                //   cityNameController.text = value;
                                // },
                                onSubmitted: (value) {
                                  setState(() {
                                    cityName = value;
                                    print(cityName);
                                  });
                                },
                                icon: Icons.location_city,
                                proceed: !editFields,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                controller: stateNameController,
                                hintText: "State",
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter State Name";
                                  }
                                  return null;
                                },
                                // onChanged: (value) {
                                //   stateNameController.text = value;
                                // },
                                onSubmitted: (value) {
                                  setState(() {
                                    stateName = value;
                                    print(stateName);
                                  });
                                },
                                icon: Icons.location_city,
                                proceed: !editFields,
                              ),
                            ),
                            FadeInDown(
                              child: RoundedInputField(
                                controller: pincodeController,
                                hintText: "Pincode",
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter Pincode";
                                  } else if (value.length != 6) {
                                    return "Enter Proper Pincode";
                                  }
                                  return null;
                                },
                                // onChanged: (value) {
                                //   pincodeController.text = value;
                                // },
                                onSubmitted: (value) {
                                  setState(() {
                                    pincode = value;
                                    print(pincode);
                                  });
                                },
                                icon: Icons.pin_drop,
                                proceed: !editFields,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(50),
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
      floatingActionButton: editFields
          ? Container(
              width: ScreenUtil().setWidth(120.0),
              height: ScreenUtil().setHeight(50.0),
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
              padding: EdgeInsets.all(5.0),
              child: Material(
                type: MaterialType.transparency,
                elevation: 6.0,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  splashColor: Colors.cyan[50],
                  borderRadius: BorderRadius.circular(20),
                  onTap: () async {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await Provider.of<UserInfo>(context, listen: false)
                            .patchuser(
                          context: context,
                          fullname: fullName,
                          city: cityName,
                          firm: firmDetail,
                          gst: gstValue,
                          pincode: pincode,
                          state: stateName,
                          street: streetName,
                        );
                        await Provider.of<UserInfo>(context, listen: false)
                            .getuser(context);
                      } catch (err) {
                        throw err;
                        // dataSelect(context, 'Alert!', '$err', 'OK', () {
                        //   Navigator.pop(context);
                        // });
                      } finally {
                        setState(() {
                          isLoading = false;
                          editFields = false;
                        });
                      }
                      // Navigator.of(context).pop();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.done_outline,
                        color: Colors.white,
                        size:
                            ScreenUtil().setSp(23, allowFontScalingSelf: true),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(10),
                      ),
                      Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'Gilroy Medium',
                          fontSize: ScreenUtil()
                              .setSp(15, allowFontScalingSelf: true),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SizedBox(
              height: 0.0,
              width: 0.0,
            ),
    );
  }
}
