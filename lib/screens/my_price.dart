import 'package:Flutter/constant/const.dart';
import 'package:Flutter/widgets/filterChipWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPrice extends StatefulWidget {
  final void Function(int) onButtonTapped;

  const MyPrice({Key key, this.onButtonTapped}) : super(key: key);
  @override
  _MyPriceState createState() => _MyPriceState();
}


class _MyPriceState extends State<MyPrice> {
  double age = 9.0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: ScreenUtil().setHeight(120),
              left: 0.0,
              child: Container(
                width: ScreenUtil().setWidth(411),
                height: ScreenUtil().setHeight(658.75),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 100.0, top: 30.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Home / User / My Prices',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: ScreenUtil().setSp(
                              15,
                              allowFontScalingSelf: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(22),
                        ),
                        Text(
                          'My Prices',
                          style: TextStyle(
                            fontFamily: 'Gilroy Black',
                            fontSize: ScreenUtil().setSp(
                              40,
                              allowFontScalingSelf: true,
                            ),
                          ),
                        ),
                        // Text('130 Products'),
                        SizedBox(
                          height: ScreenUtil().setHeight(62),
                        ),
                        Text(
                          'Labour: ',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: ScreenUtil()
                                .setSp(17, allowFontScalingSelf: true),
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(411),
                          height: ScreenUtil().setHeight(62),
                          // child: Wrap(
                          //   spacing: 5.0,
                          //   runSpacing: 3.0,
                          //   children: <Widget>[
                          //     Padding(
                          //       padding: const EdgeInsets.only(right: 8.0),
                          //       child:
                          //           FilterChipWidget(chipName: 'Screw: ₹500'),
                          //     ),
                          //     FilterChipWidget(chipName: 'Tar: ₹500'),
                          //   ],
                          // ),
                          child: ListView(
                            // spacing: 5.0,
                            // runSpacing: 3.0,
                            // direction: ,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child:
                                    FilterChipWidget(chipName: "Screw: 500 ₹"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilterChipWidget(chipName: 'Tar: 500 ₹'),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Diamond: ',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: ScreenUtil()
                                .setSp(17, allowFontScalingSelf: true),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: ScreenUtil().setHeight(62),
                          child: ListView(
                            // spacing: 5.0,
                            // runSpacing: 3.0,
                            // direction: ,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilterChipWidget(
                                    chipName: "VVS_EF: ₹20777"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilterChipWidget(
                                    chipName: 'VVS_FG: ₹20527'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilterChipWidget(
                                    chipName: 'VVS_VS_FG: ₹20027'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child:
                                    FilterChipWidget(chipName: 'VS_FG: ₹19402'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child:
                                    FilterChipWidget(chipName: 'SI_HI: ₹18527'),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Certification: ',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: ScreenUtil()
                                .setSp(17, allowFontScalingSelf: true),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: ScreenUtil().setHeight(62),
                          // child: Wrap(
                          //   spacing: 5.0,
                          //   runSpacing: 3.0,
                          //   children: <Widget>[
                          //     FilterChipWidget(chipName: 'IGI: ₹300'),
                          //     FilterChipWidget(chipName: 'GSI: ₹300'),
                          //   ],
                          // ),
                          child: ListView(
                            // spacing: 5.0,
                            // runSpacing: 3.0,
                            // direction: ,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilterChipWidget(chipName: "IGI: 300 ₹"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilterChipWidget(chipName: 'GSI: 300 ₹'),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Commission: ',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: ScreenUtil()
                                .setSp(17, allowFontScalingSelf: true),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: ScreenUtil().setWidth(205.5),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: NeumorphicSlider(
                                min: 0,
                                max: 100,
                                value: this.age,
                                onChanged: (value) {
                                  setState(() {
                                    age = value;
                                  });
                                },
                                style: SliderStyle(
                                  accent: Colors.white,
                                ),
                                // thumb: Text('$age'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "${age.floor()} %",
                                style: TextStyle(
                                    fontSize: ScreenUtil()
                                        .setSp(17, allowFontScalingSelf: true),
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              top: ScreenUtil().setHeight(350),
              child: Container(
                width: ScreenUtil().setWidth(50),
                height: ScreenUtil().setHeight(310),
                margin: EdgeInsets.only(left: 20.0),
                child: Wrap(
                  direction: Axis.vertical,
                  children: <Widget>[
                    RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        'Manufacturing Prices',
                        style: TextStyle(fontFamily: 'Gilroy', fontSize: ScreenUtil().setSp(25,allowFontScalingSelf: true)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              top: ScreenUtil().setHeight(85),
              child: Container(
                // width: ScreenUtil().setWidth(70),
                // height: ScreenUtil().setHeight(170),
                margin: EdgeInsets.only(left: 20.0),
                child: Image(
                  width: ScreenUtil().setWidth(70),
                height: ScreenUtil().setHeight(170),
                  image: AssetImage('assets/images/rupee.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: ScreenUtil().setHeight(10),
                          child: Column(
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
                              Text(
                                'My Prices',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: ScreenUtil().setSp(25,allowFontScalingSelf: true),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.favorite_border),
                                onPressed: () {
                                  widget.onButtonTapped(1);
                                  Navigator.of(context).pop();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.shopping_cart),
                                onPressed: () {
                                  widget.onButtonTapped(3);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
