import 'package:Flutter/providers/auth.dart';
import 'package:Flutter/screens/home.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool isVerifyLoading = false;
  GlobalKey<FormState> _key = GlobalKey();

  dispose() {
    _passwordController.dispose();
    _phoneController.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 600,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, -.7),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
    _slideAnimation2 = Tween<Offset>(
      begin: Offset(0.0, 0.7),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    // _heightAnimation.addListener(() => setState(() {}));
  }

  bool _requirePassword = false;
  bool _buildForgetButton = false;
  bool _isRegistered = false;
  bool _showSignup = false;
  bool _rememberMe = true;
  bool _showPassword = false;
  bool _showPasswordCheckBox = false;
  bool _forgotPasswordMenu = false;
  bool timeUpFlag = false;
  bool enable = true;
  String phoneNumber;
  String timeText = "0s";
  int timeCounter = 0;

  final _phoneController = TextEditingController();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<Offset> _slideAnimation2;
  Animation<double> _opacityAnimation;

  Widget _buildGivenTF({
    @required String name,
    @required String hint,
    @required TextEditingController controller,
    @required TextInputType inputType,
    @required IconData icon,
    @required void Function(String) validate,
    bool enable,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: kLabelStyle,
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          // height: ScreenUtil().setHeight(60),
          child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              TextFormField(
                enabled: enable,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                // maxLength: 10,
                enableSuggestions: false,
                maxLengthEnforced: false,
                validator: validate,
                controller: controller,
                keyboardType: inputType,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy Regular',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0, left: 15.0),
                  prefixIcon: Icon(
                    icon,
                    color: Colors.white,
                  ),
                  // suffixIcon: !enable
                  //     ? IconButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             enable = true;
                  //             _phoneController.clear();
                  //             _nameController.clear();
                  //             _passwordController.clear();
                  //             _requirePassword = false;
                  //             _buildForgetButton = false;
                  //             _isRegistered = false;
                  //             _showSignup = false;
                  // _rememberMe = false;
                  //             _showPassword = false;
                  //             _showPasswordCheckBox = false;
                  //             _forgotPasswordMenu = false;
                  //             _screen = 0;
                  //           });
                  //         },
                  //         icon: Icon(
                  //           Icons.edit,
                  //           color: Colors.white,
                  //         ),
                  //       )
                  //     : SizedBox(height: 0.0),
                  hintText: hint,
                  hintStyle: kHintTextStyle,
                ),
              ),
              !this.enable
                  ? _forgotPasswordMenu == false
                      ? IconButton(
                          onPressed: () {
                            if (mounted)
                              setState(() {
                                this.enable = true;
                                enable = true;
                                _phoneController.clear();
                                _fnameController.clear();
                                _lnameController.clear();
                                _passwordController.clear();
                                _requirePassword = false;
                                _buildForgetButton = false;
                                _isRegistered = false;
                                _showSignup = false;
                                // _rememberMe = false;
                                _showPassword = false;
                                _showPasswordCheckBox = false;
                                _forgotPasswordMenu = false;
                                _screen = 0;
                              });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )
                      : SizedBox(height: 0.0)
                  : SizedBox(
                      height: 0.0,
                    ),
            ],
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
      ],
    );
  }

  Widget _buildGivenNameTF({
    @required String name,
    @required String hint,
    @required TextEditingController controller,
    @required TextInputType inputType,
    @required IconData icon,
    @required void Function(String) validate,
    bool enable,
  }) {
    return Container(
      width: ScreenUtil().setWidth(160),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: kLabelStyle,
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            // height: ScreenUtil().setHeight(60),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextFormField(
                  enabled: enable,
                  validator: validate,
                  controller: controller,
                  keyboardType: inputType,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Gilroy Regular',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0, left: 15.0),
                    prefixIcon: Icon(
                      icon,
                      color: Colors.white,
                    ),
                    // suffixIcon: !enable
                    //     ? IconButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             enable = true;
                    //             _phoneController.clear();
                    //             _nameController.clear();
                    //             _passwordController.clear();
                    //             _requirePassword = false;
                    //             _buildForgetButton = false;
                    //             _isRegistered = false;
                    //             _showSignup = false;
                    // _rememberMe = false;
                    //             _showPassword = false;
                    //             _showPasswordCheckBox = false;
                    //             _forgotPasswordMenu = false;
                    //             _screen = 0;
                    //           });
                    //         },
                    //         icon: Icon(
                    //           Icons.edit,
                    //           color: Colors.white,
                    //         ),
                    //       )
                    //     : SizedBox(height: 0.0),
                    hintText: hint,
                    hintStyle: kHintTextStyle,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          // height: ScreenUtil().setHeight(60),
          child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter Password";
                  } else if (value.length < 6) {
                    return "Atleast 6 Characters Required!";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: _passwordController,
                obscureText: _showPassword ? false : true,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy Regular',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0, left: 15.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: _forgotPasswordMenu
                      ? 'Enter New Password'
                      : 'Enter your Password',
                  hintStyle: kHintTextStyle,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (mounted)
                    setState(() {
                      // enable = true;
                      // _phoneController.clear();
                      // _nameController.clear();
                      // _passwordController.clear();
                      // _requirePassword = false;
                      // _buildForgetButton = false;
                      // _isRegistered = false;
                      // _showSignup = false;
                      // _rememberMe = false;
                      _showPassword = !_showPassword;
                      // _showPasswordCheckBox = false;
                      // _forgotPasswordMenu = false;
                      // _screen = 0;
                    });
                },
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: _forgotPassword,
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _resendMessageBtn() {
    // return ArgonTimerButton(
    //   initialTimer: 60,
    //   splashColor: null,
    //   color: null,
    //   roundLoadingShape: false,
    //   colorBrightness: null,
    //   height: ScreenUtil().setSp(25, allowFontScalingSelf: true),
    //   width: 0.5,
    //   child: Container(
    //     alignment: Alignment.centerRight,
    //     child: Padding(
    //       padding: EdgeInsets.only(right: 0.0),
    //       child: Text(
    //         'Resend Otp',
    //         style: kLabelStyle,
    //       ),
    //     ),
    //   ),
    //   loader: (timeLeft) {
    //     return Text("Wait | $timeLeft", style: kLabelStyle);
    //   },
    //   onTap: (startTimer, btnState) async {
    //     if (btnState == ButtonState.Idle) {
    //       try {
    //         await Provider.of<Auth>(context, listen: false)
    //             .resendOtp(phoneNumber);

    //         startTimer(60);
    //       } catch (error) {
    //         _showDilog('Oops!', '$error');
    //       }
    //     }
    //   },
    // );
    return ArgonTimerButton(
      height: ScreenUtil().setSp(25, allowFontScalingSelf: true),
      width: ScreenUtil().setWidth(100),
      minWidth: MediaQuery.of(context).size.width * 0.30,
      highlightColor: Colors.transparent,
      highlightElevation: 0,
      roundLoadingShape: false,
      splashColor: Colors.transparent,
      onTap: (startTimer, btnState) async {
        if (btnState == ButtonState.Idle) {
          try {
            await Provider.of<Auth>(context, listen: false)
                .resendOtp(phoneNumber);

            startTimer(60);
          } catch (error) {
            _showDilog('Oops!', '$error');
          }
        }
      },
      // initialTimer: 10,
      child: Text(
        "Resend OTP",
        style: kLabelStyle,
      ),
      loader: (timeLeft) {
        return Text(
          "Please Wait| $timeLeft",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        );
      },
      borderRadius: 5.0,
      color: Colors.transparent,
      elevation: 0,
    );
  }

  _showDilog(String title, String content) {
    // print('PP in showDilog');
    if (context != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Try Again?',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            FlatButton(
              onPressed: () => setState(() {
                enable = true;
                _phoneController.clear();
                _fnameController.clear();
                _lnameController.clear();
                _passwordController.clear();
                Navigator.of(context).pop();
                _requirePassword = false;
                _buildForgetButton = false;
                _isRegistered = false;
                _showSignup = false;
                // _rememberMe = false;
                _showPassword = false;
                _showPasswordCheckBox = false;
                _forgotPasswordMenu = false;
                _screen = 0;
              }),
              child: Text(
                'Change Number?',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  Future<void> _forgotPassword() async {
    try {
      final a = await Provider.of<Auth>(context, listen: false)
          .resetPasswordRequest(_phoneController.text.trim());

      a
          ? setState(() {
              enable = true;
              _forgotPasswordMenu = true;
              _requirePassword = false;
              _buildForgetButton = false;
              _showPasswordCheckBox = false;
              _isRegistered = false;
            })
          : _showDilog('OOPS!',
              'Something went wrong, I\'m unable to connect to our servers. Try again!');
    } catch (error) {
      _showDilog('Oops!', '$error');
    }
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: ScreenUtil().setHeight(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                if (mounted)
                  setState(() {
                    // if (_showPasswordCheckBox) {
                    // _showPassword = !_showPassword;
                    // } else {
                    _rememberMe = value;
                    Provider.of<Auth>(context, listen: false).setRemeber(value);
                    // }
                  });
              },
            ),
          ),
          Text(
            'Keep me Logged In',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildNextBtn() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      width: double.infinity,
      // height: ScreenUtil().setHeight(75.0),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _isLoading ? () {} : next,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: _isLoading
            ? SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
                height: ScreenUtil().setHeight(22),
                width: ScreenUtil().setWidth(22),
              )
            : Text(
                _showSignup ? 'SignUp' : _buildForgetButton ? 'Login' : 'Next',
                style: TextStyle(
                  color: Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy Regular',
                ),
              ),
      ),
    );
  }

  // Widget _buildSignInWithText() {
  //   return Column(
  //     children: <Widget>[
  //       Text(
  //         '- OR -',
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //       SizedBox(height: 20.0),
  //       Text(
  //         'Sign in with',
  //         style: kLabelStyle,
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildSocialBtn(Function onTap, AssetImage logo) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       height: 60.0,
  //       width: 60.0,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: Colors.white,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black26,
  //             offset: Offset(0, 2),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //         image: DecorationImage(
  //           image: logo,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildSocialBtnRow() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 30.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         _buildSocialBtn(
  // () => print('Login with Facebook'),
  //           AssetImage(
  //             'assets/logos/facebook.jpg',
  //           ),
  //         ),
  //         _buildSocialBtn(
  // () => print('Login with Google'),
  //           AssetImage(
  //             'assets/logos/google.jpg',
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  int _screen = 0;
  bool _isLoading = false;
  Future<void> next() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if (_forgotPasswordMenu) _screen++;
      // print('PP next buttton Pressed');
      // print(!_buildForgetButton);
      if (!_buildForgetButton && _screen < 2) {
        // print(_showSignup);
        if (_showSignup) {
          // print('PP In first If part');
          try {
            await Provider.of<Auth>(context, listen: false).userSignup(
                (_fnameController.text.substring(0, 1).toUpperCase() +
                            _fnameController.text.substring(1).toLowerCase())
                        .trim() +
                    ' ' +
                    (_lnameController.text.substring(0, 1).toUpperCase() +
                            _lnameController.text.substring(1).toLowerCase())
                        .trim(),
                _phoneController.text.trim(),
                _passwordController.text);
            Provider.of<Auth>(context, listen: false).changeLog();

            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
          } catch (error) {
            _showDilog('Oops!', '$error');
          } finally {
            if (mounted)
              setState(() {
                _isLoading = false;
              });
          }
        } else {
          try {
            // print(_isRegistered);
            _isRegistered = _forgotPasswordMenu
                ? true
                : await Provider.of<Auth>(context, listen: false)
                    .checkIfRegistered(_phoneController.text.trim());
            if (mounted)
              setState(() {
                _isLoading = false;
                // print('PP in setState1: $_isRegistered');
                // if (_isRegistered != null) {

                // }
                if (_isRegistered) {
                  phoneNumber = _phoneController.text.trim();
                  _requirePassword = true;
                  enable = false;

                  _controller.forward();
                  // print(!_forgotPasswordMenu);
                  if (!_forgotPasswordMenu) _buildForgetButton = true;

                  _showPasswordCheckBox = true;
                } else {
                  _showSignup = true;
                  enable = false;

                  _requirePassword = true;
                  _controller.forward();
                  _showPasswordCheckBox = true;
                }
                // setState(() {
                //   _isLoading = true;
                // });
              });
          } catch (error) {
            _showDilog('Oops!', '$error');
          } finally {
            setState(() {
              _isLoading = false;
            });
          }
        }
      } else {
        // print('PP in second else part: $_forgotPasswordMenu');
        // print(_phoneController.text);
        phoneNumber = _phoneController.text.trim();
        // print(_fnameController.text);
        // print(_passwordController.text);

        // await Provider.of<Auth>(context, listen: false)
        //     .checkOtp(code: _nameController.text, number: phoneNumber);

        if (_forgotPasswordMenu) {
          try {
            await Provider.of<Auth>(context, listen: false).resetPassword(
                _phoneController.text.trim(),
                _fnameController.text.trim(),
                _passwordController.text);
          } catch (error) {
            _showDilog('Oops!', '$error');
          }
          _passwordController.clear();
          _phoneController.clear();
          _fnameController.clear();
          _lnameController.clear();
          setState(() {
            enable = true;
            _requirePassword = false;
            _buildForgetButton = false;
            _isRegistered = false;
            _showSignup = false;
            // _rememberMe = false;
            _showPassword = false;
            _showPasswordCheckBox = false;
            _forgotPasswordMenu = false;
            _screen = 0;
            _isLoading = false;
          });
        } else {
          try {
            await Provider.of<Auth>(context, listen: false).userLogin(
                _phoneController.text.trim(), _passwordController.text);
            Provider.of<Auth>(context, listen: false).changeLog();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          } catch (error) {
            if (error.toString().contains("Brute")) {
              _showDilog('Auth Failed!', 'Your password is incorrect');
            } else {
              _showDilog('Something Went Wrong!', '$error');
            }
          } finally {
            setState(() {
              _isLoading = false;
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('PP value of _requirePassword: $_requirePassword');
    // print('PP value of _showSigUp: $_showSignup');
    ScreenUtil.init(context, allowFontScaling: true, height: 775, width: 411);
    return Scaffold(
        body: Form(
      key: _key,
      child: Container(
        width: double.infinity,
        // height: ScreenUtil().setHeight(775),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF32FFF3),
              Color(0xFF3685CB),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        height: double.infinity,
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          constraints: BoxConstraints(
            minHeight: _requirePassword
                ? ScreenUtil().setHeight(700)
                : ScreenUtil().setHeight(700),
            maxHeight: _requirePassword
                ? _showSignup
                    ? ScreenUtil().setHeight(775)
                    : ScreenUtil().setHeight(775)
                : ScreenUtil().setHeight(700),
          ),
          duration: Duration(milliseconds: 300),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //SizedBox(height: deviceSize.height / 10),
                Text(
                  'Hello!',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Gilroy Regular',
                    fontSize:
                        ScreenUtil().setSp(50, allowFontScalingSelf: true),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                  height: ScreenUtil().setHeight(130),
                  width: ScreenUtil().setWidth(130),
                ),
                // if (_showSignup == true ||
                //     _forgotPasswordMenu == true ||
                //     _requirePassword == true)
                //   SlideTransition(
                //     position: _slideAnimation2,
                //     child: Container(
                //       alignment: Alignment.centerRight,
                //       child: FlatButton(
                //         onPressed: () {
                //           setState(() {
                //             enable = true;
                //             _phoneController.clear();
                //             _nameController.clear();
                //             _passwordController.clear();
                //             _requirePassword = false;
                //             _buildForgetButton = false;
                //             _isRegistered = false;
                //             _showSignup = false;
                // _rememberMe = false;
                //             _showPassword = false;
                //             _showPasswordCheckBox = false;
                //             _forgotPasswordMenu = false;
                //             _screen = 0;
                //           });
                //         },
                //         padding: EdgeInsets.only(right: 0.0),
                //         child: Text(
                //           'Edit',
                //           style: kLabelStyle,
                //         ),
                //       ),
                //     ),
                //   ),

                SizedBox(height: ScreenUtil().setHeight(30)),
                if (_showSignup) ...[
                  SlideTransition(
                    position: _slideAnimation2,
                    child: Row(
                      children: <Widget>[
                        _buildGivenNameTF(
                          name: 'First Name',
                          enable: true,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "Enter First Name";
                            } else if (value.length < 3) {
                              return "Name Error";
                            } else if (value.contains(RegExp(r'[0-9]'))) {
                              return "Enter Valid Name";
                            }
                            return null;
                          },
                          hint: 'First Name',
                          controller: _fnameController,
                          inputType: TextInputType.text,
                          icon: Icons.person,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(7),
                        ),
                        _buildGivenNameTF(
                          name: 'Last Name',
                          enable: true,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "Enter Last Name";
                            } else if (value.length < 3) {
                              return "Name Error";
                            } else if (value.contains(RegExp(r'[0-9]'))) {
                              return "Enter Valid Name";
                            }
                            return null;
                          },
                          hint: 'Last Name',
                          controller: _lnameController,
                          inputType: TextInputType.text,
                          icon: Icons.person,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  )
                ],
                //if (!_isRegistered)
                _buildGivenTF(
                    name: _forgotPasswordMenu ? 'OTP' : 'Mobile Number',
                    enable: enable,
                    validate: _forgotPasswordMenu
                        ? (value) {
                            if (value.isEmpty) {
                              return "Enter OTP";
                            } else if (value.length != 4) {
                              return "OTP Should be of 4 digit";
                            }
                            return null;
                          }
                        : (value) {
                            if (value.isEmpty) {
                              return "Enter Phone Number";
                            } else if (value.length < 10) {
                              return "Enter 10 digit Number";
                            }
                            return null;
                          },
                    hint: _forgotPasswordMenu
                        ? 'Check SMS on your Phone'
                        : 'Enter 10 digits number',
                    controller: _forgotPasswordMenu
                        ? _fnameController
                        : _phoneController,
                    inputType: TextInputType.phone,
                    icon: Icons.phone_iphone),

                if (_requirePassword || _showSignup)
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                        opacity: _opacityAnimation, child: _buildPasswordTF()),
                  ),
                if (_buildForgetButton) _buildForgotPasswordBtn(),

                _forgotPasswordMenu && _requirePassword == false
                    ? Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.bottomRight,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [_resendMessageBtn()]),
                      )
                    : _buildRememberMeCheckbox(),

                _forgotPasswordMenu && _requirePassword == false
                    ? Container(
                        padding: EdgeInsets.only(top: 20.0),
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () async {
                            setState(() {
                              isVerifyLoading = true;
                            });
                            bool b;
                            try {
                              b = await Provider.of<Auth>(context,
                                      listen: false)
                                  .checkOtp(
                                      number: phoneNumber.toString(),
                                      code: _fnameController.text);
                              if (mounted)
                                setState(() {
                                  isVerifyLoading = false;
                                });

                              if (b) {
                                _forgotPasswordMenu = true;
                                _requirePassword = true;
                                next();
                              } else {
                                dataSelect(
                                    context: context,
                                    titleText: 'Invalid Otp',
                                    buttonText: "Okay",
                                    contentText: "Please Enter Correct OTP",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    gif: "assets/images/alert.gif");
                              }
                            } catch (error) {
                              _showDilog('Oops!', '$error');
                            } finally {
                              if (mounted)
                                setState(() {
                                  isVerifyLoading = false;
                                });
                            }
                          },
                          elevation: 5.0,
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: _isLoading
                              ? SizedBox(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                  height: ScreenUtil().setHeight(22),
                                  width: ScreenUtil().setWidth(22),
                                )
                              : Text(
                                  'Verify Otp',
                                  style: TextStyle(
                                    color: Color(0xFF527DAA),
                                    letterSpacing: 1.5,
                                    fontSize: ScreenUtil()
                                        .setSp(18, allowFontScalingSelf: true),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy Regular',
                                  ),
                                ),
                        ))
                    : _buildNextBtn(),
                if (!_showSignup &&
                    !_forgotPasswordMenu &&
                    _requirePassword) ...[
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Gilroy Medium',
                          fontSize: ScreenUtil()
                              .setSp(12, allowFontScalingSelf: true),
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'By logging in account, I agree to the ',
                          ),
                          TextSpan(
                            text: 'Terms of Service,',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(
                                    "https://legal.gemstory.in")) {
                                  await launch("https://legal.gemstory.in");
                                } else {
                                  throw 'Could not launch https://legal.gemstory.in';
                                }
                              },
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0,
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: 'Privacy Policy,',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(
                                    "https://legal.gemstory.in")) {
                                  await launch("https://legal.gemstory.in");
                                } else {
                                  throw 'Could not launch https://legal.gemstory.in';
                                }
                              },
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                          ),
                          TextSpan(
                            text: 'Data Processing Terms.',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(
                                    "https://legal.gemstory.in")) {
                                  await launch("https://legal.gemstory.in");
                                } else {
                                  throw 'Could not launch https://legal.gemstory.in';
                                }
                              },
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                ],

                if (_showSignup) ...[
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Gilroy Medium',
                          fontSize: ScreenUtil()
                              .setSp(12, allowFontScalingSelf: true),
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'By creating an account, I agree to the ',
                          ),
                          TextSpan(
                            text: 'Terms of Service,',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(
                                    "https://legal.gemstory.in")) {
                                  await launch("https://legal.gemstory.in");
                                } else {
                                  throw 'Could not launch https://legal.gemstory.in';
                                }
                              },
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0,
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: 'Privacy Policy,',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(
                                    "https://legal.gemstory.in")) {
                                  await launch("https://legal.gemstory.in");
                                } else {
                                  throw 'Could not launch https://legal.gemstory.in';
                                }
                              },
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                          ),
                          TextSpan(
                            text: 'Data Processing Terms.',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(
                                    "https://legal.gemstory.in")) {
                                  await launch("https://legal.gemstory.in");
                                } else {
                                  throw 'Could not launch https://legal.gemstory.in';
                                }
                              },
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  )
                ],
                //_buildSignInWithText(),
                //_buildSocialBtnRow(),
                //_buildSignupBtn(),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'Gilroy Regular',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'Gilroy Regular',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF34A1D4),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
