import 'dart:ui';
import 'package:Flutter/providers/pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../widgets/snackbar.dart';

class SortPage extends StatefulWidget {
  final ScrollController scrollController;
  final String select;

  const SortPage({Key key, this.select, this.scrollController})
      : super(key: key);
  @override
  _SortPageState createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  int _selectedTab;
  int _prevSelectedTab;
  bool isLoading = false;
  bool _check = false;
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
  void initState() {
    super.initState();
    for (int i = 0; i < sortChoicesServer.length; i++) {
      if (sortChoicesServer[i] ==
          Provider.of<Pagination>(context, listen: false).count) {
        _selectedTab = i;
      }
    }
    if (Provider.of<Pagination>(context, listen: false).sort == 1) {
      _check = true;
    } else {
      _check = false;
    }
  }

  Future<void> sortIt(index, checked) async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    var value =
        index == null ? 'styleNumber' : sortChoicesServer[index].toString();
    await Provider.of<Pagination>(context, listen: false).setCount(value);
    if (checked) {
      await Provider.of<Pagination>(context, listen: false).setSort(1);
    } else {
      await Provider.of<Pagination>(context, listen: false).setSort(-1);
    }
    // print(Provider.of<Pagination>(context, listen: false).count);
    // print(Provider.of<Pagination>(context, listen: false).sort);
    Provider.of<Pagination>(context, listen: false).pageStart();

    var futures = <Future>[
      // Provider.of<Pagination>(context, listen: false).getProducts(
      //     page: 1,
      //     addition: false,
      //     select: 'all',
      //     context: context,
      //     sortby: Provider.of<Pagination>(context, listen: false).count == null
      //         ? 'styleNumber'
      //         : Provider.of<Pagination>(context, listen: false).count,
      //     sort: Provider.of<Pagination>(context, listen: false).sort),
      // Provider.of<Pagination>(context, listen: false).getProducts(
      //     page: 1,
      //     addition: false,
      //     select: 'featured',
      //     context: context,
      //     sortby: Provider.of<Pagination>(context, listen: false).count == null
      //         ? 'styleNumber'
      //         : Provider.of<Pagination>(context, listen: false).count,
      //     sort: Provider.of<Pagination>(context, listen: false).sort),
      // Provider.of<Pagination>(context, listen: false).getProducts(
      //     page: 1,
      //     addition: false,
      //     select: 'isnew',
      //     context: context,
      //     sortby: Provider.of<Pagination>(context, listen: false).count == null
      //         ? 'styleNumber'
      //         : Provider.of<Pagination>(context, listen: false).count,
      //     sort: Provider.of<Pagination>(context, listen: false).sort),
      // Provider.of<Pagination>(context, listen: false).getProducts(
      //     page: 1,
      //     addition: false,
      //     select: 'navratna',
      //     context: context,
      //     sortby: Provider.of<Pagination>(context, listen: false).count == null
      //         ? 'styleNumber'
      //         : Provider.of<Pagination>(context, listen: false).count,
      //     sort: Provider.of<Pagination>(context, listen: false).sort),
      // Provider.of<Pagination>(context, listen: false).getProducts(
      //     addition: false,
      //     page: 1,
      //     context: context,
      //     select: 'fancyDiamond',
      //     sortby: Provider.of<Pagination>(context, listen: false).count == null
      //         ? 'styleNumber'
      //         : Provider.of<Pagination>(context, listen: false).count,
      //     sort: Provider.of<Pagination>(context, listen: false).sort),
      Provider.of<Pagination>(context, listen: false).getFav(context)
    ];
    try {
      // await Future.wait([]);
      await Provider.of<Pagination>(context, listen: false).getProducts(
          addition: false,
          page: 1,
          context: context,
          select: 'featured',
          sortby: Provider.of<Pagination>(context, listen: false).count,
          sort: Provider.of<Pagination>(context, listen: false).sort);
      // ]);
      // await Provider.of<Pagination>(context, listen: false)
      //     .getProducts(
      //         page: 1,
      //         addition: false,
      //         select: 'all',
      //         context: context,
      //         sortby:
      //             Provider.of<Pagination>(context, listen: false).count == null
      //                 ? 'styleNumber'
      //                 : Provider.of<Pagination>(context, listen: false).count,
      //         sort: Provider.of<Pagination>(context, listen: false).sort)
      //     .then((value) {
      //   Provider.of<Pagination>(context, listen: false)
      //       .getProducts(
      //           page: 1,
      //           addition: false,
      //           select: 'featured',
      //           context: context,
      //           sortby: Provider.of<Pagination>(context, listen: false).count ==
      //                   null
      //               ? 'styleNumber'
      //               : Provider.of<Pagination>(context, listen: false).count,
      //           sort: Provider.of<Pagination>(context, listen: false).sort)
      //       .then((value) {
      //     Provider.of<Pagination>(context, listen: false)
      //         .getProducts(
      //             page: 1,
      //             addition: false,
      //             select: 'isNew',
      //             context: context,
      //             sortby: Provider.of<Pagination>(context, listen: false)
      //                         .count ==
      //                     null
      //                 ? 'styleNumber'
      //                 : Provider.of<Pagination>(context, listen: false).count,
      //             sort: Provider.of<Pagination>(context, listen: false).sort)
      //         .then((value) {
      //       Provider.of<Pagination>(context, listen: false)
      //           .getProducts(
      //               page: 1,
      //               addition: false,
      //               select: 'navratna',
      //               context: context,
      //               sortby: Provider.of<Pagination>(context, listen: false)
      //                           .count ==
      //                       null
      //                   ? 'styleNumber'
      //                   : Provider.of<Pagination>(context, listen: false).count,
      //               sort: Provider.of<Pagination>(context, listen: false).sort)
      //           .then((value) {
      //         Provider.of<Pagination>(context, listen: false).getProducts(
      //             addition: false,
      //             page: 1,
      //             context: context,
      //             select: 'fancyDiamond',
      //             sortby: Provider.of<Pagination>(context, listen: false)
      //                         .count ==
      //                     null
      //                 ? 'styleNumber'
      //                 : Provider.of<Pagination>(context, listen: false).count,
      //             sort: Provider.of<Pagination>(context, listen: false).sort);
      //       });
      //     });
      //   });
      // });

      // await Provider.of<Pagination>(context, listen: false).getFav(context);
      await Future.wait(futures);
      // print("DC");
      widget.scrollController
          .animateTo(0, duration: Duration(seconds: 1), curve: Curves.ease);
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
      if (mounted)
        setState(() {
          isLoading = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF34B0D9).withOpacity(0.2),
                    Color(0xFF3685CB).withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
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
                        Center(
                          child: Wrap(
                            children: List<Widget>.generate(sortChoices.length,
                                (int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_selectedTab == index) {
                                      _selectedTab = null;
                                    } else {
                                      _selectedTab = index;
                                    }
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
                                                bottomRight:
                                                    Radius.circular(5.0),
                                                topRight: Radius.circular(5.0),
                                              ),
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
                                          borderRadius: index == 0
                                              ? BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5.0),
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
                                                  : 'Gilroy Light',
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true)),
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
                          width: ScreenUtil().setWidth(400),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'Low to High',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy Medium',
                                      fontSize: ScreenUtil().setSp(18,
                                          allowFontScalingSelf: true),
                                      color: Color(0xFF545151),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        ScreenUtil().setWidth(_check ? 9 : 12),
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
                                      width: ScreenUtil()
                                          .setWidth(_check ? 23 : 20),
                                      height: ScreenUtil().setHeight(23),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(17),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(180),
                                height: ScreenUtil().setHeight(35),
                                decoration: BoxDecoration(
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
                                    splashColor:
                                        Colors.cyan[100].withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () async {
                                      try {
                                        Navigator.of(context).pop();
                                        if (_selectedTab != null) {
                                          showFloatingFlushbar(
                                              context,
                                              _selectedTab == null
                                                  ? 'Sort-by changed Successfully'
                                                  : "Now sorting by ${sortChoices[_selectedTab]}",
                                              "${_check ? "Low to High" : "High to Low"}",
                                              '');
                                          if (mounted)
                                            setState(() {
                                              isLoading = true;
                                            });
                                          await sortIt(_selectedTab, _check);
                                          // await Future.wait([
                                          //   Provider.of<Pagination>(context,
                                          //           listen: false)
                                          //       .getFav(context)
                                          // ]);
                                          // print("object");
                                          if (mounted)
                                            setState(() {
                                              isLoading = false;
                                            });
                                        } else {
                                          await sortIt(_selectedTab, _check);
                                          // await Future.wait([
                                          //   Provider.of<Pagination>(context,
                                          //           listen: false)
                                          //       .getFav(context)
                                          // ]);
                                          // print("object1");
                                        }
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
                                        // if (mounted)
                                        //   setState(() {
                                        //     // isLoading = true;
                                        //   });
                                        // Navigator.of(context).pop();
                                      }
                                    },
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
                                  ),
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
          );
  }
}
