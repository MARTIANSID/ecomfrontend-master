import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/products.dart';
import 'package:Flutter/screens/appui.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'OptCert.dart';
import 'filterChipWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'optBuild.dart';
import 'optColor.dart';
import 'optPrice.dart';

class AddToCart extends StatefulWidget {
  final product;
  final int image;
  final int diamond;
  final int build;
  final bool updateCart;
  final int cert;

  const AddToCart(
      {Key key,
      this.diamond,
      this.build,
      this.image,
      this.cert,
      this.product,
      this.updateCart = false})
      : super(key: key);
  @override
  AddToCartTState createState() => AddToCartTState();
}

int color;
int buildd;
bool isLoading = false;
int certt;
int diamond;
int price;

class AddToCartTState extends State<AddToCart> {
  int valueOfQuantity = 0;
  void initState() {
    super.initState();
    color = widget.image;
    buildd = widget.build;
    certt = widget.cert;
    diamond = widget.diamond;

  }

  void setColor(index) {
    setState(() {
      color = index;
    });
  }

  void setBuild(index) {
    buildd = index;
  }

  void setCert(index) {
    
    certt = index;
  }

  void setDiamond(index) {
    setState(() {
      diamond = index;
    });
  }

  // void initState() {
  //   super.initState();
  //   setState(() {
  //     isLoading = true;
  //   });

  //   new Future.delayed(Duration.zero, () async {
  //     await Provider.of<Options>(context, listen: false).getStringValuesSF();
  //     if (Provider.of<Options>(context, listen: false).color != null) {
  //       color = Provider.of<Options>(context, listen: false).color;
  //     }
  //     if (Provider.of<Options>(context, listen: false).build != null) {
  //       buildd = Provider.of<Options>(context, listen: false).build;
  //     }
  //     if (Provider.of<Options>(context, listen: false).certificate != null) {
  //       certt = Provider.of<Options>(context, listen: false).certificate;
  //     }
  //     if (Provider.of<Options>(context, listen: false).diamondQuality != null) {
  //       diamond = Provider.of<Options>(context, listen: false).diamondQuality;
  //     }
  //     setState(() {
  //       isLoading = false;
  //       certt = Provider.of<Options>(context, listen: false).certificate;
  //       color = Provider.of<Options>(context, listen: false).color;
  //       buildd = Provider.of<Options>(context, listen: false).build;
  //       diamond = Provider.of<Options>(context, listen: false).diamondQuality;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    return Container(
      // width: size.width*0.5,
      height: ScreenUtil().setHeight(650),
      // color: Colors.amber,
      // padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      // margin: EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(11.625),
                  ),
                  Container(
                    // height: size.height * 0.18,
                    // width: size.width * 0.36,
                    // color: Colors.amber,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20.0),
                    //     color: Colors.white),
                    // color: Colors.amber,
                    child: Image.network(
                      color == 0
                          ? widget.product.yellow
                          : color == 1
                              ? widget.product.white
                              : color == 2 ? widget.product.rose : '',
                      // 'https://api.nakoda.daxy.in/images/products/2020060420284349.webp',
                      fit: BoxFit.fill,
                      height: ScreenUtil().setHeight(178.25),
                      width: ScreenUtil().setWidth(180.84),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(38.75),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      widget.product.styleNumber,
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold,
                        fontSize:
                            ScreenUtil().setSp(20, allowFontScalingSelf: true),
                      ),
                    ),
                  ),
                  diamond == 0
                      ? Text(
                          widget.product.vVS_EF,
                          style: TextStyle(
                            fontFamily: 'Gilroy Black',
                            color: Colors.black,
                            fontSize: ScreenUtil()
                                .setSp(27, allowFontScalingSelf: true),
                          ),
                        )
                      : diamond == 1
                          ? Text(
                              widget.product.vVS_FG,
                              style: TextStyle(
                                fontFamily: 'Gilroy Black',
                                color: Colors.black,
                                fontSize: ScreenUtil()
                                    .setSp(27, allowFontScalingSelf: true),
                              ),
                            )
                          : diamond == 2
                              ? Text(widget.product.vVS_VS_FG)
                              : diamond == 3
                                  ? Text(
                                      widget.product.vS_FG,
                                      style: TextStyle(
                                        fontFamily: 'Gilroy Black',
                                        color: Colors.black,
                                        fontSize: ScreenUtil().setSp(27,
                                            allowFontScalingSelf: true),
                                      ),
                                    )
                                  : diamond == 4
                                      ? Text(
                                          widget.product.sI_HI,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy Black',
                                            color: Colors.black,
                                            fontSize: ScreenUtil().setSp(27,
                                                allowFontScalingSelf: true),
                                          ),
                                        )
                                      : Text(''),
                  SizedBox(
                    height: ScreenUtil().setHeight(11.625),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setHeight(31),
                        width: ScreenUtil().setWidth(36.99),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 2.0,
                          ),
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: GestureDetector(
                          child: Center(
                            child: Text(
                              '-',
                              style: TextStyle(
                                fontSize: ScreenUtil()
                                    .setSp(25, allowFontScalingSelf: true),
                                color: kPrimaryColor,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          ),
                          onTap: () {
                            if (valueOfQuantity > 0) {
                              setState(() {
                                valueOfQuantity = valueOfQuantity - 1;
                              });
                            }
                          },
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(31),
                        width: ScreenUtil().setWidth(36.99),
                        // decoration: BoxDecoration(
                        //     // shape: BoxShape.circle,
                        //     borderRadius:BorderRadius.circular(6.0),
                        //     color: Colors.white),
                        child: Center(
                          child: Text(
                            '$valueOfQuantity',
                            style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(28, allowFontScalingSelf: true),
                              color: Colors.black,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(31),
                        width: ScreenUtil().setWidth(36.99),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 2.0,
                          ),
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: GestureDetector(
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontSize: ScreenUtil()
                                    .setSp(25, allowFontScalingSelf: true),
                                color: kPrimaryColor,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                valueOfQuantity = valueOfQuantity + 1;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 0.0,
                    // top: 10.0,
                  ),
                  child: Text(
                    'Build: ',
                    style: TextStyle(
                        fontFamily: 'Gilroy Black',
                        fontSize:
                            ScreenUtil().setSp(17, allowFontScalingSelf: true)),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(411),
                  height: ScreenUtil().setHeight(58.9),
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  decoration: BoxDecoration(
                      // border: Border.all(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Container(
                    width: ScreenUtil().setWidth(411),
                    height: ScreenUtil().setHeight(62),
                    child: Container(
                      margin: EdgeInsets.only(right: 3.0),
                      child: Opt1(buildd, true, setBuild),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 0.0,
                    // top: 10.0,
                  ),
                  child: Text(
                    'Color: ',
                    style: TextStyle(
                        fontFamily: 'Gilroy Black',
                        fontSize:
                            ScreenUtil().setSp(17, allowFontScalingSelf: true)),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(411),
                  height: ScreenUtil().setHeight(58.9),
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  decoration: BoxDecoration(
                      // border: Border.all(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Container(
                    width: ScreenUtil().setWidth(411),
                    height: ScreenUtil().setHeight(62),
                    child: Container(
                      margin: EdgeInsets.only(right: 3.0),
                      child: OptColor(color, true, setColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 0.0,
                    // top: 10.0,
                  ),
                  child: Text(
                    'Certification: ',
                    style: TextStyle(
                        fontFamily: 'Gilroy Black',
                        fontSize:
                            ScreenUtil().setSp(17, allowFontScalingSelf: true)),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(411),
                  height: ScreenUtil().setHeight(58.9),
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  decoration: BoxDecoration(
                      // border: Border.all(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Container(
                    width: ScreenUtil().setWidth(1000),
                    height: ScreenUtil().setHeight(75),
                    child: Container(
                      margin: EdgeInsets.only(right: 3.0),
                      child: OptCert(certt, true, setCert),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 0.0,
                    // top: 10.0,
                  ),
                  child: Text(
                    'Diamond Quality: ',
                    style: TextStyle(
                        fontFamily: 'Gilroy Black',
                        fontSize:
                            ScreenUtil().setSp(17, allowFontScalingSelf: true)),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(411),
                  height: ScreenUtil().setHeight(58.9),
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  decoration: BoxDecoration(
                      // border: Border.all(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Container(
                    width: ScreenUtil().setWidth(411),
                    height: ScreenUtil().setHeight(100),
                    child: Container(
                        margin: EdgeInsets.only(right: 3.0),
                        child: OptDiamond(diamond, true, setDiamond)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(27.9),
          ),
          Container(
            width: ScreenUtil().setWidth(287.7),
            height: ScreenUtil().setHeight(54.25),
            child: RaisedButton(
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
                  color: Colors.white,
                  fontFamily: 'Gilroy',
                ),
              ),
                onPressed: () async{
                  setState(() {
                    isLoading = true;
                  });
               await    Provider.of<Cart>(context, listen: false)
                      .addCart(context: context,product: widget.product,color: color,cert: certt,diamond: diamond,build: buildd,quantity:valueOfQuantity);
                  Navigator.of(context).pop();
                  widget.updateCart ? showFloatingFlushbar(
                    context,
                    'Your Cart data has been successfully Updated',
                    widget.product.styleNumber,
                  ) : showFloatingFlushbar(
                    context,
                    'Product has been added to your Cart"🛒"',
                    widget.product.styleNumber,
                  );
                  setState(() {
                    isLoading = false;
                  });
                },
            ),
          )
        ],
      ),
    );
  }
}
