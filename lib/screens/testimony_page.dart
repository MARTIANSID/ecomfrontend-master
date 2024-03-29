import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/testimony.dart';
import 'package:Flutter/providers/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../widgets/snackbar.dart';

class TestimonyPage extends StatefulWidget {
  @override
  _TestimonyPageState createState() => _TestimonyPageState();
}

class _TestimonyPageState extends State<TestimonyPage> {
  bool isLoading = false;

  TextEditingController commentEditingController = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey();

  bool flag = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 0), () async {
      // setState(() {
      //   isLoading = true;
      // });
      try {
        await Provider.of<Testimony>(context, listen: false)
            .getTestimony(context: context);
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

  double rating = 0;
  // void update(v){
  //   setState(() {
  //     rating=v;
  //   });
  // }

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
                                      // print(MediaQuery.of(context).padding.top);
                                      // print(size.width);
                                      // print(size.height);
                                      Navigator.of(context).pop();
                                    },
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: ScreenUtil().setHeight(50),
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: ScreenUtil().setHeight(775 - 50),
                      width: ScreenUtil().setWidth(411),
                      // color: Colors.amber,
                      // margin: EdgeInsets.only(top: 25.0),
                      // padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil().setHeight(25),
                          ),
                          Text(
                            'REVIEWS',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Gilroy Medium',
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
                              fontFamily: 'Gilroy Medium',
                              fontSize: ScreenUtil()
                                  .setSp(15, allowFontScalingSelf: true),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
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
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        'Average Review: ${Provider.of<Testimony>(context, listen: false).userTestimony.rating.toString()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF747474),
                                          fontSize: ScreenUtil().setSp(12,
                                              allowFontScalingSelf: true),
                                        ),
                                      ),
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
                                            0, 0, bounds.width, bounds.height),
                                      ),
                                      child: SmoothStarRating(
                                        allowHalfRating: true,
                                        // onRated: (v) {
                                        //   // update(v);
                                        //   setState(() {
                                        //     rating = v;
                                        //   });
                                        // print(rating);
                                        // },
                                        starCount: 5,
                                        rating: (double.parse(
                                            Provider.of<Testimony>(context,
                                                    listen: false)
                                                .userTestimony
                                                .rating)),
                                        size: ScreenUtil().setSp(20,
                                            allowFontScalingSelf: true),
                                        isReadOnly: true,
                                        filledIconData: Icons.star,
                                        halfFilledIconData: Icons.star_half,
                                        color: Colors.amber[300],
                                        borderColor: Colors.black,
                                        spacing: 1.5,
                                      ),
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
                            child: Provider.of<Testimony>(context, listen: true)
                                        .userTestimony
                                        .testimonies
                                        .length ==
                                    0
                                ? Container(
                                    width: ScreenUtil().setHeight(350),
                                    child: Center(
                                      child: Text(
                                        // 'There aren\'t any Favourites product added yet!',
                                        "😕 No testimonies yet. Please be the first to review!",
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
                                : ListView.separated(
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
                                    itemCount: Provider.of<Testimony>(context,
                                            listen: true)
                                        .userTestimony
                                        .testimonies
                                        .length,
                                    itemBuilder: (context, index) {
                                      DateTime dateFormat =
                                          DateFormat("E MMM dd yyyy HH:mm:ss")
                                              .parse(Provider.of<Testimony>(
                                                          context,
                                                          listen: false)
                                                      .userTestimony
                                                      .testimonies[index]
                                                  ['createdAt']);
                                      return Column(
                                        children: <Widget>[
                                          Container(
                                            // height: ScreenUtil().setHeight(310),
                                            width: ScreenUtil().setWidth(411),
                                            padding: EdgeInsets.all(5.0),
                                            // color: Colors.white,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  width:
                                                      ScreenUtil().setWidth(10),
                                                ),
                                                Container(
                                                  height: ScreenUtil()
                                                      .setHeight(55),
                                                  width:
                                                      ScreenUtil().setWidth(55),
                                                  decoration: BoxDecoration(
                                                    // borderRadius: BorderRadius.circular(37.5),
                                                    // border: Border.all(
                                                    //   color: Colors.black,
                                                    //   style: BorderStyle.solid,
                                                    //   width: 3.0,
                                                    // ),
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  padding: EdgeInsets.all(2),
                                                  child: Container(
                                                    height: ScreenUtil()
                                                        .setHeight(53),
                                                    width: ScreenUtil()
                                                        .setWidth(53),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        // image:
                                                        //     AdvancedNetworkImage(

                                                        //   useDiskCache: true,
                                                        //   cacheRule: CacheRule(
                                                        //       maxAge:
                                                        //           const Duration(
                                                        //               days: 3)),
                                                        // ),
                                                        image:
                                                            CachedNetworkImageProvider(
                                                          Provider.of<Testimony>(
                                                                      context,
                                                                      listen: true)
                                                                  .userTestimony
                                                                  .testimonies[index]
                                                              ['profileImage'],
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    // child: Image(
                                                    //   image: AdvancedNetworkImage(
                                                    //     Provider.of<Testimony>(
                                                    //                 context,
                                                    //                 listen: true)
                                                    //             .userTestimony
                                                    //             .testimonies[index]
                                                    //         ['profileImage'],
                                                    //     useDiskCache: true,
                                                    //     cacheRule: CacheRule(
                                                    //         maxAge: const Duration(
                                                    //             days: 3)),
                                                    //   ),
                                                    // ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      ScreenUtil().setWidth(25),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width: ScreenUtil()
                                                          .setWidth(255),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          ShaderMask(
                                                            blendMode:
                                                                BlendMode.srcIn,
                                                            shaderCallback:
                                                                (bounds) =>
                                                                    LinearGradient(
                                                              colors: [
                                                                Color(
                                                                    0xFF34B0D9),
                                                                Color(
                                                                    0xFF3685CB),
                                                              ],
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                            ).createShader(
                                                              Rect.fromLTWH(
                                                                  0,
                                                                  0,
                                                                  bounds.width,
                                                                  bounds
                                                                      .height),
                                                            ),
                                                            child:
                                                                SmoothStarRating(
                                                              allowHalfRating:
                                                                  true,
                                                              // onRated: (v) {
                                                              //   // update(v);
                                                              //   setState(() {
                                                              //     rating = v;
                                                              //   });
                                                              // print(rating);
                                                              // },
                                                              starCount: 5,
                                                              // rating: 3.4,
                                                              rating: double.parse(Provider.of<
                                                                          Testimony>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .userTestimony
                                                                  .testimonies[
                                                                      index]
                                                                      ['rating']
                                                                  .toString()),
                                                              size: ScreenUtil()
                                                                  .setSp(20,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                              isReadOnly: true,
                                                              filledIconData:
                                                                  Icons.star,
                                                              halfFilledIconData:
                                                                  Icons
                                                                      .star_half,
                                                              color: Colors
                                                                  .amber[300],
                                                              borderColor:
                                                                  Colors.black,
                                                              spacing: 1.5,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: ScreenUtil()
                                                          .setHeight(7),
                                                    ),
                                                    SizedBox(
                                                      width: ScreenUtil()
                                                          .setWidth(255),
                                                      child: Text(
                                                        "\"" +
                                                            Provider.of<Testimony>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .userTestimony
                                                                    .testimonies[
                                                                index]['comment'] +
                                                            "\"",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy Regular',
                                                          fontSize: ScreenUtil()
                                                              .setSp(14,
                                                                  allowFontScalingSelf:
                                                                      true),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: ScreenUtil()
                                                          .setHeight(50),
                                                    ),
                                                    // Padding(
                                                    //   padding:
                                                    //       const EdgeInsets.only(
                                                    //           top: 0.0,
                                                    //           bottom: 7.0),
                                                    //   child: SmoothStarRating(
                                                    //     allowHalfRating: true,
                                                    //     // onRated: (v) {
                                                    //     //   // update(v);
                                                    //     //   setState(() {
                                                    //     //     rating = v;
                                                    //     //   });
                                                    //   print(rating);
                                                    //     // },
                                                    //     starCount: 5,
                                                    //     // rating: 3.4,
                                                    //     rating: double.parse(
                                                    //         Provider.of<Testimony>(
                                                    //                 context,
                                                    //                 listen:
                                                    //                     false)
                                                    //             .userTestimony
                                                    //             .testimonies[
                                                    //                 index]
                                                    //                 ['rating']
                                                    //             .toString()),
                                                    //     size: ScreenUtil().setSp(
                                                    //         20,
                                                    //         allowFontScalingSelf:
                                                    //             true),
                                                    //     isReadOnly: true,
                                                    //     filledIconData:
                                                    //         Icons.star,
                                                    //     halfFilledIconData:
                                                    //         Icons.star_half,
                                                    //     color:
                                                    //         Colors.amber[300],
                                                    //     borderColor:
                                                    //         Colors.black,
                                                    //     spacing: 1.5,
                                                    //   ),
                                                    // ),
                                                    SizedBox(
                                                      height: ScreenUtil()
                                                          .setHeight(20),
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
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          165),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    Provider.of<Testimony>(context,
                                                                                listen: false)
                                                                            .userTestimony
                                                                            .testimonies[index]['firm']
                                                                            .toString() +
                                                                        ',',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'Gilroy Medium',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
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
                                                                            [
                                                                            'fullName']
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'Gilroy Regular',
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
                                                            DateFormat(
                                                                    'dd.MM.yyyy')
                                                                .format(
                                                                    dateFormat),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontFamily:
                                                                  'Gilroy Regular',
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
                                                )
                                              ],
                                            ),
                                          ),
                                          index ==
                                                  Provider.of<Testimony>(
                                                              context,
                                                              listen: true)
                                                          .userTestimony
                                                          .testimonies
                                                          .length -
                                                      1
                                              ? SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(70),
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
      floatingActionButton: Provider.of<UserInfo>(context).street == "-" ||
              Provider.of<Pagination>(context).isPriced == false ||
              Provider.of<Pagination>(context).isVerified == false
          ? SizedBox(
              height: 0.0,
              width: 0.0,
            )
          : Container(
              // padding: EdgeInsets.all(15.0),
              width: ScreenUtil().setWidth(120),
              height: ScreenUtil().setHeight(50),
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage('assets/images/vector17.png'),
                //   fit: BoxFit.contain,
                // ),
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF34B0E9),
                    Color(0xFF3685CB),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Material(
                type: MaterialType.transparency,
                elevation: 6.0,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  splashColor: Colors.cyan[100].withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        double rating = 5.0;
                        return SimpleDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          children: <Widget>[
                            Form(
                              key: _key,
                              child: Container(
                                height: ScreenUtil().setHeight(325),
                                width: ScreenUtil().setWidth(400),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Wrtie a Testimony',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy Medium',
                                        fontSize: ScreenUtil().setSp(17,
                                            allowFontScalingSelf: true),
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(10),
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
                                            0, 0, bounds.width, bounds.height),
                                      ),
                                      child: SmoothStarRating(
                                        allowHalfRating: true,

                                        onRated: (v) {
                                          // update(v);
                                          setState(() {
                                            rating = v;
                                          });
                                          // print(rating);
                                        },
                                        starCount: 5,
                                        rating: rating,
                                        size: ScreenUtil().setSp(40,
                                            allowFontScalingSelf: true),
                                        isReadOnly: false,
                                        filledIconData: Icons.star,
                                        halfFilledIconData: Icons.star_half,
                                        // color: Colors
                                        //     .amber,
                                        // borderColor: Colors
                                        //     .yellowAccent,
                                        spacing: 5.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(10),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value.length < 100) {
                                          return "Minimum 100 Characters";
                                        }
                                        return null;
                                      },
                                      maxLines: 3,
                                      maxLength: 245,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Gilroy Regular"),
                                      controller: commentEditingController,
                                      // expands: true,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Leave a comment!'),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(10),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(180),
                                      height: ScreenUtil().setHeight(35),
                                      // padding: EdgeInsets.all(20.0),
                                      decoration: BoxDecoration(
                                        // image: DecorationImage(
                                        //   image: AssetImage('assets/images/vector17.png'),
                                        //   fit: BoxFit.contain,
                                        // ),
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF34B0E9),
                                            Color(0xFF3685CB),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: Material(
                                        type: MaterialType.transparency,
                                        elevation: 6.0,
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(30),
                                        child: InkWell(
                                          splashColor: Colors.cyan[50],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          onTap: () async {
                                            if (_key.currentState.validate()) {
                                              _key.currentState.save();
                                              try {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                try {
                                                  await Provider.of<Testimony>(
                                                          context,
                                                          listen: false)
                                                      .writeTestimony(
                                                          context: context,
                                                          comment:
                                                              commentEditingController
                                                                  .text
                                                                  .trim(),
                                                          rating: rating);
                                                } catch (err) {
                                                  flag = true;
                                                  dataSelect(
                                                      context: context,
                                                      titleText: 'Alert!',
                                                      buttonText: 'Okay',
                                                      contentText:
                                                          err.toString(),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      gif:
                                                          "assets/images/alert.gif");
                                                }
                                                await Provider.of<Testimony>(
                                                        context,
                                                        listen: false)
                                                    .getTestimony(
                                                        context: context);
                                                commentEditingController
                                                    .clear();
                                                if (flag == false)
                                                  Navigator.pop(context);
                                              } catch (err) {
                                                dataSelect(
                                                    context: context,
                                                    titleText: 'Alert!',
                                                    buttonText: 'Okay',
                                                    contentText: err.toString(),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    gif:
                                                        "assets/images/alert.gif");
                                              } finally {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            }
                                          },
                                          child: Center(
                                            child: Text(
                                              'SUBMIT',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy Bold',
                                                color: Colors.white,
                                                fontSize: ScreenUtil().setSp(14,
                                                    allowFontScalingSelf: true),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SvgPicture.asset(
                        // Icons.border_color,
                        'assets/icons/writeTestimony.svg',
                        height: ScreenUtil().setHeight(20),
                        width: ScreenUtil().setWidth(20),
                        color: Colors.white,
                      ),
                      Text(
                        'WRITE',
                        style: TextStyle(
                          fontFamily: 'Gilroy Medium',
                          color: Colors.white,
                          fontSize: ScreenUtil()
                              .setSp(17, allowFontScalingSelf: true),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
