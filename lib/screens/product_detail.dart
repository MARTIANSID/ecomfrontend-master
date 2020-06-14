import 'package:Flutter/constant/const.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _current = 0;
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                print(MediaQuery.of(context).padding.top);
                                print(size.width);
                                print(size.height);
                                Navigator.of(context).pop();
                              },
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          iconSize: ScreenUtil().setSp(30,allowFontScalingSelf: true),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: ScreenUtil().setHeight(77.5),
              left: 0.0,
              right: 0.0,
              child: Container(
                height: ScreenUtil().setHeight(700),
                width: size.width,
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: <Color>[
                //       // Color(0xFF0F2985),
                //       // Colors.blue[400]
                //       kPrimaryLightColor,
                //       Colors.white
                //     ],
                //     stops: [0.4, 1],
                //     begin: Alignment.topRight,
                //     end: Alignment.bottomCenter,
                //   ),
                // ),
                // color: Colors.amber,
                margin: EdgeInsets.only(top: 25.0),
                // padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(155),
                      child: CarouselSlider(
                        height: ScreenUtil().setHeight(155),
                        initialPage: 0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        reverse: false,
                        enableInfiniteScroll: true,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(milliseconds: 2000),
                        pauseAutoPlayOnTouch: Duration(seconds: 10),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          setState(() {
                            _current = index;
                          });
                        },
                        items: imgList.map((imgUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: ScreenUtil().setWidth(411),
                                height: ScreenUtil().setHeight(69.75),
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  imgUrl,
                                  fit: BoxFit.fill,
                                ),
                                // child: PinchZoomImage(
                                //   image: Image.network(
                                //     imgUrl,
                                //     fit: BoxFit.contain,
                                //   ),
                                //   zoomedBackgroundColor:
                                //       Color.fromRGBO(240, 240, 240, 1.0),
                                //   hideStatusBarWhileZooming: true,
                                //   onZoomStart: () {
                                //     print('Zoom started');
                                //   },
                                //   onZoomEnd: () {
                                //     print('Zoom finished');
                                //   },
                                // ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: map<Widget>(
                        imgList,
                        (index, url) {
                          return Container(
                            width: ScreenUtil().setWidth(10),
                            height: ScreenUtil().setHeight(10),
                            margin: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(80.0),
                          bottomRight: Radius.circular(80.0),
                          bottomLeft: Radius.circular(80.0),
                        ),
                        // border: Border.all(
                        //   color: kPrimaryColor,
                        //   width: 2.0,
                        // ),
                        color: Colors.white,
                        // boxShadow: <BoxShadow>[
                        //   BoxShadow(
                        //     color: Colors.black12,
                        //     blurRadius: 10.0,
                        //     offset: Offset(0.0, 10.0),
                        //   ),
                        // ],
                        // gradient: LinearGradient(
                        //   colors: <Color>[
                        //     // Color(0xFF0F2985),
                        //     // Colors.blue[400]
                        //     kPrimaryColor,
                        //     Colors.white
                        //   ],
                        //   stops: [0.05, 1],
                        //   begin: Alignment.topRight,
                        //   end: Alignment.bottomCenter,
                        // ),
                      ),
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 70.0, 0.0),
                      width: ScreenUtil().setWidth(411),
                      height: ScreenUtil().setHeight(392.5),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'NP104',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(29,allowFontScalingSelf: true),
                                    fontFamily: 'Gilroy Black',
                                  ),
                                ),
                                Text(
                                  '20,000 ₹',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(29,allowFontScalingSelf: true),
                                    fontFamily: 'Gilroy Black',
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                              // height: size.height * 0.01,
                              child: Divider(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Description: ',
                              style: TextStyle(
                                fontFamily: 'Gilroy Black',
                                fontSize: ScreenUtil().setSp(16,allowFontScalingSelf: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              // child: Text(
                              //   'Gold Weight'+'2.966'+'grams',
                              //   style: TextStyle(
                              //     fontSize: 14.0,
                              //   ),
                              //   textAlign: TextAlign.justify,
                              // ),
                              child: DataTable(
                                // sortAscending: true,
                                columns: [
                                  DataColumn(label: Text('Specifications',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),fontWeight: FontWeight.bold),)),
                                  DataColumn(label: Text('Units',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),fontWeight: FontWeight.bold),)),
                                ],
                                rows: [
                                  DataRow(cells: [
                                    DataCell(Text('Gold Weight',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
                                    DataCell(Text('2.99 grams',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('Diamond Weight',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
                                    DataCell(Text('1.23 carat',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('Diamond Count',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
                                    DataCell(Text('95 pieces',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
                                  ]),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(28.675),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: kPrimaryColor,
                            onPressed: () {},
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  size: ScreenUtil().setSp(25,allowFontScalingSelf: true),
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(10),
                                ),
                                Text(
                                  "Favourites",
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: ScreenUtil().setSp(18,allowFontScalingSelf: true),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: kPrimaryColor,
                            onPressed: () {},
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.shopping_cart,
                                  size: ScreenUtil().setSp(25,allowFontScalingSelf: true),
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(10),
                                ),
                                Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: ScreenUtil().setSp(18,allowFontScalingSelf: true),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0.0,
              top: ScreenUtil().setHeight(400),
              child: Container(
                width: ScreenUtil().setWidth(49.731),
                height: ScreenUtil().setHeight(310),
                margin: EdgeInsets.only(left: 20.0),
                child: Wrap(
                  direction: Axis.vertical,
                  children: <Widget>[
                    RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        'Product in Detail',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: ScreenUtil().setSp(25,allowFontScalingSelf: true),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
