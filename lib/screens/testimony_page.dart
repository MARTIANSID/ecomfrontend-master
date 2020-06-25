import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/testimony.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TestimonyPage extends StatefulWidget {
  @override
  _TestimonyPageState createState() => _TestimonyPageState();
}

class _TestimonyPageState extends State<TestimonyPage> {
  bool isLoading = false;

  TextEditingController commentEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(seconds: 0), () async {
      setState(() {
        isLoading = true;
      });
      await Provider.of<Testimony>(context, listen: false)
          .getTestimony(context: context);
      setState(() {
        isLoading = false;
      });
    });
  }

  double rating = 0;
  // void update(v){
  //   setState(() {
  //     rating=v;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ScreenUtil.init(
      context,
      width: 411.42857142857144,
      height: 774.8571428571429,
      allowFontScaling: true,
    );
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white,
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
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: kPrimaryColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                color: Colors.white,
                                // padding: EdgeInsets.all(10.0),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      double rating = 0.0;
                                      return SimpleDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        children: <Widget>[
                                          Container(
                                            height: ScreenUtil().setHeight(342),
                                            width: ScreenUtil().setWidth(400),
                                            padding: EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Wrtie a Testimony',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy Medium',
                                                    fontSize: ScreenUtil().setSp(
                                                        17,
                                                        allowFontScalingSelf:
                                                            true),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(20),
                                                ),
                                                ShaderMask(
                                                  blendMode: BlendMode.srcIn,
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
                                                  child: SmoothStarRating(
                                                    allowHalfRating: true,

                                                    onRated: (v) {
                                                      // update(v);
                                                      setState(() {
                                                        rating = v;
                                                      });
                                                      print(rating);
                                                    },
                                                    starCount: 5,
                                                    rating: rating,
                                                    size: 40.0,
                                                    isReadOnly: false,
                                                    filledIconData: Icons.star,
                                                    halfFilledIconData:
                                                        Icons.star_half,
                                                    // color: Colors
                                                    //     .amber,
                                                    // borderColor: Colors
                                                    //     .yellowAccent,
                                                    spacing: 5.0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(20),
                                                ),
                                                TextField(
                                                  maxLines: 3,
                                                  maxLength: 245,
                                                  controller:
                                                      commentEditingController,

                                                  // expands: true,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          'Leave a comment!'),
                                                ),
                                                SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(20),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    await Provider.of<
                                                                Testimony>(
                                                            context,
                                                            listen: false)
                                                        .writeTestimony(
                                                            context: context,
                                                            comment:
                                                                commentEditingController
                                                                    .text,
                                                            rating: rating);
                                                    await Provider.of<
                                                                Testimony>(
                                                            context,
                                                            listen: false)
                                                        .getTestimony(
                                                            context: context);
                                                    setState(() {
                                                      isLoading = false;
                                                    });

                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    width: ScreenUtil()
                                                        .setWidth(180),
                                                    height: ScreenUtil()
                                                        .setHeight(43),
                                                    // padding: EdgeInsets.all(20.0),
                                                    child: Center(
                                                      child: Text(
                                                        'ADD TO CART',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy Bold',
                                                          color: Colors.white,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14,
                                                                  allowFontScalingSelf:
                                                                      true),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/vector17.png'),
                                                      fit: BoxFit.contain,
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.border_color,
                                      size: ScreenUtil().setSp(20,
                                          allowFontScalingSelf: true),
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Write a Testimony',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(17,
                                              allowFontScalingSelf: true),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: ScreenUtil().setHeight(108.5),
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: ScreenUtil().setHeight(666.5),
                      width: ScreenUtil().setWidth(411),
                      // color: Colors.amber,
                      margin: EdgeInsets.only(top: 25.0),
                      // padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Testimonies',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Gilroy Black',
                              fontSize: ScreenUtil()
                                  .setSp(35, allowFontScalingSelf: true),
                            ),
                          ),
                          Text(
                            Provider.of<Testimony>(context, listen: false)
                                    .userTestimony
                                    .totalTestimony
                                    .toString() +
                                ' reviews',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Gilroy Black',
                              fontSize: ScreenUtil()
                                  .setSp(15, allowFontScalingSelf: true),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 60.0, right: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        Provider.of<Testimony>(context,
                                                listen: false)
                                            .userTestimony
                                            .rating
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(15,
                                              allowFontScalingSelf: true),
                                        ),
                                      ),
                                    ),
                                    SmoothStarRating(
                                      allowHalfRating: true,
                                      // onRated: (v) {
                                      //   // update(v);
                                      //   setState(() {
                                      //     rating = v;
                                      //   });
                                      //   print(rating);
                                      // },
                                      starCount: 5,
                                      rating: double.parse(
                                          Provider.of<Testimony>(context,
                                                  listen: false)
                                              .userTestimony
                                              .rating),
                                      size: ScreenUtil().setSp(20,
                                          allowFontScalingSelf: true),
                                      isReadOnly: true,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      color: Colors.amber[300],
                                      borderColor: Colors.black,
                                      spacing: 2.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 10.0, 30.0, 10.0),
                            child: Divider(
                              height: 2.0,
                              color: Colors.grey[400],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 50.0, right: 50.0),
                                  child: Divider(
                                    color: Colors.grey[700],
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  Provider.of<Testimony>(context, listen: true)
                                      .userTestimony
                                      .testimonies
                                      .length,
                              itemBuilder: (context, index) {
                                DateTime dateFormat =
                                    DateFormat("E MMM dd yyyy HH:mm:ss").parse(
                                        Provider.of<Testimony>(context,
                                                listen: false)
                                            .userTestimony
                                            .testimonies[index]['createdAt']);
                                return Column(
                                  children: <Widget>[
                                    Container(
                                      height: ScreenUtil().setHeight(310),
                                      width: ScreenUtil().setWidth(411),
                                      padding: EdgeInsets.all(5.0),
                                      // color: Colors.white,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            // alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            height: ScreenUtil().setHeight(75),
                                            width: ScreenUtil().setWidth(75),
                                            decoration: BoxDecoration(
                                              // borderRadius: BorderRadius.circular(37.5),
                                              border: Border.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: 3.0,
                                              ),
                                              shape: BoxShape.circle,
                                              // image: DecorationImage(
                                              //   image: AssetImage('assets/images/chris.jpg'),
                                              // ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: ScreenUtil()
                                                        .setWidth(255),
                                                    child: Text(
                                                      Provider.of<Testimony>(
                                                                  context,
                                                                  listen: false)
                                                              .userTestimony
                                                              .testimonies[
                                                          index]['comment'],
                                                      style: TextStyle(
                                                        fontFamily: 'Varela',
                                                        fontSize: ScreenUtil()
                                                            .setSp(14,
                                                                allowFontScalingSelf:
                                                                    true),
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0.0,
                                                          bottom: 7.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 15.0,
                                                        ),
                                                        child: Text(
                                                          Provider.of<Testimony>(
                                                                  context,
                                                                  listen: false)
                                                              .userTestimony
                                                              .testimonies[
                                                                  index]
                                                                  ['rating']
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: ScreenUtil()
                                                                .setSp(13,
                                                                    allowFontScalingSelf:
                                                                        true),
                                                          ),
                                                        ),
                                                      ),
                                                      SmoothStarRating(
                                                        allowHalfRating: true,
                                                        // onRated: (v) {
                                                        //   // update(v);
                                                        //   setState(() {
                                                        //     rating = v;
                                                        //   });
                                                        //   print(rating);
                                                        // },
                                                        starCount: 5,
                                                        // rating: 3.4,
                                                        rating: double.parse(
                                                            Provider.of<Testimony>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .userTestimony
                                                                .testimonies[
                                                                    index]
                                                                    ['rating']
                                                                .toString()),
                                                        size: ScreenUtil().setSp(
                                                            20,
                                                            allowFontScalingSelf:
                                                                true),
                                                        isReadOnly: true,
                                                        filledIconData:
                                                            Icons.star,
                                                        halfFilledIconData:
                                                            Icons.star_half,
                                                        color:
                                                            Colors.amber[300],
                                                        borderColor:
                                                            Colors.black,
                                                        spacing: 2.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: ScreenUtil()
                                                      .setWidth(255),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        // color: Colors.amber,
                                                        child: SizedBox(
                                                          width: ScreenUtil()
                                                              .setWidth(165),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                Provider.of<Testimony>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .userTestimony
                                                                        .testimonies[
                                                                            index]
                                                                            [
                                                                            'fullName']
                                                                        .toString() +
                                                                    ',',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  fontSize: ScreenUtil().setSp(
                                                                      14,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                ),
                                                              ),
                                                              Text(
                                                                Provider.of<Testimony>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .userTestimony
                                                                    .testimonies[
                                                                        index]
                                                                        ['firm']
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: ScreenUtil().setSp(
                                                                      17,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        // '11.05.2020',
                                                        DateFormat('dd.MM.yyyy')
                                                            .format(dateFormat),
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontFamily: 'Gilroy',
                                                          fontSize: ScreenUtil()
                                                              .setSp(14,
                                                                  allowFontScalingSelf:
                                                                      true),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    index ==
                                            Provider.of<Testimony>(context,
                                                        listen: true)
                                                    .userTestimony
                                                    .testimonies
                                                    .length -
                                                1
                                        ? SizedBox(
                                            height: ScreenUtil().setHeight(40),
                                          )
                                        : SizedBox(
                                            height: 0.0,
                                          ),
                                  ],
                                );
                              },
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
