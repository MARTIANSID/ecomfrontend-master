import 'dart:ui';

import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/products.dart';
import 'package:Flutter/screens/appui.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:provider/provider.dart';
import 'OptCert.dart';
import 'filterChipWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'optBuild.dart';
import 'optColor.dart';
import 'optPrice.dart';

class AddToCart extends StatefulWidget {
  final product;
  final int productIndexInCart;
  final int image;
  final int diamond;
  final int build;
  final bool updateCart;
  final int cert;
  final int defValue;
  final int defValue1;
  final int defValue2;
  final int defValue3;
  final choicesBuild;
  final choiceColor;
  final choiceCertification;
  final choiceDiamondQuality;
  final void Function(int,int) valueChangeBuild;
  final void Function(int,int) valueChangeColor;
  final void Function(int,int) valueChangeCerti;
  final void Function(int,int) valueChangeDQ;

  const AddToCart(
      {Key key,
      this.product,
      this.productIndexInCart = 0,
      this.image,
      this.diamond,
      this.build,
      this.updateCart,
      this.cert,
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
  AddToCartTState createState() => AddToCartTState();
}

// bool isLoading = false;

class AddToCartTState extends State<AddToCart> {
  int valueOfQuantity = 1;
  int _defaultChoiceIndex;
  int _defaultChoiceIndex1;
  int _defaultChoiceIndex2;
  int _defaultChoiceIndex3;

  String colorKey;
  String priceKey;
  int buildPrice;
  int certPrice;
  bool flag=true;

  @override
  void initState() {
    super.initState();
    _defaultChoiceIndex = widget.defValue;
    _defaultChoiceIndex1 = widget.defValue1;
    _defaultChoiceIndex2 = widget.defValue2;
    _defaultChoiceIndex3 = widget.defValue3;
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
    // _defaultChoiceIndex = widget.defValue;
    // _defaultChoiceIndex1 = widget.defValue1;
    // _defaultChoiceIndex2 = widget.defValue2;
    // _defaultChoiceIndex3 = widget.defValue3;
if(widget.updateCart && flag){
    valueOfQuantity=Provider.of<Cart>(context,listen: false).cart[widget.productIndexInCart].quantity;
    flag=false;
  }
    colorKey = (Provider.of<Pagination>(context, listen: false)
            .color[_defaultChoiceIndex1])
        .toLowerCase();

    priceKey = (Provider.of<Pagination>(context, listen: false)
        .diamondQuality[_defaultChoiceIndex3]);

    certPrice = Provider.of<Pagination>(context, listen: false).certPrices[
        Provider.of<Pagination>(context, listen: false)
            .cert[_defaultChoiceIndex2]];

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        contentPadding: EdgeInsets.all(14.0),
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(575),
            width: ScreenUtil().setWidth(400),
            // width: 700.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // SizedBox(
                //   height: ScreenUtil().setHeight(19),
                // ),
                // Center(
                //   child: Text(
                //     "Options",
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontFamily: 'Gilroy Medium',
                //       fontSize:
                //           ScreenUtil().setSp(24, allowFontScalingSelf: true),
                //     ),
                //   ),
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        // SizedBox(
                        //   height: ScreenUtil().setHeight(11.625),
                        // ),
                        Container(
                          // height: size.height * 0.18,
                          // width: size.width * 0.36,
                          // color: Colors.amber,
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20.0),
                          //     color: Colors.white),
                          // color: Colors.amber,
                          child: widget.product.imageUrl.containsKey(colorKey)
                              ? Image(
                                  height: ScreenUtil().setHeight(135),
                                  width: ScreenUtil().setWidth(130),
                                  image: AdvancedNetworkImage(
                                    widget.product.imageUrl[colorKey],
                                    useDiskCache: true,
                                    cacheRule: CacheRule(
                                        maxAge: const Duration(days: 3)),
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : Image(
                                  height: ScreenUtil().setHeight(135),
                                  width: ScreenUtil().setWidth(130),
                                  image: AdvancedNetworkImage(
                                    widget.product.imageUrl['yellow'],
                                    useDiskCache: true,
                                    cacheRule: CacheRule(
                                        maxAge: const Duration(days: 3)),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // SizedBox(
                        //   height: ScreenUtil().setHeight(38.75),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.product.styleNumber,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil()
                                  .setSp(20, allowFontScalingSelf: true),
                            ),
                          ),
                        ),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Color(0xFF34B0D9),
                              Color(0xFF3685CB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: widget.product.prices.containsKey(priceKey)
                              ? Text(
                                  '${int.parse(widget.product.prices[priceKey]) + certPrice} ₹',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil()
                                        .setSp(18, allowFontScalingSelf: true),
                                    fontFamily: 'Gilroy Bold',
                                  ),
                                )
                              : Text(
                                  'no price',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil()
                                        .setSp(18, allowFontScalingSelf: true),
                                    fontFamily: 'Gilroy Bold',
                                  ),
                                ),
                        ),
                        // diamond == 0
                        //     ? Text(
                        //         widget.product.vVS_EF,
                        //         style: TextStyle(
                        //           fontFamily: 'Gilroy Black',
                        //           color: Colors.black,
                        //           fontSize: ScreenUtil()
                        //               .setSp(27, allowFontScalingSelf: true),
                        //         ),
                        //       )
                        //     : diamond == 1
                        //         ? Text(
                        //             widget.product.vVS_FG,
                        //             style: TextStyle(
                        //               fontFamily: 'Gilroy Black',
                        //               color: Colors.black,
                        //               fontSize: ScreenUtil().setSp(27,
                        //                   allowFontScalingSelf: true),
                        //             ),
                        //           )
                        //         : diamond == 2
                        //             ? Text(widget.product.vVS_VS_FG)
                        //             : diamond == 3
                        //                 ? Text(
                        //                     widget.product.vS_FG,
                        //                     style: TextStyle(
                        //                       fontFamily: 'Gilroy Black',
                        //                       color: Colors.black,
                        //                       fontSize: ScreenUtil().setSp(27,
                        //                           allowFontScalingSelf: true),
                        //                     ),
                        //                   )
                        //                 : diamond == 4
                        //                     ? Text(
                        //                         widget.product.sI_HI,
                        //                         style: TextStyle(
                        //                           fontFamily: 'Gilroy Black',
                        //                           color: Colors.black,
                        //                           fontSize: ScreenUtil().setSp(
                        //                               27,
                        //                               allowFontScalingSelf:
                        //                                   true),
                        //                         ),
                        //                       )
                        //                     : Text(''),
                        SizedBox(
                          height: ScreenUtil().setHeight(11.625),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: <Widget>[
                        //     Container(
                        //       height: ScreenUtil().setHeight(31),
                        //       width: ScreenUtil().setWidth(36.99),
                        //       decoration: BoxDecoration(
                        //         border: Border.all(
                        //           color: kPrimaryColor,
                        //           width: 2.0,
                        //         ),
                        //         shape: BoxShape.circle,
                        //         color: Colors.white,
                        //       ),
                        //       child: GestureDetector(
                        //         child: Center(
                        //           child: Text(
                        //             '-',
                        //             style: TextStyle(
                        //               fontSize: ScreenUtil().setSp(25,
                        //                   allowFontScalingSelf: true),
                        //               color: kPrimaryColor,
                        //               fontFamily: 'Gilroy',
                        //             ),
                        //           ),
                        //         ),
                        //         onTap: () {
                        //           if (valueOfQuantity > 1) {
                        //             setState(() {
                        //               valueOfQuantity = valueOfQuantity - 1;
                        //             });
                        //           }
                        //         },
                        //       ),
                        //     ),
                        //     Container(
                        //       height: ScreenUtil().setHeight(31),
                        //       width: ScreenUtil().setWidth(36.99),
                        //       // decoration: BoxDecoration(
                        //       //     // shape: BoxShape.circle,
                        //       //     borderRadius:BorderRadius.circular(6.0),
                        //       //     color: Colors.white),
                        //       child: Center(
                        //         child: Text(
                        //           '$valueOfQuantity',
                        //           style: TextStyle(
                        //             fontSize: ScreenUtil()
                        //                 .setSp(28, allowFontScalingSelf: true),
                        //             color: Colors.black,
                        //             fontFamily: 'Gilroy',
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       height: ScreenUtil().setHeight(31),
                        //       width: ScreenUtil().setWidth(36.99),
                        //       decoration: BoxDecoration(
                        //         border: Border.all(
                        //           color: kPrimaryColor,
                        //           width: 2.0,
                        //         ),
                        //         shape: BoxShape.circle,
                        //         color: Colors.white,
                        //       ),
                        //       child: Center(
                        //         child: GestureDetector(
                        //           child: Text(
                        //             '+',
                        //             style: TextStyle(
                        //               fontSize: ScreenUtil().setSp(25,
                        //                   allowFontScalingSelf: true),
                        //               color: kPrimaryColor,
                        //               fontFamily: 'Gilroy',
                        //             ),
                        //           ),
                        //           onTap: () {
                        //             setState(() {
                        //               valueOfQuantity = valueOfQuantity + 1;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Container(
                          width: ScreenUtil().setWidth(77),
                          height: ScreenUtil().setHeight(38),
                          padding: EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  if (valueOfQuantity > 1) {
                                    setState(() {
                                      valueOfQuantity = valueOfQuantity - 1;
                                    });
                                  }
                                },
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    color: Colors.black,
                                    fontSize: ScreenUtil()
                                        .setSp(22, allowFontScalingSelf: true),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(19),
                                width: ScreenUtil().setWidth(11),
                                child: Text(
                                  '$valueOfQuantity',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy Black',
                                    color: Colors.black,
                                    fontSize: ScreenUtil()
                                        .setSp(18, allowFontScalingSelf: true),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    valueOfQuantity = valueOfQuantity + 1;
                                  });
                                },
                                child: ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: [
                                      Color(0xFF34B0D9),
                                      Color(0xFF3685CB),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(
                                    Rect.fromLTWH(
                                        0, 0, bounds.width, bounds.height),
                                  ),
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(22,
                                          allowFontScalingSelf: true),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/cartButtonShape.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                // SizedBox(
                //   height: ScreenUtil().setHeight(19),
                // ),
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
                  spacing: 9.0,
                  runSpacing: 5.0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List<Widget>.generate(widget.choicesBuild.length,
                      (int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _defaultChoiceIndex = index;
                        });
                        widget.valueChangeBuild(index,widget.productIndexInCart);
                      },
                      child: Container(
                        // margin: EdgeInsets.only(right: 6.0),
                        height: ScreenUtil().setHeight(30),
                        width: ScreenUtil().setWidth(95),
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
                  spacing: 9.0,
                  runSpacing: 5.0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List<Widget>.generate(widget.choiceColor.length,
                      (int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _defaultChoiceIndex1 = index;
                        });
                        widget.valueChangeColor(index,widget.productIndexInCart);
                      },
                      child: Container(
                        // margin: EdgeInsets.only(right: 6.0),
                        height: ScreenUtil().setHeight(30),
                        width: ScreenUtil().setWidth(95),
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
                                      fontFamily: _defaultChoiceIndex1 == index
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
                  spacing: 9.0,
                  runSpacing: 5.0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List<Widget>.generate(
                      widget.choiceCertification.length, (int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _defaultChoiceIndex2 = index;
                        });
                        widget.valueChangeCerti(index,widget.productIndexInCart);
                      },
                      child: Container(
                        // margin: EdgeInsets.only(right: 6.0),
                        height: ScreenUtil().setHeight(30),
                        width: ScreenUtil().setWidth(95),
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
                                      fontFamily: _defaultChoiceIndex2 == index
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
                  spacing: 9.0,
                  runSpacing: 5.0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List<Widget>.generate(
                      widget.choiceDiamondQuality.length, (int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _defaultChoiceIndex3 = index;
                        });
                        widget.valueChangeDQ(index,widget.productIndexInCart);
                      },
                      child: Container(
                        // margin: EdgeInsets.only(right: 6.0),
                        height: ScreenUtil().setHeight(30),
                        width: ScreenUtil().setWidth(95),
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
                                      fontFamily: _defaultChoiceIndex3 == index
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
                    onTap: () async {
                      await Provider.of<Cart>(context, listen: false).addCart(
                        context: context,
                        product: widget.product,
                        color: colorKey,

                        cert: Provider.of<Pagination>(context, listen: false)
                            .cert[_defaultChoiceIndex2],
                        diamond: priceKey,
                        build: Provider.of<Pagination>(context, listen: false)
                            .build[_defaultChoiceIndex],
                        quantity: valueOfQuantity,
                        colorValue: _defaultChoiceIndex1,
                        buildValue: _defaultChoiceIndex,
                        diamondValue: _defaultChoiceIndex3,
                        certvalue: _defaultChoiceIndex2,
                        update: widget.updateCart ? true : false,
                      );
                      Navigator.of(context).pop();
                      widget.updateCart
                          ? showFloatingFlushbar(
                              context,
                              'Your Cart data has been successfully Updated',
                              widget.product.styleNumber,
                            )
                          : showFloatingFlushbar(
                              context,
                              'Product has been added to your Cart"🛒"',
                              widget.product.styleNumber,
                            );
                    },
                    child: Container(
                      width: ScreenUtil().setWidth(180),
                      height: ScreenUtil().setHeight(43),
                      // padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          'ADD TO CART',
                          style: TextStyle(
                            fontFamily: 'Gilroy Bold',
                            color: Colors.white,
                            fontSize: ScreenUtil()
                                .setSp(14, allowFontScalingSelf: true),
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
    );
    // return Container(
    //   // width: size.width*0.5,
    //   height: ScreenUtil().setHeight(650),
    //   // color: Colors.amber,
    //   // padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
    //   // margin: EdgeInsets.only(top: 15.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: <Widget>[
    //           Column(
    //             children: <Widget>[
    //               SizedBox(
    //                 height: ScreenUtil().setHeight(11.625),
    //               ),
    //               Container(
    //                 // height: size.height * 0.18,
    //                 // width: size.width * 0.36,
    //                 // color: Colors.amber,
    //                 // decoration: BoxDecoration(
    //                 //     borderRadius: BorderRadius.circular(20.0),
    //                 //     color: Colors.white),
    //                 // color: Colors.amber,
    //                 child: Image.network(
    //                   color == 0
    //                       ? widget.product.yellow
    //                       : color == 1
    //                           ? widget.product.white
    //                           : color == 2 ? widget.product.rose : '',
    //                   // 'https://api.nakoda.daxy.in/images/products/2020060420284349.webp',
    //                   fit: BoxFit.fill,
    //                   height: ScreenUtil().setHeight(178.25),
    //                   width: ScreenUtil().setWidth(180.84),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               SizedBox(
    //                 height: ScreenUtil().setHeight(38.75),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(bottom: 8.0),
    //                 child: Text(
    //                   widget.product.styleNumber,
    //                   style: TextStyle(
    //                     fontFamily: 'Gilroy',
    //                     fontWeight: FontWeight.bold,
    //                     fontSize:
    //                         ScreenUtil().setSp(20, allowFontScalingSelf: true),
    //                   ),
    //                 ),
    //               ),
    //               diamond == 0
    //                   ? Text(
    //                       widget.product.vVS_EF,
    //                       style: TextStyle(
    //                         fontFamily: 'Gilroy Black',
    //                         color: Colors.black,
    //                         fontSize: ScreenUtil()
    //                             .setSp(27, allowFontScalingSelf: true),
    //                       ),
    //                     )
    //                   : diamond == 1
    //                       ? Text(
    //                           widget.product.vVS_FG,
    //                           style: TextStyle(
    //                             fontFamily: 'Gilroy Black',
    //                             color: Colors.black,
    //                             fontSize: ScreenUtil()
    //                                 .setSp(27, allowFontScalingSelf: true),
    //                           ),
    //                         )
    //                       : diamond == 2
    //                           ? Text(widget.product.vVS_VS_FG)
    //                           : diamond == 3
    //                               ? Text(
    //                                   widget.product.vS_FG,
    //                                   style: TextStyle(
    //                                     fontFamily: 'Gilroy Black',
    //                                     color: Colors.black,
    //                                     fontSize: ScreenUtil().setSp(27,
    //                                         allowFontScalingSelf: true),
    //                                   ),
    //                                 )
    //                               : diamond == 4
    //                                   ? Text(
    //                                       widget.product.sI_HI,
    //                                       style: TextStyle(
    //                                         fontFamily: 'Gilroy Black',
    //                                         color: Colors.black,
    //                                         fontSize: ScreenUtil().setSp(27,
    //                                             allowFontScalingSelf: true),
    //                                       ),
    //                                     )
    //                                   : Text(''),
    //               SizedBox(
    //                 height: ScreenUtil().setHeight(11.625),
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: <Widget>[
    //                   Container(
    //                     height: ScreenUtil().setHeight(31),
    //                     width: ScreenUtil().setWidth(36.99),
    //                     decoration: BoxDecoration(
    //                       border: Border.all(
    //                         color: kPrimaryColor,
    //                         width: 2.0,
    //                       ),
    //                       shape: BoxShape.circle,
    //                       color: Colors.white,
    //                     ),
    //                     child: GestureDetector(
    //                       child: Center(
    //                         child: Text(
    //                           '-',
    //                           style: TextStyle(
    //                             fontSize: ScreenUtil()
    //                                 .setSp(25, allowFontScalingSelf: true),
    //                             color: kPrimaryColor,
    //                             fontFamily: 'Gilroy',
    //                           ),
    //                         ),
    //                       ),
    //                       onTap: () {
    //                         if (valueOfQuantity > 0) {
    //                           setState(() {
    //                             valueOfQuantity = valueOfQuantity - 1;
    //                           });
    //                         }
    //                       },
    //                     ),
    //                   ),
    //                   Container(
    //                     height: ScreenUtil().setHeight(31),
    //                     width: ScreenUtil().setWidth(36.99),
    //                     // decoration: BoxDecoration(
    //                     //     // shape: BoxShape.circle,
    //                     //     borderRadius:BorderRadius.circular(6.0),
    //                     //     color: Colors.white),
    //                     child: Center(
    //                       child: Text(
    //                         '$valueOfQuantity',
    //                         style: TextStyle(
    //                           fontSize: ScreenUtil()
    //                               .setSp(28, allowFontScalingSelf: true),
    //                           color: Colors.black,
    //                           fontFamily: 'Gilroy',
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Container(
    //                     height: ScreenUtil().setHeight(31),
    //                     width: ScreenUtil().setWidth(36.99),
    //                     decoration: BoxDecoration(
    //                       border: Border.all(
    //                         color: kPrimaryColor,
    //                         width: 2.0,
    //                       ),
    //                       shape: BoxShape.circle,
    //                       color: Colors.white,
    //                     ),
    //                     child: Center(
    //                       child: GestureDetector(
    //                         child: Text(
    //                           '+',
    //                           style: TextStyle(
    //                             fontSize: ScreenUtil()
    //                                 .setSp(25, allowFontScalingSelf: true),
    //                             color: kPrimaryColor,
    //                             fontFamily: 'Gilroy',
    //                           ),
    //                         ),
    //                         onTap: () {
    //                           setState(() {
    //                             valueOfQuantity = valueOfQuantity + 1;
    //                           });
    //                         },
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //       Container(
    //         padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.only(
    //                 left: 20.0,
    //                 bottom: 0.0,
    //                 // top: 10.0,
    //               ),
    //               child: Text(
    //                 'Build: ',
    //                 style: TextStyle(
    //                     fontFamily: 'Gilroy Black',
    //                     fontSize:
    //                         ScreenUtil().setSp(17, allowFontScalingSelf: true)),
    //               ),
    //             ),
    //             Container(
    //               width: ScreenUtil().setWidth(411),
    //               height: ScreenUtil().setHeight(58.9),
    //               padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
    //               decoration: BoxDecoration(
    //                   // border: Border.all(color: kPrimaryColor, width: 1.0),
    //                   borderRadius: BorderRadius.circular(25.0)),
    //               child: Container(
    //                 width: ScreenUtil().setWidth(411),
    //                 height: ScreenUtil().setHeight(62),
    //                 child: Container(
    //                   margin: EdgeInsets.only(right: 3.0),
    //                   child: Opt1(buildd, true, setBuild),
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(
    //                 left: 20.0,
    //                 bottom: 0.0,
    //                 // top: 10.0,
    //               ),
    //               child: Text(
    //                 'Color: ',
    //                 style: TextStyle(
    //                     fontFamily: 'Gilroy Black',
    //                     fontSize:
    //                         ScreenUtil().setSp(17, allowFontScalingSelf: true)),
    //               ),
    //             ),
    //             Container(
    //               width: ScreenUtil().setWidth(411),
    //               height: ScreenUtil().setHeight(58.9),
    //               padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
    //               decoration: BoxDecoration(
    //                   // border: Border.all(color: kPrimaryColor, width: 1.0),
    //                   borderRadius: BorderRadius.circular(25.0)),
    //               child: Container(
    //                 width: ScreenUtil().setWidth(411),
    //                 height: ScreenUtil().setHeight(62),
    //                 child: Container(
    //                   margin: EdgeInsets.only(right: 3.0),
    //                   child: OptColor(color, true, setColor),
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(
    //                 left: 20.0,
    //                 bottom: 0.0,
    //                 // top: 10.0,
    //               ),
    //               child: Text(
    //                 'Certification: ',
    //                 style: TextStyle(
    //                     fontFamily: 'Gilroy Black',
    //                     fontSize:
    //                         ScreenUtil().setSp(17, allowFontScalingSelf: true)),
    //               ),
    //             ),
    //             Container(
    //               width: ScreenUtil().setWidth(411),
    //               height: ScreenUtil().setHeight(58.9),
    //               padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
    //               decoration: BoxDecoration(
    //                   // border: Border.all(color: kPrimaryColor, width: 1.0),
    //                   borderRadius: BorderRadius.circular(25.0)),
    //               child: Container(
    //                 width: ScreenUtil().setWidth(1000),
    //                 height: ScreenUtil().setHeight(75),
    //                 child: Container(
    //                   margin: EdgeInsets.only(right: 3.0),
    //                   child: OptCert(certt, true, setCert),
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(
    //                 left: 20.0,
    //                 bottom: 0.0,
    //                 // top: 10.0,
    //               ),
    //               child: Text(
    //                 'Diamond Quality: ',
    //                 style: TextStyle(
    //                     fontFamily: 'Gilroy Black',
    //                     fontSize:
    //                         ScreenUtil().setSp(17, allowFontScalingSelf: true)),
    //               ),
    //             ),
    //             Container(
    //               width: ScreenUtil().setWidth(411),
    //               height: ScreenUtil().setHeight(58.9),
    //               padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
    //               decoration: BoxDecoration(
    //                   // border: Border.all(color: kPrimaryColor, width: 1.0),
    //                   borderRadius: BorderRadius.circular(25.0)),
    //               child: Container(
    //                 width: ScreenUtil().setWidth(411),
    //                 height: ScreenUtil().setHeight(100),
    //                 child: Container(
    //                     margin: EdgeInsets.only(right: 3.0),
    //                     child: OptDiamond(diamond, true, setDiamond)),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       SizedBox(
    //         height: ScreenUtil().setHeight(27.9),
    //       ),
    //       Container(
    //         width: ScreenUtil().setWidth(287.7),
    //         height: ScreenUtil().setHeight(54.25),
    //         child: RaisedButton(
    //           color: kPrimaryColor,
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(25.0),
    //           ),
    //           child: Text(
    //             'Add to Cart',
    //             style: TextStyle(
    //               fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
    //               color: Colors.white,
    //               fontFamily: 'Gilroy',
    //             ),
    //           ),
    //             onPressed: () async{
    //               setState(() {
    //                 isLoading = true;
    //               });
    //            await    Provider.of<Cart>(context, listen: false)
    //                   .addCart(context: context,product: widget.product,color: color,cert: certt,diamond: diamond,build: buildd,quantity:valueOfQuantity);
    //               Navigator.of(context).pop();
    //               widget.updateCart ? showFloatingFlushbar(
    //                 context,
    //                 'Your Cart data has been successfully Updated',
    //                 widget.product.styleNumber,
    //               ) : showFloatingFlushbar(
    //                 context,
    //                 'Product has been added to your Cart"🛒"',
    //                 widget.product.styleNumber,
    //               );
    //               setState(() {
    //                 isLoading = false;
    //               });
    //             },
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
