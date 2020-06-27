import 'dart:ui';
import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final void Function(int, int) valueChangeBuild;
  final void Function(int, int) valueChangeColor;
  final void Function(int, int) valueChangeCerti;
  final void Function(int, int) valueChangeDQ;
  final GlobalKey globalKey;

  const AddToCart(
      {Key key,
      this.product,
      this.globalKey,
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
  bool flag = true;

  bool isLoading = false;

  bool value2 = false;

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
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    // _defaultChoiceIndex = widget.defValue;
    // _defaultChoiceIndex1 = widget.defValue1;
    // _defaultChoiceIndex2 = widget.defValue2;
    // _defaultChoiceIndex3 = widget.defValue3;
    if (widget.updateCart && flag) {
      valueOfQuantity = Provider.of<Cart>(context, listen: false)
          .cart[widget.productIndexInCart]
          .quantity;
      flag = false;
    }
    colorKey = (Provider.of<Pagination>(context, listen: false)
            .color[_defaultChoiceIndex1])
        .toLowerCase();

if(Provider.of<Pagination>(context,listen: false).isPriced)
{
    priceKey = (Provider.of<Pagination>(context, listen: false)
        .diamondQuality[_defaultChoiceIndex3]);

    certPrice = Provider.of<Pagination>(context, listen: false).certPrices[
        Provider.of<Pagination>(context, listen: false)
            .cert[_defaultChoiceIndex2]];
}

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              contentPadding: EdgeInsets.all(14.0),
              children: <Widget>[
                // height: ScreenUtil().setHeight(590),
                //   width: ScreenUtil().setWidth(400),
                Column(
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
                              child: widget.product.imageUrl
                                      .containsKey(colorKey)
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
                            Text(
                              widget.product.styleNumber,
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil()
                                    .setSp(20, allowFontScalingSelf: true),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(9),
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
                                Rect.fromLTWH(
                                    0, 0, bounds.width, bounds.height),
                              ),
                              child: widget.product.prices.containsKey(priceKey) && Provider.of<Pagination>(context,listen: false).isPriced
                                  ? Text(
                                      '${int.parse(widget.product.prices[priceKey]) + certPrice} ₹',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(18,
                                            allowFontScalingSelf: true),
                                        fontFamily: 'Gilroy Bold',
                                      ),
                                    )
                                  : Text(
                                      'Prices Not Set ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(18,
                                            allowFontScalingSelf: true),
                                        fontFamily: 'Gilroy Bold',
                                      ),
                                    ),
                            ),
                            // SizedBox(
                            //   height: ScreenUtil().setHeight(11.625),
                            // ),
                            Container(
                              width: ScreenUtil().setWidth(93),
                              height: ScreenUtil().setHeight(80),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // SizedBox(
                                  //   width: ScreenUtil().setWidth(5),
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      if (valueOfQuantity > 1) {
                                        setState(() {
                                          valueOfQuantity = valueOfQuantity - 1;
                                        });
                                      }
                                    },
                                    child: ShaderMask(
                                      shaderCallback: (bounds) =>
                                          LinearGradient(
                                        colors: [
                                          Colors.black,
                                          Colors.black,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(
                                        Rect.fromLTWH(
                                            0, 0, bounds.width, bounds.height),
                                      ),
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy Bold',
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(25,
                                              allowFontScalingSelf: true),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  SizedBox(
                                    width: ScreenUtil()
                                        .setWidth(5),
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(35),
                                    child: Center(
                                      child: ShaderMask(
                                        shaderCallback: (bounds) => LinearGradient(
                                          colors: [
                                            Colors.black,
                                            Colors.black,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(
                                          Rect.fromLTWH(
                                              0, 0, bounds.width, bounds.height),
                                        ),
                                        child: Text(
                                          // '888',
                                          '$valueOfQuantity',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy Black',
                                            color: Colors.black,
                                            fontSize: ScreenUtil().setSp(20,
                                                allowFontScalingSelf: true),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil()
                                        .setWidth(5),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        valueOfQuantity = valueOfQuantity + 1;
                                      });
                                    },
                                    child: ShaderMask(
                                      shaderCallback: (bounds) =>
                                          LinearGradient(
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
                                          fontFamily: 'Gilroy Bold',
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(25,
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
                            // Container(
                            //   width: ScreenUtil().setWidth(77),
                            //   height: ScreenUtil().setHeight(38),
                            //   padding: EdgeInsets.all(3.0),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: <Widget>[
                            //       GestureDetector(
                            //         onTap: () {
                            //           if (valueOfQuantity > 1) {
                            //             setState(() {
                            //               valueOfQuantity = valueOfQuantity - 1;
                            //             });
                            //           }
                            //         },
                            //         child: Text(
                            //           '-',
                            //           style: TextStyle(
                            //             fontFamily: 'Gilroy',
                            //             color: Colors.black,
                            //             fontSize: ScreenUtil().setSp(22,
                            //                 allowFontScalingSelf: true),
                            //             fontWeight: FontWeight.w500,
                            //           ),
                            //         ),
                            //       ),
                            //       Container(
                            //         height: ScreenUtil().setHeight(19),
                            //         width: ScreenUtil().setWidth(11),
                            //         child: Text(
                            //           '$valueOfQuantity',
                            //           style: TextStyle(
                            //             fontFamily: 'Gilroy Black',
                            //             color: Colors.black,
                            //             fontSize: ScreenUtil().setSp(18,
                            //                 allowFontScalingSelf: true),
                            //             fontWeight: FontWeight.w500,
                            //           ),
                            //         ),
                            //       ),
                            //       GestureDetector(
                            //         onTap: () {
                            //           setState(() {
                            //             valueOfQuantity = valueOfQuantity + 1;
                            //           });
                            //         },
                            //         child: ShaderMask(
                            //           shaderCallback: (bounds) =>
                            //               LinearGradient(
                            //             colors: [
                            //               Color(0xFF34B0D9),
                            //               Color(0xFF3685CB),
                            //             ],
                            //             begin: Alignment.topLeft,
                            //             end: Alignment.bottomRight,
                            //           ).createShader(
                            //             Rect.fromLTWH(
                            //                 0, 0, bounds.width, bounds.height),
                            //           ),
                            //           child: Text(
                            //             '+',
                            //             style: TextStyle(
                            //               fontFamily: 'Gilroy',
                            //               color: Colors.white,
                            //               fontSize: ScreenUtil().setSp(22,
                            //                   allowFontScalingSelf: true),
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            //   decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //       image: AssetImage(
                            //           'assets/images/cartButtonShape.png'),
                            //       fit: BoxFit.contain,
                            //     ),
                            //   ),
                            // ),
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
                        fontSize:
                            ScreenUtil().setSp(18, allowFontScalingSelf: true),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 4.0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: List<Widget>.generate(
                          widget.choicesBuild.length, (int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _defaultChoiceIndex = index;
                            });
                            widget.valueChangeBuild(
                                index, widget.productIndexInCart);
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
                                                Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
                                                    bounds.height),
                                              )
                                            : LinearGradient(
                                                colors: [
                                                  Colors.black,
                                                  Colors.black,
                                                ],
                                              ).createShader(
                                                Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
                                                    bounds.height),
                                              ),
                                    child: Text(
                                      widget.choicesBuild[index],
                                      style: TextStyle(
                                          color: _defaultChoiceIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily:
                                              _defaultChoiceIndex == index
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
                        fontSize:
                            ScreenUtil().setSp(18, allowFontScalingSelf: true),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 4.0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: List<Widget>.generate(widget.choiceColor.length,
                          (int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _defaultChoiceIndex1 = index;
                            });
                            widget.valueChangeColor(
                                index, widget.productIndexInCart);
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
                                                Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
                                                    bounds.height),
                                              )
                                            : LinearGradient(
                                                colors: [
                                                  Colors.black,
                                                  Colors.black,
                                                ],
                                              ).createShader(
                                                Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
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
                      'Certification',
                      style: TextStyle(
                        fontFamily: 'Gilroy Medium',
                        fontSize:
                            ScreenUtil().setSp(18, allowFontScalingSelf: true),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 4.0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: List<Widget>.generate(
                          widget.choiceCertification.length, (int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _defaultChoiceIndex2 = index;
                            });
                            widget.valueChangeCerti(
                                index, widget.productIndexInCart);
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
                                                Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
                                                    bounds.height),
                                              )
                                            : LinearGradient(
                                                colors: [
                                                  Colors.black,
                                                  Colors.black,
                                                ],
                                              ).createShader(
                                                Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
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
                        fontSize:
                            ScreenUtil().setSp(18, allowFontScalingSelf: true),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 4.0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: List<Widget>.generate(
                          widget.choiceDiamondQuality.length, (int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _defaultChoiceIndex3 = index;
                            });
                            widget.valueChangeDQ(
                                index, widget.productIndexInCart);
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
                                                Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
                                                    bounds.height),
                                              )
                                            : LinearGradient(
                                                colors: [
                                                  Colors.black,
                                                  Colors.black,
                                                ],
                                              ).createShader(
                                                Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
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
                        onTap: () async {
                          await dataSelectConfirmMessage(
                            widget.globalKey.currentContext,
                            'Alert!',
                            "Are you sure, You want to update the Cart?",
                            'Request Prices',
                          ).then((value) async {
                            if (value) {
                              value2 = value;
                            }
                          });
                          print(value2);
                          if (value2) {
                           try{

                            setState(() {
                              isLoading = true;
                            });
                            await Provider.of<Cart>(context, listen: false)
                                .addCart(
                              context: context,
                              product: widget.product,
                              color: colorKey,
                              cert: Provider.of<Pagination>(context,
                                      listen: false)
                                  .cert[_defaultChoiceIndex2],
                              diamond: priceKey,
                              build: Provider.of<Pagination>(context,
                                      listen: false)
                                  .build[_defaultChoiceIndex],
                              quantity: valueOfQuantity,
                              colorValue: _defaultChoiceIndex1,
                              buildValue: _defaultChoiceIndex,
                              diamondValue: _defaultChoiceIndex3,
                              certvalue: _defaultChoiceIndex2,
                              update: widget.updateCart ? true : false,
                            );
                           }catch(err){
                             dataSelect(context, '$err', '', 'OK', () {
          Navigator.pop(context);
    
      });
                           }finally{
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                           }
                            widget.updateCart
                                ? showFloatingFlushbar(
                                    widget.globalKey.currentContext,
                                    'Your Cart data has been successfully Updated',
                                    widget.product.styleNumber,
                                  )
                                : showFloatingFlushbar(
                                    widget.globalKey.currentContext,
                                    'Product has been added to your Cart"🛒"',
                                    widget.product.styleNumber,
                                  );
                          }
                          // print(val);
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
                      height: ScreenUtil().setHeight(8),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
