// import 'package:Flutter/providers/user.dart';
// import 'package:Flutter/widgets/fadeanimation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AccountInfo extends StatefulWidget {
//   final data;
//   AccountInfo(this.data);

//   @override
//   _AccountInfoState createState() => _AccountInfoState();
// }

// class _AccountInfoState extends State<AccountInfo> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController fullnameController = TextEditingController();
//     TextEditingController number = TextEditingController();
//     fullnameController.text =
//         Provider.of<UserInfo>(context, listen: false).fullname;
//     number.text =
//         Provider.of<UserInfo>(context, listen: false).number.toString();
//     TextEditingController city = TextEditingController();
//     city.text = Provider.of<UserInfo>(context, listen: false).city.toString();
//     TextEditingController street = TextEditingController();
//     street.text =
//         Provider.of<UserInfo>(context, listen: false).street.toString();

//     TextEditingController email = TextEditingController();
//     TextEditingController firm = TextEditingController();
//     TextEditingController gst = TextEditingController();
//     TextEditingController pincode = TextEditingController();
//     TextEditingController state = TextEditingController();

//     firm.text = Provider.of<UserInfo>(context, listen: false).firm;
//     gst.text = Provider.of<UserInfo>(context, listen: false).gst;
//     pincode.text =
//         Provider.of<UserInfo>(context, listen: false).pincode.toString();
//     state.text = Provider.of<UserInfo>(context, listen: false).state;

//     String sTate;
//     String fullName;
//     String gSt;
//     String cIty;
//     String pIncode;
//     String sTreet;
//     String fIrm;

//     bool editable1 = false;
//     bool editable2 = false;
//     bool editable3 = false;
//     bool editable4 = false;
//     bool editable5 = false;
//     bool editable6 = false;
//     bool editable7 = false;
//     bool editable0 = false;

//     bool isLoading = false;

//     final _formKey = GlobalKey<FormState>();

//     return Scaffold(
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       colors: [Colors.blue, Colors.blue[400], Colors.cyan])),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 80,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         FadeAnimation(
//                             1,
//                             Text(
//                               "Account details",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 40),
//                             )),
//                         SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(30),
//                               topRight: Radius.circular(30))),
//                       child: SingleChildScrollView(
//                         child: Padding(
//                           padding: EdgeInsets.all(30),
//                           child: Form(
//                             child: Column(
//                               children: <Widget>[
//                                 FadeAnimation(
//                                     1.4,
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           boxShadow: [
//                                             BoxShadow(
//                                                 color: Color.fromRGBO(
//                                                     225, 95, 27, .3),
//                                                 blurRadius: 20,
//                                                 offset: Offset(0, 10))
//                                           ]),
//                                       child: Column(
//                                         children: <Widget>[
//                                           Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                                 border: Border(
//                                                     bottom: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]))),
//                                             child: TextFormField(
//                                               controller: fullnameController,
//                                               decoration: InputDecoration(
//                                                   prefixIcon:
//                                                       Icon(Icons.people),
//                                                   labelText: 'Full Name',
//                                                   enabled: editable0,
//                                                   suffixIcon: GestureDetector(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           editable0 = true;
//                                                         });
//                                                       },
//                                                       child: Icon(Icons.edit)),
//                                                   hintStyle: TextStyle(
//                                                       color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                                 border: Border(
//                                                     bottom: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]))),
//                                             child: TextFormField(
//                                               controller: number,
//                                               decoration: InputDecoration(
//                                                   prefixIcon: Icon(Icons.phone),
//                                                   labelText: 'Mobile',
//                                                   enabled: false,
//                                                   hintStyle: TextStyle(
//                                                       color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                                 border: Border(
//                                                     bottom: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]))),
//                                             child: TextFormField(
//                                               controller: email,
//                                               decoration: InputDecoration(
//                                                   labelText: 'Email',
//                                                   enabled: false,
//                                                   prefixIcon:
//                                                       Icon(Icons.location_city),
//                                                   hintStyle: TextStyle(
//                                                       color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )),
//                                 SizedBox(
//                                   height: 60,
//                                 ),
//                                 FadeAnimation(
//                                     1.4,
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           boxShadow: [
//                                             BoxShadow(
//                                                 color: Color.fromRGBO(
//                                                     225, 95, 27, .3),
//                                                 blurRadius: 20,
//                                                 offset: Offset(0, 10))
//                                           ]),
//                                       child: Column(
//                                         children: <Widget>[
//                                           Text(
//                                             'My Details',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 20),
//                                           ),
//                                           Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                                 border: Border(
//                                                     bottom: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]))),
//                                             child: TextFormField(
//                                               controller: firm,
//                                               decoration: InputDecoration(
//                                                   prefixIcon: Icon(Icons
//                                                       .screen_lock_portrait),
//                                                   labelText: 'Firm',
//                                                   enabled: editable1,
//                                                   suffixIcon: GestureDetector(
//                                                     child: Icon(Icons.edit),
//                                                     onTap: () {
//                                                       setState(() {
//                                                         editable1 = true;
//                                                       });
//                                                     },
//                                                   ),
//                                                   hintStyle: TextStyle(
//                                                       color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                                 border: Border(
//                                                     bottom: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]))),
//                                             child: TextFormField(
//                                               controller: gst,
//                                               decoration: InputDecoration(
//                                                   prefixIcon:
//                                                       Icon(Icons.money_off),
//                                                   labelText: 'Gst',
//                                                   enabled: editable2,
//                                                   suffixIcon: GestureDetector(
//                                                     child: Icon(Icons.edit),
//                                                     onTap: () {
//                                                       setState(() {
//                                                         editable2 = true;
//                                                       });
//                                                     },
//                                                   ),
//                                                   hintStyle: TextStyle(
//                                                       color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                                 border: Border(
//                                                     bottom: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]))),
//                                             child: TextFormField(
//                                               controller: street,
//                                               decoration: InputDecoration(
//                                                   prefixIcon:
//                                                       Icon(Icons.location_city),
//                                                   labelText: 'street',
//                                                   enabled: editable3,
//                                                   suffixIcon: GestureDetector(
//                                                     child: Icon(Icons.edit),
//                                                     onTap: () {
//                                                       setState(() {
//                                                         editable3 = true;
//                                                       });
//                                                     },
//                                                   ),
//                                                   hintStyle: TextStyle(
//                                                       color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                                 border: Border(
//                                                     bottom: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]))),
//                                             child: TextField(
//                                               controller: city,
//                                               decoration: InputDecoration(
//                                                   labelText: 'city',
//                                                   enabled: editable4,
//                                                   suffixIcon: GestureDetector(
//                                                     child: Icon(Icons.edit),
//                                                     onTap: () {
//                                                       setState(() {
//                                                         editable4 = true;
//                                                       });
//                                                     },
//                                                   ),
//                                                   prefixIcon:
//                                                       Icon(Icons.streetview),
//                                                   hintStyle: TextStyle(
//                                                       color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                                 border: Border(
//                                                     bottom: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]))),
//                                             child: TextFormField(
//                                               controller: state,
//                                               decoration: InputDecoration(
//                                                   prefixIcon: Icon(Icons.phone),
//                                                   labelText: 'State',
//                                                   enabled: editable5,
//                                                   suffixIcon: GestureDetector(
//                                                     child: Icon(Icons.edit),
//                                                     onTap: () {
//                                                       setState(() {
//                                                         editable5 = true;
//                                                       });
//                                                     },
//                                                   ),
//                                                   hintStyle: TextStyle(
//                                                       color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                                 border: Border(
//                                                     bottom: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]))),
//                                             child: TextFormField(
//                                               controller: pincode,
//                                               decoration: InputDecoration(
//                                                   labelText: 'Pincode',
//                                                   enabled: editable6,
//                                                   suffixIcon: GestureDetector(
//                                                     child: Icon(Icons.edit),
//                                                     onTap: () {
//                                                       setState(() {
//                                                         editable5 = true;
//                                                       });
//                                                     },
//                                                   ),
//                                                   prefixIcon:
//                                                       Icon(Icons.location_on),
//                                                   hintStyle: TextStyle(
//                                                       color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )),
//                                 SizedBox(
//                                   height: 40,
//                                 ),
//                                 SizedBox(
//                                   height: 40,
//                                 ),
//                                 InkWell(
//                                   onTap: () {},
//                                   child: Text('Save Changes'),
//                                 ),
//                                 SizedBox(
//                                   height: 50,
//                                 ),
//                                 FadeAnimation(
//                                     1.7,
//                                     Text(
//                                       "",
//                                       style: TextStyle(color: Colors.grey),
//                                     )),
//                                 SizedBox(
//                                   height: 30,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
// }


import 'package:Flutter/components/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

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
    return Scaffold(
      body: Container(
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   bottom: 0,
            //   right: 0,
            //   child: Image.asset(
            //     "assets/images/bg.jpg",
            //     width: size.width * 0.35,
            //   ),
            // ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/Vector4.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/Vector6.png",
                width: size.width * 0.4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
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
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 325.0,
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
                                        fontSize: 20.0),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                FadeInDownBig(
                                  child: RoundedInputField(
                                    hintText: "Full Name",
                                    // onChanged: (value) {
                                      
                                    // },
                                    onSubmitted: (value){
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
                            height: 20.0,
                          ),
                          Container(
                            height: 555.0,
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
                                        fontSize: 20.0),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                FadeInDownBig(
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
                                FadeInDownBig(
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
                                FadeInDownBig(
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
                                FadeInDownBig(
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
                                FadeInDownBig(
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
                                FadeInDownBig(
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
