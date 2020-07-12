import 'package:Flutter/providers/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyOrderDetailPage extends StatefulWidget {
  final List<dynamic> products;
  final int index;
  MyOrderDetailPage({this.products, this.index});
  @override
  _MyOrderDetailPageState createState() => _MyOrderDetailPageState();
}

class _MyOrderDetailPageState extends State<MyOrderDetailPage> {
  List<String> str = [
    'Processing',
    'Manufacturing',
    'Certification & Final Inspection',
    'Delivery',
    'Completed',
  ];
  List<String> strMessage = [
    'We\'ve just recieved your order! Our software is handling this order with #priority.😊',
    'We at Gemstory are fully committed to deliver products before time. Product finishing, setting and polishing, all minor details taken into Account.',
    'Each and every diamond is checked thoroughly to deliver the best in your hands.',
    'Out for delivery! Our team will handover the package to you any moment!🚚',
    'Hope you love our art! wating for the feedback🤝',
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ScreenUtil.init(
      context,
      width: 411.42857142857144,
      height: 774.8571428571429,
      allowFontScaling: true,
    );
    // nt(size.width);
    // print(size.height);
    return Scaffold(
      body: Container(
        // color: Colors.amber,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 10.0),
              child: Container(
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    // print(MediaQuery.of(context).padding.top);

                    Navigator.of(context).pop();
                  },
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 10.0, 10.0, 10.0),
              child: Text(
                "#" +
                    Provider.of<Orders>(context, listen: false)
                        .orderProducts[widget.index]
                        .orderNumber
                        .toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
                  fontFamily: 'Gilroy Medium',
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(125 *
                          Provider.of<Orders>(context, listen: false)
                              .orderProducts[widget.index]
                              .status),
                      // color: Colors.amber,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: ScreenUtil().setHeight(125),
                            width: ScreenUtil().setWidth(411),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 0.0,
                                  left: ScreenUtil().setWidth(60),
                                  child: Container(
                                    width: ScreenUtil().setWidth(330),
                                    height: ScreenUtil().setHeight(100),
                                    // color: Colors.green,
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Provider.of<Orders>(context,
                                                        listen: false)
                                                    .orderProducts[widget.index]
                                                    .status >=
                                                index + 1
                                            ? Text(
                                                str[index],
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy Regular',
                                                    fontSize: ScreenUtil().setSp(
                                                        16,
                                                        allowFontScalingSelf:
                                                            true),
                                                    color: Colors.black),
                                              )
                                            : SizedBox(height: 0.0),
                                        Provider.of<Orders>(context,
                                                        listen: false)
                                                    .orderProducts[widget.index]
                                                    .status >=
                                                index + 1
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  // border: Border.all(
                                                  //   color: Colors.grey,
                                                  //   width: 1.0,
                                                  // ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // color: Colors.grey[100],
                                                ),
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                padding: EdgeInsets.all(7.0),
                                                width: ScreenUtil()
                                                    .setWidth(308.25),
                                                child: Text(
                                                  strMessage[index],
                                                  // 'Each and every diamond is checked thoroughly to deliver quality products to our client.',
                                                  style: TextStyle(
                                                    fontSize: ScreenUtil().setSp(
                                                        13,
                                                        allowFontScalingSelf:
                                                            true),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 0.0,
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0.0,
                                  // bottom: 0.0,
                                  left: ScreenUtil().setWidth(35),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Provider.of<Orders>(context,
                                                      listen: false)
                                                  .orderProducts[widget.index]
                                                  .status >=
                                              index + 1
                                          ? ShaderMask(
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
                                                    0,
                                                    0,
                                                    bounds.width,
                                                    bounds.height),
                                              ),
                                              child: Icon(
                                                Icons.check_circle,
                                                color: Colors.white,
                                              ),
                                            )
                                          : SizedBox(
                                              height: 0.0,
                                            ),
                                      // : Container(
                                      //     height:
                                      //         ScreenUtil().setWidth(20),
                                      //     width:
                                      //         ScreenUtil().setWidth(20),
                                      //     margin: index == 4
                                      //         ? EdgeInsets.only(
                                      //             left: 3.0)
                                      //         : null,
                                      //     decoration: BoxDecoration(
                                      //       gradient: LinearGradient(
                                      //         colors: [
                                      //           Color(0xFF34B0D9),
                                      //           Color(0xFF3685CB),
                                      //         ],
                                      //         begin: Alignment.topLeft,
                                      //         end:
                                      //             Alignment.bottomRight,
                                      //       ),
                                      //       shape: BoxShape.circle,
                                      //     ),
                                      //     padding: EdgeInsets.all(1.5),
                                      //     child: Container(
                                      //       height: ScreenUtil()
                                      //           .setWidth(18.5),
                                      //       width: ScreenUtil()
                                      //           .setWidth(18.5),
                                      //       decoration: BoxDecoration(
                                      //         color: Color(0xFFF4F4F4),
                                      //         shape: BoxShape.circle,
                                      //       ),
                                      //     ),
                                      //   ),
                                      index != 4
                                          ? Provider.of<Orders>(context,
                                                          listen: false)
                                                      .orderProducts[
                                                          widget.index]
                                                      .status >
                                                  index + 1
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8.0,
                                                    top: 6.0,
                                                    bottom: 6.0,
                                                  ),
                                                  child: RotatedBox(
                                                    quarterTurns: 1,
                                                    child: ShaderMask(
                                                      shaderCallback:
                                                          (bounds) =>
                                                              LinearGradient(
                                                        colors: [
                                                          Color(0xFF34B0D9),
                                                          Color(0xFF3685CB),
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ).createShader(
                                                        Rect.fromLTWH(
                                                            0,
                                                            0,
                                                            bounds.width,
                                                            bounds.height),
                                                      ),
                                                      child: Text(
                                                        '................',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          letterSpacing: 2.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 0.0,
                                                )
                                          // : Padding(
                                          //     padding:
                                          //         const EdgeInsets.only(
                                          //       left: 8.0,
                                          //       top: 6.0,
                                          //       bottom: 6.0,
                                          //     ),
                                          //     child: RotatedBox(
                                          //       quarterTurns: 1,
                                          //       child: ShaderMask(
                                          //         shaderCallback:
                                          //             (bounds) =>
                                          //                 LinearGradient(
                                          //           colors: [
                                          //             Colors.grey,
                                          //             Colors.grey,
                                          //           ],
                                          //           begin: Alignment
                                          //               .topLeft,
                                          //           end: Alignment
                                          //               .bottomRight,
                                          //         ).createShader(
                                          //           Rect.fromLTWH(
                                          //               0,
                                          //               0,
                                          //               bounds.width,
                                          //               bounds.height),
                                          //         ),
                                          //         child: Text(
                                          //           '................',
                                          //           style: TextStyle(
                                          //             color:
                                          //                 Colors.grey,
                                          //             letterSpacing:
                                          //                 2.0,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   )
                                          : SizedBox(
                                              height: 0.0,
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: 5,
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setWidth(300),
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          );
                        },
                        itemCount: widget.products.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: ScreenUtil().setHeight(130),
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // color: Colors.black,
                                Image(
                                  image: NetworkImage(
                                    widget.products[index].displayImage,
                                  ),
                                  fit: BoxFit.fill,
                                  height: ScreenUtil().setHeight(77.5),
                                  width: ScreenUtil().setWidth(82.2),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                  ),
                                  child: VerticalDivider(
                                    color: Colors.black,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.products[index].styleNumber
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Gilroy Regular",
                                        fontSize: ScreenUtil().setSp(13,
                                            allowFontScalingSelf: true),
                                      ),
                                    ),
                                    Text(
                                      'Build: ${widget.products[index].build}',
                                      style: TextStyle(
                                        fontFamily: "Gilroy Regular",
                                        fontSize: ScreenUtil().setSp(13,
                                            allowFontScalingSelf: true),
                                      ),
                                    ),
                                    Text(
                                      'Color: ${widget.products[index].color}',
                                      style: TextStyle(
                                        fontFamily: "Gilroy Regular",
                                        fontSize: ScreenUtil().setSp(13,
                                            allowFontScalingSelf: true),
                                      ),
                                    ),
                                    Text(
                                      'Diamond Quality:${widget.products[index].diamondQuality}',
                                      style: TextStyle(
                                        fontFamily: "Gilroy Regular",
                                        fontSize: ScreenUtil().setSp(13,
                                            allowFontScalingSelf: true),
                                      ),
                                    ),
                                    Text(
                                      'Certification: ${widget.products[index].certificate}',
                                      style: TextStyle(
                                        fontFamily: "Gilroy Regular",
                                        fontSize: ScreenUtil().setSp(13,
                                            allowFontScalingSelf: true),
                                      ),
                                    ),
                                    Text(
                                      'Quantity: ${widget.products[index].quantity}',
                                      style: TextStyle(
                                        fontFamily: "Gilroy Regular",
                                        fontSize: ScreenUtil().setSp(13,
                                            allowFontScalingSelf: true),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
