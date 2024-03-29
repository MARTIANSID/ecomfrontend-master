import 'package:Flutter/providers/order.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'myorder_detail.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> with TickerProviderStateMixin {
  TabController _tabController;

  bool isLoading = false;

  List<String> str = [
    'Processing',
    'Manufacturing',
    'Certification',
    'Delivery',
    'Completed',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 0), () async {
      try {
        await Provider.of<Orders>(context, listen: false)
            .getOrders(context: context);
        Provider.of<Orders>(context, listen: false).completeOrderSeperation();
        // print(
        // Provider.of<Orders>(context, listen: false).completedOrders.length);
        // print(Provider.of<Orders>(context, listen: false).orderProducts.length);
      } catch (err) {
        dataSelect(
            context: context,
            titleText: 'Alert!',
            buttonText: 'Okay',
            contentText: err.toString(),
            onPressed: () {
              Navigator.pop(context);
            },
            gif: "assets/images/alert.gif");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  String orderStatusCheck(status) {
    switch (status) {
      case 1:
        return str[0];
        break;
      case 2:
        return str[1];
        break;
      case 3:
        return str[2];
        break;
      case 4:
        return str[3];
        break;
      case 5:
        return str[4];
        break;
    }
  }

  Widget closeApp(BuildContext context, orderProducts) {
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
      itemCount: orderProducts.length,
      itemBuilder: (context, index) {
        int quants = 0;
        // orderProducts[index].products.foreach((element) {
        //   quants = quants + element.quantity;
        // });
        for (var i = 0; i < orderProducts[index].products.length; i++) {
          // setState(() {
          quants = quants + orderProducts[index].products[i].quantity;
          // });
        }

        DateTime dateTime =
            DateFormat("MMM dd yyyy").parse(orderProducts[index].datePlaced);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyOrderDetailPage(
                    orderProducts: orderProducts[index],
                    products: orderProducts[index].products,
                    index: index),
              ),
            );
          },
          child: Container(
            width: ScreenUtil().setWidth(411),
            height: ScreenUtil().setHeight(155),
            margin: EdgeInsets.only(
              bottom: 20.0,
              left: 15.0,
              right: 15.0,
            ),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.37),
                  offset: Offset(2, 5),
                )
              ],
              borderRadius: BorderRadius.circular(15.0),
              // border: Border.all(
              //   color: Colors.grey,
              //   width: 1.0,
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '#' + orderProducts[index].orderNumber.toString(),
                      style: TextStyle(
                          fontFamily: 'Gilroy Medium',
                          fontSize: ScreenUtil()
                              .setSp(27, allowFontScalingSelf: true)),
                    ),
                    Text(
                      // orderProducts[index].products.length.toString(),
                      quants == 1
                          ? quants.toString() + " Nose Pin"
                          : quants.toString() + " Nose Pins",
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
                            orderStatusCheck(orderProducts[index].status),
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
                                // orderProducts[index].datePlaced,
                                DateFormat("MMM dd, yyyy")
                                    .format(dateTime.add(Duration(days: 20))),
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
                                      // print(MediaQuery.of(context).padding.top);
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
                      padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: TabBar(
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
                                      fontSize: ScreenUtil().setSp(19,
                                          allowFontScalingSelf: true),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Completed',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy Regular',
                                      fontSize: ScreenUtil().setSp(19,
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
                                Provider.of<Orders>(context, listen: false)
                                            .orderProducts
                                            .length ==
                                        0
                                    ? Container(
                                        width: ScreenUtil().setHeight(350),
                                        child: Center(
                                          child: Text(
                                            // 'There aren\'t any Favourites product added yet!',
                                            "😕 No orders yet!",
                                            style: TextStyle(
                                              fontFamily: 'Gilory Regular',
                                              color: Color(0xFFA49797),
                                              fontSize: ScreenUtil().setSp(17,
                                                  allowFontScalingSelf: true),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : closeApp(
                                        context,
                                        Provider.of<Orders>(context,
                                                listen: false)
                                            .orderProducts),
                                Provider.of<Orders>(context, listen: false)
                                            .completedOrders
                                            .length ==
                                        0
                                    ? Container(
                                        width: ScreenUtil().setHeight(350),
                                        child: Center(
                                          child: Text(
                                            // 'There aren\'t any Favourites product added yet!',
                                            "😕 No orders completed yet!",
                                            style: TextStyle(
                                              fontFamily: 'Gilory Regular',
                                              color: Color(0xFFA49797),
                                              fontSize: ScreenUtil().setSp(17,
                                                  allowFontScalingSelf: true),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : closeApp(
                                        context,
                                        Provider.of<Orders>(context,
                                                listen: false)
                                            .completedOrders),
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
