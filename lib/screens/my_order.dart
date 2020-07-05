import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/order.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'myorder_detail.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> with TickerProviderStateMixin {
  TabController _tabController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);

    if (Provider.of<Orders>(context, listen: false).orderProducts.isEmpty)
      setState(() {
        isLoading = true;
      });
    Future.delayed(Duration(seconds: 0), () async {
      try {
        if (Provider.of<Orders>(context, listen: false).orderProducts.isEmpty) {
          await Provider.of<Orders>(context, listen: false)
              .getOrders(context: context);
        }
      } catch (err) {
        dataSelect(context, 'Alert!', '$err', 'Okay', () {
          Navigator.pop(context);
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Widget closeApp(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ScreenUtil.init(
      context,
      width: 411.42857142857144,
      height: 774.8571428571429,
      allowFontScaling: true,
    );
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount:
          Provider.of<Orders>(context, listen: false).orderProducts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyOrderDetailPage(
                      products: Provider.of<Orders>(context, listen: false)
                          .orderProducts[index]
                          .products,
                      index: index)),
            );
          },
          child: Container(
            width: ScreenUtil().setWidth(330),
            height: ScreenUtil().setHeight(155),
            margin: EdgeInsets.only(bottom: 20.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              // color: Colors.amber,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '#' +
                          Provider.of<Orders>(context, listen: false)
                              .orderProducts[index]
                              .orderNumber
                              .toString(),
                      style: TextStyle(
                          fontFamily: 'Gilroy Medium',
                          fontSize: ScreenUtil()
                              .setSp(27, allowFontScalingSelf: true)),
                    ),
                    Text(
                      Provider.of<Orders>(context, listen: false)
                          .orderProducts[index]
                          .products
                          .length
                          .toString(),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize:
                            ScreenUtil().setSp(13, allowFontScalingSelf: true),
                        fontFamily: 'Gilroy Regular',
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setWidth(38.75),
                  width: ScreenUtil().setWidth(370),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Order Status',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontFamily: 'Gilroy Regular',
                              fontSize: ScreenUtil()
                                  .setSp(13, allowFontScalingSelf: true),
                            ),
                          ),
                          Text(
                            'Received at Dock',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Gilroy Regular',
                              fontSize: ScreenUtil()
                                  .setSp(15, allowFontScalingSelf: true),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: VerticalDivider(
                          color: Colors.blue,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Approx Arrival Date',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontFamily: 'Gilroy Regular',
                              fontSize: ScreenUtil()
                                  .setSp(13, allowFontScalingSelf: true),
                            ),
                          ),
                          SizedBox(
                            // height: size.height * 0.07,
                            width: size.width * 0.4,
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
                                Provider.of<Orders>(context, listen: false)
                                    .orderProducts[index]
                                    .datePlaced,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gilroy Regular',
                                  fontSize: ScreenUtil()
                                      .setSp(15, allowFontScalingSelf: true),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(size.width);
    print(size.height);
    ScreenUtil.init(
      context,
      width: 411.42857142857144,
      height: 774.8571428571429,
      allowFontScaling: true,
    );
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      print(MediaQuery.of(context).padding.top);
                                      Navigator.of(context).pop();
                                    },
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Text(
                                  'My Orders',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil()
                                        .setSp(25, allowFontScalingSelf: true),
                                    fontFamily: 'Gilroy Medium',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: ScreenUtil().setHeight(116.25),
                    left: 0.0,
                    child: Container(
                      // color: Colors.amber,
                      width: ScreenUtil().setWidth(411),
                      height: ScreenUtil().setHeight(655),
                      padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          TabBar(
                            controller: _tabController,
                            // indicatorColor: Colors.cyan,
                            labelColor: Colors.white,
                            isScrollable: true,
                            // labelPadding: EdgeInsets.only(right: size.width / 12),
                            unselectedLabelColor: Color(0xFFCDCDCD),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF34BDDD),
                                  Color(0xFF3680C9),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),

                            // indicatorPadding: EdgeInsets.all(10.0),
                            //indicator: UnderlineTabIndicator(insets:EdgeI`nsets.only(right:20.0),borderSide:BorderSide(color:Colors.pink),),
                            tabs: [
                              Tab(
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy Regular',
                                    fontSize: ScreenUtil()
                                        .setSp(19, allowFontScalingSelf: true),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Completed',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy Regular',
                                    fontSize: ScreenUtil()
                                        .setSp(19, allowFontScalingSelf: true),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Expanded(
                            // height: 200.0,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                closeApp(context),
                                closeApp(context),
                              ],
                            ),
                          ),
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
