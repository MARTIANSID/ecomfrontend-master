import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/screens/product_detail.dart';
import 'package:Flutter/widgets/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constant/const.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' show ImageFilter;

class CookiePage extends StatefulWidget {
  final select;
  final List<dynamic> products;
  final ScrollController scrollController;
  final String count;
  final int sort;
  final int c;
  final int color;
  final int diamond;
  final int build;
  final int cert;

  CookiePage(
      {Key key,
      this.products,
      this.scrollController,
      this.select,
      this.count,
      this.sort,
      this.c,
      this.color,
      this.diamond,
      this.build,
      this.cert})
      : super(key: key);

  @override
  _CookiePageState createState() => _CookiePageState();
}

class _CookiePageState extends State<CookiePage> {
  bool _showAppbar = true; //this is to show app bar
  // ScrollController scrollBottomBarController =
  //     new ScrollController(); // set controller on scrolling
  bool isScrollingDown = false;
  int selectedValue;
  int valueOfQuantity = 0;
  bool isLoading = false;
  bool isInit = true;
  int c;
  int value;
  String color;
  int colorr;
  bool isLoadingg = false;

  Future<void> getMoreProducts() async {
    if (widget.select == 'all')
      await Provider.of<Pagination>(context, listen: false).getProducts(
          page: Provider.of<Pagination>(context, listen: false).pageAll,
          select: 'all',
          addition: true,
          context: context,
          sort: Provider.of<Pagination>(context, listen: false).sort,
          sortby: Provider.of<Pagination>(context, listen: false).count);
    if (widget.select == 'new')
      await Provider.of<Pagination>(context, listen: false).getProducts(
          page: Provider.of<Pagination>(context, listen: false).pageNew,
          select: 'new',
          addition: true,
          context: context,
          sort: Provider.of<Pagination>(context, listen: false).sort,
          sortby: Provider.of<Pagination>(context, listen: false).count);
    if (widget.select == 'featured')
      await Provider.of<Pagination>(context, listen: false).getProducts(
          page: Provider.of<Pagination>(context, listen: false).pageFeatured,
          select: 'featured',
          addition: true,
          context: context,
          sort: Provider.of<Pagination>(context, listen: false).sort,
          sortby: Provider.of<Pagination>(context, listen: false).count);
    if (widget.select == 'highestSelling')
      await Provider.of<Pagination>(context, listen: false).getProducts(
          page: Provider.of<Pagination>(context, listen: false).pageHighest,
          select: 'highestSelling',
          addition: true,
          context: context,
          sort: Provider.of<Pagination>(context, listen: false).sort,
          sortby: Provider.of<Pagination>(context, listen: false).count);
    if (widget.select == 'fancyDiamond')
      await Provider.of<Pagination>(context, listen: false).getProducts(
          page: Provider.of<Pagination>(context, listen: false).pageDiamond,
          select: 'fancyDiamond',
          addition: true,
          context: context,
          sort: Provider.of<Pagination>(context, listen: false).sort,
          sortby: Provider.of<Pagination>(context, listen: false).count);
  }

  createList() async {
    widget.scrollController.addListener(() async {
      if (widget.scrollController.position.maxScrollExtent ==
          widget.scrollController.position.pixels) {
        if (!mounted)
          setState(() {
            isLoading = true;
          });
        // if (Provider.of<Pagination>(context, listen: false).c) {
        //    Provider.of<Pagination>(context,listen:false).pageStart();

        // }

        Provider.of<Pagination>(context, listen: false).pageAdd(widget.select);

        await getMoreProducts();
        if (!mounted)
          setState(() {
            isLoading = false;
          });
      }
    });
  }

  void didChangeDependencies() async {
    if (isInit) {
      if (widget.select != 'fav') {
        createList();
      }
      // if (Provider.of<Auth>(context, listen: false).autoLogin) {
      //   if (!mounted) return;
      //   setState(() {
      //     isLoading = true;
      //   });
      //   await Provider.of<Products>(context, listen: false).fetchAndSetProducts(
      //       token: Provider.of<Auth>(context, listen: false).token);
      //   if (!mounted) return;
      //   setState(() {
      //     _loadedProduct = Provider.of<Products>(context, listen: false);
      //   });
      //   Provider.of<Auth>(context, listen: false).autoLogin = false;
      // }
      // if (!Provider.of<Auth>(context, listen: false).autoLogin) {
      //   if (!mounted) return;
      //   setState(() {
      //     _loadedProduct = Provider.of<Products>(context, listen: false);
      //   });
      // }

      // isInit = false;
      // if (!mounted) return;
      // setState(() {
      //   isLoading = false;
      // });
      super.didChangeDependencies();
    }
  }

  @override
  void dispose() {
    // scrollBottomBarController.removeListener(() {});
    super.dispose();
  }

  // void myScroll() async {
  //   scrollBottomBarController.addListener(() {
  //     if (scrollBottomBarController.position.userScrollDirection ==
  //         ScrollDirection.reverse) {
  //       if (!isScrollingDown) {
  //         isScrollingDown = true;
  //         _showAppbar = false;
  //         hideBottomBar();
  //       }
  //     }
  //     if (scrollBottomBarController.position.userScrollDirection ==
  //         ScrollDirection.forward) {
  //       if (isScrollingDown) {
  //         isScrollingDown = false;
  //         _showAppbar = true;
  //         showBottomBar();
  //       }
  //     }
  //   });
  // }

  showPicker({BuildContext context, prodcut, color, cert, diamond, build}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black45,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50.0),
        topRight: Radius.circular(50.0),
      )),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(5.0),
          child: AddToCart(
            product: prodcut,
            image: color,
            cert: cert,
            diamond: diamond,
            build: build,
            updateCart: false,
          ),
        );
      },
    );
  }

  void dateSelect(context, dX, dY, product) {
    var alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.black.withOpacity(0.3),
      elevation: 100.0,
      content: Container(
        height: ScreenUtil().setHeight(315),
        // width: ScreenUtil().setHeight(411),
        // width: 700.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                product.styleNumber,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy Black',
                  fontSize: ScreenUtil().setSp(25, allowFontScalingSelf: true),
                ),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(
                    label: Text(
                  'Specifications',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
                DataColumn(
                    label: Text(
                  'Units',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text(
                    'Gold Weight',
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    product.goldWeight.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                ]),
                DataRow(cells: [
                  DataCell(Text(
                    'Diamond Weight',
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    product.diamondWeight.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                ]),
                DataRow(cells: [
                  DataCell(Text(
                    'Diamond Count',
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    product.diamondCount.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return Stack(
        //   children: <Widget>[
        //     Positioned(
        //       top: dY,
        //       left: dX,
        //       right: dX,
        //       child: BackdropFilter(
        //         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        //         child: alertDialog,
        //       ),
        //     ),
        //   ],
        // );
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: alertDialog,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final scaff = Scaffold.of(context);
    // final Color themeColor = Theme.of(context).primaryColor;
    // print('PP No of Products: ${widget.products.length}');
    var size = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    print(size.height);
    print(size.width.toString() + 'DC');
    return isLoadingg
        ? Center(child: CircularProgressIndicator())
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    GridView.builder(
                      controller: widget.scrollController,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(left: 25, right: 26),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 15.0,
                      ),
                      itemCount: widget.products.length,
                      itemBuilder: (context, i) => Stack(
                        // alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(159),
                            height: ScreenUtil().setHeight(150),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.37),
                                  offset: Offset(2,5),
                                )
                              ]
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetail(),
                                  ),
                                );
                              },
                              onLongPressEnd: (details) {},
                              onLongPressStart: (details) {
                                dateSelect(
                                    context,
                                    details.globalPosition.dx,
                                    details.globalPosition.dy,
                                    widget.products[i]);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 21, right: 4),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.amber,
                                          child: Image(
                                            height: ScreenUtil().setHeight(122),
                                            width: ScreenUtil().setWidth(117),
                                            image: widget.color == 0
                                                ? NetworkImage(
                                                    widget.products[i].yellow)
                                                : widget.color == 1
                                                    ? NetworkImage(widget
                                                        .products[i].white)
                                                    : widget.color == 2
                                                        ? NetworkImage(widget
                                                            .products[i].rose)
                                                        : NetworkImage(widget
                                                            .products[i]
                                                            .yellow),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: RotatedBox(
                                            quarterTurns: -1,
                                            child: Text(
                                              widget.products[i].styleNumber,
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(14,
                                                    allowFontScalingSelf: true),
                                                fontFamily: 'Gilroy Regular',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "5000 ₹",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(18,
                                          allowFontScalingSelf: true),
                                      fontFamily: 'Gilroy Regular',
                                    ),
                                  ),
                                  Provider.of<Pagination>(context, listen: false)
                                              .isPriced &&
                                          widget.select != 'fav'
                                      ? OutlineButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Request Prices',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: ScreenUtil().setSp(15,
                                                    allowFontScalingSelf:
                                                        true)),
                                          ),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0),
                                          shape: RoundedRectangleBorder(
                                              // side: BorderSide(color: kPrimaryColor, width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(18.0)))
                                  //     : widget.diamond == 0 && widget.select != 'fav'
                                  //         ? Text(widget.products[i].vVS_EF)
                                  //         : widget.diamond == 1 && widget.select != 'fav'
                                  //             ? Text(widget.products[i].vVS_FG)
                                  //             : widget.diamond == 2 &&
                                  //                     widget.select != 'fav'
                                  //                 ? Text(widget
                                  //                     .products[i].vVS_VS_FG)
                                  //                 : widget.diamond == 3 &&
                                  //                         widget.select != 'fav'
                                  //                     ? Text(widget
                                  //                         .products[i].vS_FG)
                                  //                     : widget.diamond == 4 &&
                                  //                             widget.select != 'fav'
                                  //                         ? Text(widget.products[i].sI_HI)
                                  //                         : Text(''),

                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //   // crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: <Widget>[
                                  //     IconButton(
                                  //       icon: Icon(widget.products[i].isFavourite
                                  //           ? Icons.favorite
                                  //           : Icons.favorite_border),
                                  //       color: kPrimaryColor,
                                  //       onPressed: () async {
                                  //         await Provider.of<Products>(context, listen: false)
                                  //             .toogleFavourite(
                                  //                 styleNumber: widget.products[i].styleNumber,
                                  //                 context: context);
                                  //         setState(() {});
                                  //       },
                                  //     ),
                                  //     IconButton(
                                  //       icon: Icon(Icons.shopping_cart),
                                  //       color: kPrimaryColor,
                                  //       onPressed: () async {
                                  //         await Provider.of<Cart>(context, listen: false)
                                  //             .addCart(widget.products[i], context);

                                  //         showFloatingFlushbar(context,
                                  //             'Product has been added to your favourites"❤"');
                                  //       },
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 20.0,
                                  // ),
                                  // Text(
                                  //   '\$52.90',
                                  //   style: TextStyle(
                                  //     fontSize: 20.0,
                                  //     fontFamily: 'Gilroy',
                                  //   ),
                                  // ),
                                :Text('')],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    height: ScreenUtil().setHeight(29),
                                    width: ScreenUtil().setWidth(29),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF34B0D9),
                                          Color(0xFF3685CB),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Icon(
                                      widget.products[i].isFavourite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.white,
                                      size: ScreenUtil().setSp(16,allowFontScalingSelf: true),
                                    ),
                                  ),
                                  onTap: () async {
                                    await Provider.of<Pagination>(context,
                                            listen: false)
                                        .toogleFavourite(
                                            styleNumber:
                                                widget.products[i].styleNumber,
                                            context: context,
                                            select: widget.select);
                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(6.0),
                                ),
                                GestureDetector(
                                  child: Container(
                                    height: ScreenUtil().setHeight(29),
                                    width: ScreenUtil().setWidth(29),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF34B0D9),
                                          Color(0xFF3685CB),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: ScreenUtil().setSp(13,allowFontScalingSelf: true),
                                    ),
                                  ),
                                  onTap: () async {
                                    showPicker(
                                        context: context,
                                        color: widget.color,
                                        diamond: widget.diamond,
                                        cert: widget.cert,
                                        build: widget.build,
                                        prodcut: widget.products[i]);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(93),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                CircularProgressIndicator(
                  backgroundColor: Colors.cyan,
                )
            ],
          );

    //body: ListView(
    //   children: <Widget>[
    //     SizedBox(height: 5.0),
    //     Container(
    //         padding: EdgeInsets.only(right: 15.0),
    //         width: MediaQuery.of(context).size.width - 30.0,
    //         height: MediaQuery.of(context).size.height - 50.0,
    //         child: GridView.builder(
    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 2,
    //             crossAxisSpacing: 1.0,
    //             mainAxisSpacing: 15.0,
    //             childAspectRatio: 0.8,
    //           ),
    //           itemCount: widget.products.length,
    //           itemBuilder: (ctx, i) => _buildCard(widget.products[i].styleNumber, 'Price',
    //               widget.products[i].main, false,widget. products[i].isFavourite, context,widget.products[i].weight,widget.products[i].gWeight,widget.products[i].count,widget.products[i],scaff),
    //         )),
    //     SizedBox(height: 15.0)
    //   ],
    // ),
  }

  // Widget _buildCard(
  //     String name,
  //     String price,
  //     String imgPath,
  //     bool added,
  //     bool isFavorite,
  //     context,
  //     bool weight,
  //     bool gWeight,
  //     bool count,
  //     product,
  //     scaff) {
  //   print(imgPath);
  //   final Color themeColor = Theme.of(context).primaryColor;
  //   return Padding(
  //       padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20, right: 5.0),
  //       child: Container(
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(15.0),
  //               boxShadow: [
  //                 BoxShadow(
  //                     color: Colors.grey.withOpacity(0.2),
  //                     spreadRadius: 3.0,
  //                     blurRadius: 5.0)
  //               ],
  //               color: Colors.white),
  //           child: Column(children: [
  //             Padding(
  //                 padding: EdgeInsets.all(5.0),
  //                 child:
  //                     Row(mainAxisAlignment: MainAxisAlignment.end, children: [
  //                   isFavorite
  //                       ? GestureDetector(
  //                           child: Icon(Icons.favorite, color: themeColor),
  //                           onTap: () async {
  //                             await Provider.of<Products>(context,
  //                                     listen: false)
  //                                 .toogleFavourite(
  //                                     styleNumber: product.styleNumber,
  //                                     context: context);
  //                             setState(() {});
  //                           },
  //                         )
  //                       : GestureDetector(
  //                           onTap: () async {
  //                             await Provider.of<Products>(context,
  //                                     listen: false)
  //                                 .toogleFavourite(
  //                                     styleNumber: product.styleNumber,
  //                                     context: context);
  //                             setState(() {});
  //                           },
  //                           child:
  //                               Icon(Icons.favorite_border, color: themeColor))
  //                 ])),
  //             Container(
  //               height: 120.0,
  //               width: 75.0,
  //               decoration: BoxDecoration(
  //                 image: DecorationImage(
  //                   image: NetworkImage(imgPath),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 7.0),
  //             Text(price,
  //                 style: TextStyle(
  //                     color: themeColor, fontFamily: 'Varela', fontSize: 14.0)),
  //         ,allowFontScalingSelf: true    Text(name,
  //                 style: TextStyle(
  //                     color: Color(0xFF575E67),
  //                     fontFamily: 'Varela',
  //                     fontSize: 14.0)),
  //         ,allowFontScalingSelf: true    Padding(
  //                 padding: EdgeInsets.all(8.0),
  //                 child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
  //             Padding(
  //                 padding: EdgeInsets.only(left: 5.0, right: 5.0),
  //                 child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       if (!added) ...[
  //                         Icon(Icons.shopping_basket,
  //                             color: themeColor, size: 12.0),
  //                         GestureDetector(
  //                             onTap: () async {
  //                               await Provider.of<Cart>(context, listen: false)
  //                                   .addCart(product, context);
  //                               scaff.showSnackBar(new SnackBar(
  //                                   content: new Text('product added')));
  //                             },
  //                             child: Text('Add to cart',
  //                                 style: TextStyle(
  //                                     fontFamily: 'Varela',
  //                                     color: themeColor,
  //                                     fontSize: 12.0)))
  //         ,allowFontScalingSelf: true              ],
  //                       if (added) ...[
  //                         Icon(Icons.remove_circle_outline,
  //                             color: themeColor, size: 12.0),
  //                         Text('3',
  //                             style: TextStyle(
  //                                 fontFamily: 'Varela',
  //                                 color: themeColor,
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 12.0)),
  //         ,allowFontScalingSelf: true                Icon(Icons.add_circle_outline,
  //                             color: themeColor, size: 12.0),
  //                       ]
  //                     ])),
  //             if (count)
  //               Text('Diamond Count : ' +
  //                   product.diamondCount.toString() +
  //                   ' PCS'),
  //             if (weight)
  //               Text('Diamond Weight : ' +
  //                   product.diamondWeight.toString() +
  //                   ' CT'),
  //             if (gWeight)
  //               Text('Gold Weight : ' + product.goldWeight.toString() + ' GM'),
  //           ])));
  // }
}

// GET /product/paginated?select=all&sortby=styleNumber&sort=1&page=1&quant=20 200 383.490 ms - 13838
// GET /product/paginated?select=featured&sortby=styleNumber&sort=1&page=1&quant=20 200 231.117 ms - 13842
// GET /product/paginated?select=new&sortby=styleNumber&sort=1&page=1&quant=20 200 236.191 ms - 13840
// GET /product/paginated?select=highestSelling&sortby=styleNumber&sort=1&page=1&quant=20 200 200.590 ms - 13836
// GET /product/paginated?select=fancyDiamond&sortby=styleNumber&sort=1&page=1&quant=20 200 222.539 ms - 13835

// GET /product/paginated?select=featured&sortby=styleNumber&sort=1&page= 2 &quant=20 200 206.111 ms - 13848

// GET /product/paginated?select=all&sortby=diamondWeight&sort=-1&page=1&quant=20 200 199.119 ms - 13895
// GET /product/paginated?select=featured&sortby=diamondWeight&sort=-1&page=1&quant=20 200 203.049 ms - 13880
// GET /product/paginated?select=new&sortby=diamondWeight&sort=-1&page=1&quant=20 200 197.254 ms - 13874

// GET /product/paginated?select=featured&sortby=styleNumber&sort=1&page= 3 &quant=20 200 209.461 ms - 13847

// GET /product/paginated?select=highestSelling&sortby=diamondWeight&sort=-1&page=1&quant=20 200 196.481 ms - 13877
// GET /product/paginated?select=fancyDiamond&sortby=diamondWeight&sort=-1&page=1&quant=20 200 217.105 ms - 13876

// GET /product/paginated?select=featured&sortby=styleNumber&sort=1&page= 4 &quant=20 200 202.454 ms - 13841
