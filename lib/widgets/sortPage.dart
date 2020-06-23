import 'dart:ui';

import 'package:Flutter/providers/pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SortPage extends StatefulWidget {

  final ScrollController scrollController;

  const SortPage({Key key, this.scrollController}) : super(key: key);
  @override
  _SortPageState createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  int _selectedTab;
  bool isLoading = false;

  var sortChoices = [
    'Diamond Weight',
    'Diamond Count',
    'Gold Weight',
  ];

  var sortChoicesServer = [
    'diamondWeight',
    'diamondCount',
    'goldWeight',
  ];

  Future<void> sortIt(index, checked) async {
    setState(() {
      isLoading = true;
    });
    var value = sortChoicesServer[index].toString();
    Provider.of<Pagination>(context, listen: false).setCount(value);
    if (checked) {
      Provider.of<Pagination>(context, listen: false).setSort(1);
    } else {
      Provider.of<Pagination>(context, listen: false).setSort(-1);
    }
    Provider.of<Pagination>(context, listen: false).pageStart();

    var futures = <Future>[
      Provider.of<Pagination>(context, listen: false).getProducts(
          page: 1,
          addition: false,
          select: 'all',
          context: context,
          sortby: Provider.of<Pagination>(context, listen: false).count,
          sort: checked ? 1 : -1),
      Provider.of<Pagination>(context, listen: false).getProducts(
          page: 1,
          addition: false,
          select: 'featured',
          context: context,
          sortby: Provider.of<Pagination>(context, listen: false).count,
          sort: checked ? 1 : -1),
      Provider.of<Pagination>(context, listen: false).getProducts(
          page: 1,
          addition: false,
          select: 'new',
          context: context,
          sortby: Provider.of<Pagination>(context, listen: false).count,
          sort: checked ? 1 : -1),
      Provider.of<Pagination>(context, listen: false).getProducts(
          page: 1,
          addition: false,
          select: 'highestSelling',
          context: context,
          sortby: Provider.of<Pagination>(context, listen: false).count,
          sort: checked ? 1 : -1),
      Provider.of<Pagination>(context, listen: false).getProducts(
          addition: false,
          page: 1,
          context: context,
          select: 'fancyDiamond',
          sortby: Provider.of<Pagination>(context, listen: false).count,
          sort: checked ? 1 : -1),
      Provider.of<Pagination>(context, listen: false).getFav(context)
    ];
    await Future.wait(futures);
     widget.scrollController.animateTo(0, duration: new Duration(seconds: 1), curve: Curves.ease);

    setState(() {
      isLoading = false;
    });
  }
                   
  bool _check = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              contentPadding: EdgeInsets.all(18.0),
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(275),
                  width: ScreenUtil().setWidth(356),
                  // width: 700.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: ScreenUtil().setHeight(17),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Sort by",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Gilroy Medium',
                            fontSize: ScreenUtil()
                                .setSp(24, allowFontScalingSelf: true),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(47),
                      ),
                      // Text(
                      //   'Build',
                      //   style: TextStyle(
                      //     fontFamily: 'Gilroy Medium',
                      //     fontSize: ScreenUtil().setSp(18),
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // CupertinoSegmentedControl(
                      //   children: const <int, Widget>{
                      //     0: Padding(
                      //         padding: EdgeInsets.all(8.0), child: Text('Midnight')),
                      //     1: Padding(
                      //         padding: EdgeInsets.all(8.0), child: Text('Viridian')),
                      //     2: Padding(
                      //         padding: EdgeInsets.all(8.0), child: Text('Cerulean'))
                      //   },
                      //   groupValue: this._selectedTab,
                      //   onValueChanged: (value) {
                      //     this.setState(() => this._selectedTab = value);
                      //     // this._tabController.animateTo(value);
                      //   },
                      // ),
                      Center(
                        child: Wrap(
                          // spacing: 9.0,
                          // runSpacing: 5.0,
                          // alignment: WrapAlignment.start,
                          // crossAxisAlignment: WrapCrossAlignment.start,
                          children: List<Widget>.generate(sortChoices.length,
                              (int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTab = index;
                                });
                                // widget.valueChangeDQ(index);
                              },
                              child: Container(
                                // margin: EdgeInsets.only(right: 6.0),
                                height: ScreenUtil().setHeight(45),
                                width: ScreenUtil().setWidth(90),
                                decoration: BoxDecoration(
                                  borderRadius: index == 0
                                      ? BorderRadius.only(
                                          bottomLeft: Radius.circular(5.0),
                                          topLeft: Radius.circular(5.0),
                                        )
                                      : index == 1
                                          ? BorderRadius.circular(0.0)
                                          : BorderRadius.only(
                                              bottomRight: Radius.circular(5.0),
                                              topRight: Radius.circular(5.0),
                                            ),
                                  // borderRadius: BorderRadius.circular(20),
                                  // border: Border.all(
                                  //   color: Colors.black,
                                  //   width: 1.0,
                                  // ),
                                  gradient: _selectedTab != index
                                      ? LinearGradient(
                                          colors: [
                                            Color(0xFFB8B8B8),
                                            Color(0xFFB8B8B8),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : LinearGradient(
                                          colors: [
                                            Color(0xFF34B0D9),
                                            Color(0xFF3685CB),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(20),
                                        borderRadius: index == 0
                                            ? BorderRadius.only(
                                                bottomLeft: Radius.circular(5.0),
                                                topLeft: Radius.circular(5.0),
                                              )
                                            : index == 1
                                                ? BorderRadius.circular(0.0)
                                                : BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0),
                                                  ),
                                        gradient: _selectedTab == index
                                            ? LinearGradient(
                                                colors: [
                                                  Color(0xFF34B0D9),
                                                  Color(0xFF3685CB),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                            : LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Colors.white,
                                                ],
                                              )),
                                    child: Center(
                                      child: Text(
                                        sortChoices[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: _selectedTab == index
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: _selectedTab == index
                                                ? 'Gilroy Medium'
                                                : 'Gilroy Light',fontSize: ScreenUtil().setSp(14,allowFontScalingSelf: true)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(50),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(
                            400), //Some random width greater than Alertdialog box width to make it center
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Low to High',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy Medium',
                                    fontSize: ScreenUtil()
                                        .setSp(14, allowFontScalingSelf: true),
                                    color: Color(0xFF545151),
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(9),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _check = !_check;
                                    });
                                  },
                                  child: Image.asset(
                                    _check
                                        ? 'assets/images/checkBoxTicked.png'
                                        : 'assets/images/checkBox.png',
                                    width: ScreenUtil().setWidth(17),
                                    height: ScreenUtil().setHeight(16),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(17),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await sortIt(_selectedTab, _check);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: ScreenUtil().setWidth(180),
                                height: ScreenUtil().setHeight(43),
                                // padding: EdgeInsets.all(20.0),
                                child: Center(
                                  child: Text(
                                    'DONE',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy Bold',
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(18,
                                          allowFontScalingSelf: true),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/vector17.png'),
                                  fit: BoxFit.contain,
                                )),
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
          );
  }
}
