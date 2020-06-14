import 'dart:async';

import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/theme.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/screens/splash_screen.dart';
import 'package:Flutter/widgets/filter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as cp;
import 'package:flutter_svg/svg.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import '../providers/auth.dart';
import '../widgets/cookie_page.dart';
import '../providers/products.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../constant/const.dart';
import './appui.dart';

class ProductOverViewScreen extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(int) onButtonTapped;
  final bool val;

  const ProductOverViewScreen(
      {Key key, this.scrollController, this.onButtonTapped, this.val})
      : super(key: key);
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  bool isInit = true;
  bool isLoading = false;
  String count;
  int sort;
  int colorr;
  int diamond;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this, initialIndex: 1);
    // _loadedProduct = Provider.of<Products>(context, listen: true);

    new Future.delayed(Duration.zero, () async {
      // if (Provider.of<Options>(context, listen: false).build != null) {
      //   buildd = Provider.of<Options>(context, listen: false).build;
      // }
      // if (Provider.of<Options>(context, listen: false).certificate != null) {
      //   certt = Provider.of<Options>(context, listen: false).certificate;
      // }
    });

    super.initState();
  }

  Future<void> getProduct() async {
    await Provider.of<Pagination>(context, listen: false)
        .getProducts(page: 1, addition: false, select: 'all', context: context);
    await Provider.of<Pagination>(context, listen: false).getProducts(
        page: 1, addition: false, select: 'featured', context: context);
    await Provider.of<Pagination>(context, listen: false)
        .getProducts(page: 1, addition: false, select: 'new', context: context);
    await Provider.of<Pagination>(context, listen: false).getProducts(
        page: 1, addition: false, select: 'highestSelling', context: context);
    await Provider.of<Pagination>(context, listen: false).getProducts(
        addition: false, page: 1, context: context, select: 'fancyDiamond');
    await Provider.of<Pagination>(context, listen: false).getFav(context);
    //  await Provider.of<Pagination>(context, listen: false).getProducts(
    //       page: 1, addition: false, select: 'fancyDiamond', context: context);
    if (Provider.of<Auth>(context, listen: false).isLogin &&
        Provider.of<Auth>(context, listen: false).autoLogin == false)
      Provider.of<Auth>(context, listen: false).changeLog();

    if (Provider.of<Auth>(context, listen: false).isLogin == false &&
        Provider.of<Auth>(context, listen: false).autoLogin)
      Provider.of<Auth>(context, listen: false).changeAuto();
  }

  void didChangeDependencies() async {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      if (Provider.of<Auth>(context, listen: false).isLogin ||
          (Provider.of<Auth>(context, listen: false).autoLogin)) {
        await getProduct();
      }
      // Timer.periodic(
      //     Duration(seconds: 1),
      //     (Timer t) async => await Provider.of<Options>(context, listen: false)
      //         .getStringValuesSF());
      await Provider.of<Options>(context, listen: false).getStringValuesSF();

      if (Provider.of<Options>(context, listen: false).color != null) {
        colorr = Provider.of<Options>(context, listen: false).color;
        print(colorr);
        print('in products');
      }
      if (Provider.of<Options>(context, listen: false).diamondQuality != null) {
        diamond = Provider.of<Options>(context, listen: false).diamondQuality;
        print(colorr);
      }
      if (Provider.of<Options>(context, listen: false).build != null) {
        buildd = Provider.of<Options>(context, listen: false).build;
        print(colorr);
      }
      if (Provider.of<Options>(context, listen: false).certificate != null) {
        certt = Provider.of<Options>(context, listen: false).certificate;
        print(colorr);
      }

      setState(() {
        isLoading = false;
        colorr = Provider.of<Options>(context, listen: false).color;
        diamond = Provider.of<Options>(context, listen: false).diamondQuality;
        buildd = Provider.of<Options>(context, listen: false).build;
        certt = Provider.of<Options>(context, listen: false).certificate;
      });

      isInit = false;

      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    var size = MediaQuery.of(context).size;
    print(size.height);
    print(size.width);
    return Scaffold(
      body: isLoading
          ? Center(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: SizedBox(
                            height: ScreenUtil().setHeight(35),
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(80),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Nose Pin',
                                style: TextStyle(
                                  fontFamily: 'Gilroy Black',
                                  fontSize: ScreenUtil()
                                      .setSp(35, allowFontScalingSelf: true),
                                ),
                              ),
                              Text(
                                '52 products',
                                style: TextStyle(
                                  fontFamily: 'Gilroy Black',
                                  fontSize: ScreenUtil()
                                      .setSp(16, allowFontScalingSelf: true),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(411),
                          height: ScreenUtil().setHeight(639) -
                              (widget.val ? ScreenUtil().setHeight(60) : 0.0),
                          padding: EdgeInsets.fromLTRB(10.0, 40.0, 20.0, 0.0),
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
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                // height: 30.0,
                                width: ScreenUtil().setWidth(330),
                                child: TabBar(
                                  controller: _tabController,
                                  indicatorColor: kPrimaryColor,
                                  labelColor: Colors.black,
                                  labelStyle: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil()
                                        .setSp(20, allowFontScalingSelf: true),
                                  ),
                                  unselectedLabelStyle: TextStyle(
                                    fontFamily: 'Gilroy',
                                    // fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil()
                                        .setSp(18, allowFontScalingSelf: true),
                                  ),
                                  // indicatorWeight: 20.0,
                                  isScrollable: true,
                                  // labelPadding: EdgeInsets.only(right: size.width / 12),
                                  unselectedLabelColor: Colors.black,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: Colors.white,
                                  ),
                                  //indicator: UnderlineTabIndicator(insets:EdgeInsets.only(right:20.0),borderSide:BorderSide(color:Colors.pink),),
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        'All',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: ScreenUtil().setSp(18,
                                              allowFontScalingSelf: true),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Featured',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: ScreenUtil().setSp(18,
                                              allowFontScalingSelf: true),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'New',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: ScreenUtil().setSp(18,
                                              allowFontScalingSelf: true),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Highest Selling',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: ScreenUtil().setSp(18,
                                              allowFontScalingSelf: true),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Fancy Diamond',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: ScreenUtil().setSp(18,
                                              allowFontScalingSelf: true),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Expanded(
                                // height: 200.0,
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    // closeApp('NP104'),
                                    // closeApp('NP105'),
                                    // closeApp('NP106'),
                                    // closeApp('NP107'),
                                    // closeApp('NP108'),
                                    CookiePage(
                                      products: Provider.of<Pagination>(context,
                                              listen: true)
                                          .allProducts,
                                      scrollController: widget.scrollController,
                                      select: 'all',
                                      color: Provider.of<Options>(context,
                                              listen: true)
                                          .color,
                                      diamond: Provider.of<Options>(context,
                                              listen: true)
                                          .diamondQuality,
                                      build: Provider.of<Options>(context,
                                              listen: true)
                                          .build,
                                      cert: Provider.of<Options>(context,
                                              listen: true)
                                          .certificate,
                                    ),
                                    CookiePage(
                                      products: Provider.of<Pagination>(context,
                                              listen: true)
                                          .featuredProducts,
                                      scrollController: widget.scrollController,
                                      select: 'featured',
                                      sort: sort,
                                      count: count,
                                      color: Provider.of<Options>(context,
                                              listen: true)
                                          .color,
                                      diamond: Provider.of<Options>(context,
                                              listen: true)
                                          .diamondQuality,
                                      build: Provider.of<Options>(context,
                                              listen: true)
                                          .build,
                                      cert: Provider.of<Options>(context,
                                              listen: true)
                                          .certificate,
                                    ),
                                    CookiePage(
                                      products: Provider.of<Pagination>(context,
                                              listen: true)
                                          .newProducts,
                                      scrollController: widget.scrollController,
                                      select: 'new',
                                      sort: sort,
                                      count: count,
                                      color: Provider.of<Options>(context,
                                              listen: true)
                                          .color,
                                      diamond: Provider.of<Options>(context,
                                              listen: true)
                                          .diamondQuality,
                                      build: Provider.of<Options>(context,
                                              listen: true)
                                          .build,
                                      cert: Provider.of<Options>(context,
                                              listen: true)
                                          .certificate,
                                    ),
                                    CookiePage(
                                      products: Provider.of<Pagination>(context,
                                              listen: true)
                                          .highestSellingProducts,
                                      scrollController: widget.scrollController,
                                      select: 'highestSelling',
                                      sort: sort,
                                      count: count,
                                      color: Provider.of<Options>(context,
                                              listen: true)
                                          .color,
                                      diamond: Provider.of<Options>(context,
                                              listen: true)
                                          .diamondQuality,
                                      build: Provider.of<Options>(context,
                                              listen: true)
                                          .build,
                                      cert: Provider.of<Options>(context,
                                              listen: true)
                                          .certificate,
                                    ),
                                    CookiePage(
                                      products: Provider.of<Pagination>(context,
                                              listen: true)
                                          .fancyDiamond,
                                      scrollController: widget.scrollController,
                                      select: 'fancyDiamond',
                                      sort: sort,
                                      count: count,
                                      color: Provider.of<Options>(context,
                                              listen: true)
                                          .color,
                                      diamond: Provider.of<Options>(context,
                                              listen: true)
                                          .diamondQuality,
                                      build: Provider.of<Options>(context,
                                              listen: true)
                                          .build,
                                      cert: Provider.of<Options>(context,
                                              listen: true)
                                          .certificate,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: ScreenUtil().setWidth(-61.65),
                    top: ScreenUtil().setHeight(10),
                    child: Container(
                      width: ScreenUtil().setWidth(267.15),
                      height: ScreenUtil().setHeight(155),
                      // color: Colors.amber,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Image.network(
                          // width: size.width * 0.55,
                          // height: size.height * 0.2,
                          'https://api.nakoda.daxy.in/images/products/nosepin4.webp',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: ScreenUtil().setWidth(37),
                    top: ScreenUtil().setHeight(110),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: kPrimaryColor,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                MyFlutterApp.cog,
                                color: Colors.white,
                                size: ScreenUtil()
                                    .setSp(23, allowFontScalingSelf: true),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(10),
                              ),
                              Text(
                                "Options",
                                style: TextStyle(
                                  fontSize: ScreenUtil()
                                      .setSp(17, allowFontScalingSelf: true),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppUI(
                                    onButtonTapped: widget.onButtonTapped),
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
                                color: Colors.white,
                                size: ScreenUtil()
                                    .setSp(23, allowFontScalingSelf: true),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(10),
                              ),
                              Text(
                                "Sort",
                                style: TextStyle(
                                  fontSize: ScreenUtil()
                                      .setSp(17, allowFontScalingSelf: true),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          // onPressed: showPicker,
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
                                  height: size.height * 0.34,
                                  child: FilterForProduct(),
                                );
                              },
                            );
                          },
                        ),
                        // popUpButton(),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   top: size.height * 0.075,
                  //   left: size.width * 0.08,
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
                  //     itemBuilder: (BuildContext context) =>
                  //         <PopupMenuEntry<int>>[
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

// class ProductOverViewScreen extends StatefulWidget {
//   @override
//   _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
// }

// class _ProductOverViewScreenState extends State<ProductOverViewScreen>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;
//   Color _a;
//   Color _b;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 5, vsync: this, initialIndex: 1);
//   }

//   int _i = 0;
//   void pressed(context) {
//     showDialog(
//       context: context,
//       child: AlertDialog(
//         title: Text(_i == 0 ? 'Pick Font Color!' : 'Pick BottomBar Color'),
//         content: SingleChildScrollView(
//           child: cp.ColorPicker(
//             pickerColor: Theme.of(context).primaryColor,
//             onColorChanged: (color) {
//               _i == 0
//                   ? _a = color
//                   : Provider.of<ThemeP>(context, listen: false)
//                       .themeRefresh(_a, color);
//             },
//             showLabel: true,
//             pickerAreaHeightPercent: 0.8,
//           ),
//         ),
//         actions: <Widget>[
//           FlatButton(
//               onPressed: () {
//                 if (_i == 0) {
//                   _i++;
//                   Navigator.of(context).pop();
//                   pressed(context);
//                 } else {
//                   _i = 0;
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: Text(_i == 0 ? 'Next' : 'Done'))
//         ],
//       ),
//     );
//   }

//   void filterProducts(context) {
//     showDialog(
//       context: context,
//       builder: (ctx) => SimpleDialog(
//         title: Text('Filter by:'),
//         children: <Widget>[
//           SimpleDialogOption(
//             child: Text(
//               'Diamond Count',
//               style: TextStyle(color: Theme.of(context).primaryColor),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//               Provider.of<Products>(context, listen: false)
//                   .filterProducts('Diamond Count');
//             },
//           ),
//           Divider(),
//           SimpleDialogOption(
//             child: Text(
//               'Diamond Weight',
//               style: TextStyle(color: Theme.of(context).primaryColor),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//               Provider.of<Products>(context, listen: false)
//                   .filterProducts('Diamond Weight');
//             },
//           ),
//           Divider(),
//           SimpleDialogOption(
//             child: Text(
//               'Gold Weight',
//               style: TextStyle(color: Theme.of(context).primaryColor),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//               Provider.of<Products>(context, listen: false)
//                   .filterProducts('Gold Weight');
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _loadedProduct = Provider.of<Products>(context, listen: true);
//     final device = MediaQuery.of(context);
//     return _loadedProduct.products.isEmpty
//         ? FutureBuilder(
//             future: _loadedProduct.fetchAndSetProducts(context: context),
//             builder: (_, snap) =>
//                 snap.connectionState == ConnectionState.waiting
//                     ? SplashScreen()
//                     : buildScaffold(device, _loadedProduct,context))
//         : buildScaffold(device, _loadedProduct,context);
//   }

//   Scaffold buildScaffold(MediaQueryData device, Products _loadedProduct,context) {
//     final _MySearchDelegate delegate=_MySearchDelegate([]);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.color_lens, color: Colors.black),
//           onPressed:()=> pressed(context),
//         ),
//         title: Text('Products',
//             style: TextStyle(
//                 fontFamily: 'Gilroy',
//                 fontSize: 20.0,
//                 color: Color(0xFF545D68))),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () async {
//               final String selected = await showSearch<String>(
//                 context: context,
//                 delegate: delegate,
//               );
//               if (selected != null) {
//                 Scaffold.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('You have selected the word: $selected'),
//                   ),
//                 );
//               }
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.filter_list, color: Color(0xFF545D68)),
//             onPressed:()=> filterProducts(context),
//           ),
//         ],
//       ),
//       body: ListViewProductOverViewScreen(tabController: _tabController),
//     );
//   }
// }

// class ListViewProductOverViewScreen extends StatelessWidget {
//   const ListViewProductOverViewScreen({
//     Key key,
//     @required TabController tabController,
//   })  : _tabController = tabController,
//         super(key: key);

//   final TabController _tabController;

//   @override
//   Widget build(BuildContext context) {
//     final device = MediaQuery.of(context);
//     final _loadedProduct = Provider.of<Products>(context, listen: false);
//     return ListView(
//       children: <Widget>[
//         SizedBox(height: 8.0),
//         Row(
//           children: <Widget>[
//             SizedBox(width: 10),
//             Text('Nose Pins',
//                 style: TextStyle(
//                     color: Theme.of(context).accentColor,
//                     fontFamily: 'Varela',
//                     fontSize: 35.0,
//                     fontWeight: FontWeight.bold)),
//           ],
//         ),
//         //SizedBox(height: 5.0),
//         Row(
//           children: <Widget>[
//             SizedBox(width: 15),
//             Expanded(
//               child: TabBar(
//                   controller: _tabController,
//                   indicatorColor: Colors.transparent,
//                   labelColor: Theme.of(context).primaryColor,
//                   isScrollable: true,
//                   labelPadding: EdgeInsets.only(right: device.size.width / 12),
//                   unselectedLabelColor: Color(0xFFCDCDCD),
//                   //indicator: UnderlineTabIndicator(insets:EdgeInsets.only(right:20.0),borderSide:BorderSide(color:Colors.pink),),
//                   tabs: [
//                     Tab(
//                       child: Text('All',
//                           style: TextStyle(
//                             fontFamily: 'Varela',
//                             fontSize: 21.0,
//                           )),
//                     ),
//                     Tab(
//                       child: Text('Featured',
//                           style: TextStyle(
//                             fontFamily: 'Varela',
//                             fontSize: 21.0,
//                           )),
//                     ),
//                     Tab(
//                       child: Text('New',
//                           style: TextStyle(
//                             fontFamily: 'Varela',
//                             fontSize: 21.0,
//                           )),
//                     ),
//                     Tab(
//                       child: Text('Highest Selling',
//                           style: TextStyle(
//                             fontFamily: 'Varela',
//                             fontSize: 21.0,
//                           )),
//                     ),
//                     Tab(
//                       child: Text('Fancy Diamond',
//                           style: TextStyle(
//                             fontFamily: 'Varela',
//                             fontSize: 21.0,
//                           )),
//                     ),
//                   ]),
//             ),
//           ],
//         ),
//         Container(
//           height: device.size.height - 238.0,
//           width: double.infinity,
//           child: TabBarView(
//             controller: _tabController,
//             children: [
//               CookiePage(

//                 _loadedProduct.products),
//               CookiePage(
//                 _loadedProduct.findByCategory('featured'),
//               ),
//               CookiePage(
//                 _loadedProduct.findByCategory('new'),
//               ),
//               CookiePage(
//                 _loadedProduct.findByCategory('highestSelling'),
//               ),
//               CookiePage(
//                 _loadedProduct.findByCategory('fancyDiamond'),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _MySearchDelegate extends SearchDelegate<String> {
//   final List<String> _words;
//   final List<String> _history;
//   _MySearchDelegate(List<String> words)
//       : _words = words,
//         _history = <String>['apple', 'hello', 'world', 'flutter'],
//         super();

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       tooltip: 'Back',
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
//         this.close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Text('You have selected the word:'),
//             GestureDetector(
//               onTap: () {
//                 // Returns this.query as result to previous screen, c.f.
//                 // `showSearch()` above.
//                 this.close(context, this.query);
//               },
//               child: Text(
//                 this.query,
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline4
//                     .copyWith(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     //
//     final Iterable<String> suggestions = this.query.isEmpty
//         ? _history
//         : _words.where((word) => word.startsWith(query));

//     return _SuggestionList(
//       query: this.query,
//       suggestions: suggestions.toList(),
//       onSelected: (String suggestion) {
//         this.query = suggestion;
//         this._history.insert(0, suggestion);
//         showResults(context);
//       },
//     );
//   }

//   // Action buttons at the right of search bar.
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return <Widget>[
//       query.isEmpty
//           ? IconButton(
//               tooltip: 'Voice Search',
//               icon: const Icon(Icons.mic),
//               onPressed: () {
//                 this.query = 'TODO: implement voice input';
//               },
//             )
//           : IconButton(
//               tooltip: 'Clear',
//               icon: const Icon(Icons.clear),
//               onPressed: () {
//                 query = '';
//                 showSuggestions(context);
//               },
//             )
//     ];
//   }
// }

// // Suggestions list widget displayed in the search page.
// class _SuggestionList extends StatelessWidget {
//   const _SuggestionList({this.suggestions, this.query, this.onSelected});

//   final List<String> suggestions;
//   final String query;
//   final ValueChanged<String> onSelected;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme.subhead;
//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (BuildContext context, int i) {
//         final String suggestion = suggestions[i];
//         return ListTile(
//           leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
//           // Highlight the substring that matched the query.
//           title: RichText(
//             text: TextSpan(
//               text: suggestion.substring(0, query.length),
//               style: textTheme.copyWith(fontWeight: FontWeight.bold),
//               children: <TextSpan>[
//                 TextSpan(
//                   text: suggestion.substring(query.length),
//                   style: textTheme,
//                 ),
//               ],
//             ),
//           ),
//           onTap: () {
//             onSelected(suggestion);
//           },
//         );
//       },
//     );
//   }
// }
