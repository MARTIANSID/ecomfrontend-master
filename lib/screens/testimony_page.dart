import 'package:Flutter/constant/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TestimonyPage extends StatefulWidget {
  @override
  _TestimonyPageState createState() => _TestimonyPageState();
}

class _TestimonyPageState extends State<TestimonyPage> {
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
      body: Container(
        color: Colors.white,
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
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.border_color,
                                size: ScreenUtil().setSp(20,allowFontScalingSelf: true),
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Write a Testimony',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(17,allowFontScalingSelf: true),
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
                        fontSize: ScreenUtil().setSp(35,allowFontScalingSelf: true),
                      ),
                    ),
                    Text(
                      '143 reviews',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Gilroy Black',
                        fontSize: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 60.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  '4.2',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.amber[300],
                                    size: ScreenUtil().setSp(20,allowFontScalingSelf: true),
                                  ),
                                  onTap: () {}),
                              GestureDetector(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.amber[300],
                                    size: ScreenUtil().setSp(20,allowFontScalingSelf: true),
                                  ),
                                  onTap: () {}),
                              GestureDetector(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.amber[300],
                                    size: ScreenUtil().setSp(20,allowFontScalingSelf: true),
                                  ),
                                  onTap: () {}),
                              GestureDetector(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.amber[300],
                                    size: ScreenUtil().setSp(20,allowFontScalingSelf: true),
                                  ),
                                  onTap: () {}),
                              GestureDetector(
                                  child: Icon(
                                    Icons.star_border,
                                    size: ScreenUtil().setSp(20,allowFontScalingSelf: true),
                                  ),
                                  onTap: () {}),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      child: Divider(
                        height: 2.0,
                        color: Colors.grey[400],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, i) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Divider(
                              color: Colors.grey[700],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            height: ScreenUtil().setHeight(310),
                            width: ScreenUtil().setWidth(411),
                            padding: EdgeInsets.all(5.0),
                            // color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  // alignment: Alignment.topLeft,
                                  margin:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
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
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: ScreenUtil().setWidth(255),
                                          child: Text(
                                            '"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."',
                                            style: TextStyle(
                                              fontFamily: 'Varela',
                                              fontSize: ScreenUtil().setSp(14,allowFontScalingSelf: true),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30.0, bottom: 7.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 15.0,
                                              ),
                                              child: Text(
                                                '4.2',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.amber[300],
                                                  size: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                                                ),
                                                onTap: () {}),
                                            GestureDetector(
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.amber[300],
                                                  size: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                                                ),
                                                onTap: () {}),
                                            GestureDetector(
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.amber[300],
                                                  size: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                                                ),
                                                onTap: () {}),
                                            GestureDetector(
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.amber[300],
                                                  size: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                                                ),
                                                onTap: () {}),
                                            GestureDetector(
                                                child: Icon(
                                                  Icons.star_half,
                                                  color: Colors.amber[300],
                                                  size: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                                                ),
                                                onTap: () {}),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(255),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              // color: Colors.amber,
                                              child: SizedBox(
                                                width: ScreenUtil().setWidth(165),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'User Full Name' + ',',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Gilroy',
                                                        fontSize: ScreenUtil().setSp(14,allowFontScalingSelf: true),
                                                      ),
                                                    ),
                                                    Text(
                                                      'P M SHah Jwellers and Company',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Gilroy',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: ScreenUtil().setSp(17,allowFontScalingSelf: true),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '11.05.2020',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: 'Gilroy',
                                                fontSize: ScreenUtil().setSp(14,allowFontScalingSelf: true),
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
