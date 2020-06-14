import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/products.dart';
import 'package:Flutter/widgets/cookie_page.dart';
import 'package:Flutter/widgets/filter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import 'appui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(int) onButtonTapped;
  final bool val;

  const FavouriteScreen(
      {Key key, this.scrollController, this.onButtonTapped, this.val})
      : super(key: key);
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final favProducts = Provider.of<Pagination>(context).favProducts;
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      height: ScreenUtil().setHeight(38.75),
                    ),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(77.5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Text(
                            'Favourites',
                            style: TextStyle(
                              fontFamily: 'Gilroy Black',
                              fontSize: ScreenUtil().setSp(35,allowFontScalingSelf: true),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Text(
                            '${favProducts.length} products',
                            style: TextStyle(
                              fontFamily: 'Gilroy Black',
                              fontSize: ScreenUtil().setSp(16,allowFontScalingSelf: true),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15.5),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(411),
                    height: ScreenUtil().setHeight(643) -
                        (widget.val ? ScreenUtil().setHeight(60) : 0.0),
                    padding: EdgeInsets.fromLTRB(20.0, 45.0, 10.0, 0.0),
                    decoration: BoxDecoration(
                      // color: Color(0xFFE9FFFF),
                      gradient: LinearGradient(
                        colors: <Color>[
                          // Color(0xFF0F2985),
                          // Colors.blue[400]
                          kPrimaryLightColor,
                          Colors.white
                        ],
                        stops: [0.4, 1],
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                      ),
                    ),
                    child: favProducts.length >
                            0
                        ? CookiePage(
                            products:
                               Provider.of<Pagination>(context,listen: true).favProducts,
                            scrollController: widget.scrollController,
                            select: 'fav',
                            color: Provider.of<Options>(context,listen: true).color,
                          )
                        : Center(
                            child: Text(
                              'There aren\t any Favourites product added yet!',
                              style: TextStyle(
                                  fontFamily: 'Gilory Black',
                                  color: Colors.grey[400],
                                  fontSize: ScreenUtil().setSp(35,allowFontScalingSelf: true),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  )
                ],
              ),
            ),
            Positioned(
              right: ScreenUtil().setHeight(32.88),
              top: ScreenUtil().setHeight(108.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    color: kPrimaryColor,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          MyFlutterApp.cog,
                          size: ScreenUtil().setSp(23,allowFontScalingSelf: true),
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Text(
                          "Options",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(17,allowFontScalingSelf: true),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AppUI(onButtonTapped: widget.onButtonTapped),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(15),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: kPrimaryColor,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          MyFlutterApp.params,
                          size: ScreenUtil().setSp(23,allowFontScalingSelf: true),
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Text(
                          "Sort",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(17,allowFontScalingSelf: true),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white.withOpacity(0.8),
                        barrierColor: Colors.black45,
                        // isScrollControlled: true,
                        isDismissible: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        )),
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(5.0),
                            height: ScreenUtil().setHeight(263.5),
                    
                          );
                        },
                      );
                      // final action = CupertinoActionSheet(
                      //   // actionScrollController:
                      //   //     ScrollController(keepScrollOffset: true),
                      //   title: Text(
                      //     "Filter Options",
                      //     style: TextStyle(fontSize: 21.0),
                      //   ),
                      //   message: Text(
                      //     "Please Select To apply following filters",
                      //     style: TextStyle(fontSize: 15.0),
                      //   ),
                      //   actions: <Widget>[
                      //     CupertinoActionSheetAction(
                      //       child: Text("Diamond Count"),
                      //       isDefaultAction: true,
                      //       onPressed: () {
                      //         Navigator.of(context).pop();
                      //         Provider.of<Products>(context, listen: false)
                      //             .filterProducts('Diamond Count');
                      //       },
                      //     ),
                      //     CupertinoActionSheetAction(
                      //       child: Text("Gold Weight"),
                      //       isDefaultAction: true,
                      //       onPressed: () {
                      //         Navigator.of(context).pop();
                      //         Provider.of<Products>(context, listen: false)
                      //             .filterProducts('Diamond Weight');
                      //       },
                      //     ),
                      //     CupertinoActionSheetAction(
                      //       child: Text("Diamond Weight"),
                      //       isDefaultAction: true,
                      //       onPressed: () {
                      //         Navigator.of(context).pop();
                      //         Provider.of<Products>(context, listen: false)
                      //             .filterProducts('Diamond Weight');
                      //       },
                      //     ),
                      //   ],
                      //   cancelButton: CupertinoActionSheetAction(
                      //     child: Text("Cancel"),
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //   ),
                      // );
                      // showCupertinoModalPopup(
                      //     context: context, builder: (context) => action);
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              left: ScreenUtil().setWidth(-50),
              top: 0.0,
              child: Container(
                width: ScreenUtil().setWidth(217.83),
                height: ScreenUtil().setHeight(201.5),
                child: Image.network(
                  'https://api.nakoda.daxy.in/images/products/nosepin6.webp',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Positioned(
            //   top: size.height * 0.075,
            //   right: size.width * 0.08,
            //   child: PopupMenuButton<int>(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15.0),
            //     ),
            //     elevation: 20.0,
            //     onSelected: (int value) {
            //       setState(() {
            //         print(value);
            //       });
            //     },
            //     child: SvgPicture.asset(
            //       "assets/icons/group14.svg",
            //       fit: BoxFit.contain,
            //       height: size.height * 0.033,
            //       // width: size.width*0.1,
            //       // height: 41.0,
            //       // width: 41.0,
            //       // color: Colors.amber,
            //     ),
            //     itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
            //       PopupMenuItem<int>(
            //         value: 0,
            //         child: Container(
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: <Widget>[
            //               Text(
            //                 'High to Low',
            //                 style: TextStyle(fontFamily: 'Courgette'),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       PopupMenuItem<int>(
            //         value: 1,
            //         child: Text(
            //           'Low to High',
            //           style: TextStyle(fontFamily: 'Courgette'),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
