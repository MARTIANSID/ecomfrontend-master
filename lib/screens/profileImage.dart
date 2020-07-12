import 'dart:io';

import 'package:Flutter/providers/user.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view_gallery.dart' as pv;
import 'package:provider/provider.dart';

class ProfileImage extends StatefulWidget {
  final url;
  ProfileImage({this.url});

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File image;

  final picker = ImagePicker();

  bool isLoadingimage = false;

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
            height: ScreenUtil().setHeight(90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoadingimage = true;
                              });
                              try {
                                await Provider.of<UserInfo>(context,
                                        listen: false)
                                    .deleteImage(context: context);
                                await Provider.of<UserInfo>(context,
                                        listen: false)
                                    .getuser(context);
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
                                  isLoadingimage = false;
                                });
                              }
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Text(
                          'Remove',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Gilroy Medium",
                            fontSize: ScreenUtil()
                                .setSp(16, allowFontScalingSelf: true),
                          ),
                          softWrap: true,
                        )
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            final i = await picker.getImage(
                                source: ImageSource.camera);
                            // print(i.path);
                            if (i.path != null) {
                              setState(() {
                                isLoadingimage = true;
                              });
                              try {
                                // if (context != null) print("SDCD");
                                await Provider.of<UserInfo>(context,
                                        listen: false)
                                    .changeImage(
                                        context: context, image: File(i.path));
                                await Provider.of<UserInfo>(context,
                                        listen: false)
                                    .getuser(context);

                                // image = File(
                                //     i.path);
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
                                Navigator.pop(context);
                                setState(() {
                                  isLoadingimage = false;
                                });
                              }
                            }
                          },
                          child: Icon(Icons.camera_alt),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontFamily: "Gilroy Medium",
                            fontSize: ScreenUtil()
                                .setSp(16, allowFontScalingSelf: true),
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            final i = await picker.getImage(
                                source: ImageSource.gallery);
                            // print(i.path);
                            if (i.path != null) {
                              setState(() {
                                isLoadingimage = true;
                              });
                              try {
                                // if (context != null) print("SDCD");
                                await Provider.of<UserInfo>(context,
                                        listen: false)
                                    .changeImage(
                                        context: context, image: File(i.path));
                                await Provider.of<UserInfo>(context,
                                        listen: false)
                                    .getuser(context);

                                // image = File(
                                //     i.path);
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
                                Navigator.pop(context);
                                setState(() {
                                  isLoadingimage = false;
                                });
                              }
                            }
                          },
                          child: Icon(Icons.photo_library),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            fontFamily: "Gilroy Medium",
                            fontSize: ScreenUtil()
                                .setSp(16, allowFontScalingSelf: true),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          GestureDetector(
              onTap: () async {
                _settingModalBottomSheet(context);
              },
              child: Icon(Icons.edit))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: pv.PhotoViewGallery(
          pageOptions: <PhotoViewGalleryPageOptions>[
            PhotoViewGalleryPageOptions(
              imageProvider: isLoadingimage
                  ? AdvancedNetworkImage(
                      '',
                      useDiskCache: true,
                      cacheRule: CacheRule(maxAge: const Duration(days: 3)),
                    )
                  : AdvancedNetworkImage(
                      Provider.of<UserInfo>(context, listen: true).profileImage,
                      useDiskCache: true,
                      cacheRule: CacheRule(maxAge: const Duration(days: 3)),
                    ),
              heroAttributes: PhotoViewHeroAttributes(tag: "tag2"),
            ),
          ],
        ),
      ),
    );
  }
}
