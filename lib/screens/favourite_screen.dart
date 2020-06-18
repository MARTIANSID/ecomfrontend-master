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
        color: Color(0xFFF4F4F4),
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(22),
                  ),
                  Container(
                    // padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.fromLTRB(25, 11, 26, 20),
                    width: ScreenUtil().setWidth(360),
                    height: ScreenUtil().setHeight(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.all(15.0),
                            hintText: 'SEARCH GEMSTORY',
                            hintStyle: TextStyle(
                              fontFamily: 'Gilroy Medium',
                              color: Color(0xFF595959),
                              fontSize: ScreenUtil()
                                  .setSp(14, allowFontScalingSelf: true),
                            ),
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: ScreenUtil()
                                  .setSp(16, allowFontScalingSelf: true)),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6.58),
                          child: SvgPicture.asset(
                            'assets/icons/notificationIcon.svg',
                            height: ScreenUtil().setHeight(27),
                            width: ScreenUtil().setWidth(27),
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 26, 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                          child: Text(
                            'FAVOURITES',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Gilroy Bold',
                              fontSize: ScreenUtil()
                                  .setSp(20, allowFontScalingSelf: true),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: SvgPicture.asset(
                                'assets/icons/sortIcon.svg',
                                width: ScreenUtil().setWidth(24),
                                height: ScreenUtil().setHeight(24),
                                color: Colors.black,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/optionsIcon.svg',
                              width: ScreenUtil().setWidth(24),
                              height: ScreenUtil().setHeight(24),
                              color: Colors.black,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
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
            // Positioned(
            //   right: ScreenUtil().setHeight(32.88),
            //   top: ScreenUtil().setHeight(108.5),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       RaisedButton(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(18.0)),
            //         color: kPrimaryColor,
            //         child: Row(
            //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: <Widget>[
            //             Icon(
            //               MyFlutterApp.cog,
            //               size: ScreenUtil().setSp(23,allowFontScalingSelf: true),
            //               color: Colors.white,
            //             ),
            //             SizedBox(
            //               width: ScreenUtil().setWidth(10),
            //             ),
            //             Text(
            //               "Options",
            //               style: TextStyle(
            //                 fontSize: ScreenUtil().setSp(17,allowFontScalingSelf: true),
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ],
            //         ),
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) =>
            //                   AppUI(onButtonTapped: widget.onButtonTapped),
            //             ),
            //           );
            //         },
            //       ),
            //       SizedBox(
            //         width: ScreenUtil().setWidth(15),
            //       ),
            //       RaisedButton(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(18.0),
            //         ),
            //         color: kPrimaryColor,
            //         child: Row(
            //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: <Widget>[
            //             Icon(
            //               MyFlutterApp.params,
            //               size: ScreenUtil().setSp(23,allowFontScalingSelf: true),
            //               color: Colors.white,
            //             ),
            //             SizedBox(
            //               width: ScreenUtil().setWidth(10),
            //             ),
            //             Text(
            //               "Sort",
            //               style: TextStyle(
            //                 fontSize: ScreenUtil().setSp(17,allowFontScalingSelf: true),
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ],
            //         ),
            //         onPressed: () {
            //           showModalBottomSheet(
            //             context: context,
            //             backgroundColor: Colors.white.withOpacity(0.8),
            //             barrierColor: Colors.black45,
            //             // isScrollControlled: true,
            //             isDismissible: true,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(50.0),
            //               topRight: Radius.circular(50.0),
            //             )),
            //             builder: (BuildContext context) {
            //               return Container(
            //                 padding: EdgeInsets.all(5.0),
            //                 height: ScreenUtil().setHeight(263.5),
                    
            //               );
            //             },
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
