import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:wallpepar_app/screens/home/view/home_page.dart';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          RepaintBoundary(
            key: _globalKey,
            child: GestureDetector(
              onTap: () {

              },
              child: ImageFiltered(
                imageFilter: ImageFilter.compose(inner: ImageFilter.blur(sigmaX:0),outer: ImageFilter.blur(sigmaY: 0)),
                child: Container(
                  width: screenWidth,
                  height: screenHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.cover,
                    placeholder: AssetImage('assets/img/b6e0b072897469.5bf6e79950d23 (1).gif'),
                    image: NetworkImage(wallpaper!),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: screenHeight/1.2,bottom: 10),
            width: screenWidth/1,
            height: screenHeight/6.8,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Color(0xff121212)),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  ListTile(
                    leading:CircleAvatar(radius: 30, backgroundImage: NetworkImage(user!),),
                    title: Text(name!.toUpperCase()),
                    subtitle: Text(views!),
                    trailing: IconButton(icon: Icon(Icons.favorite,color: Colors.red,), onPressed: () {  },),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: () {
                          _saveLocalImage4k();
                        }, icon: Icon(Icons.download)),
                        IconButton(onPressed: () {

                        }, icon: Icon(Icons.blur_on_rounded)),
                        IconButton(onPressed: () {

                          captureAndSetWallpaper();
                        }, icon: Icon(Icons.wallpaper)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 40,left: 10),
          //   child: Row(
          //     children: [
          //       IconButton(onPressed: () {
          //
          //       }, icon: Icon(CupertinoIcons.arrow_left))
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

final GlobalKey _globalKey = GlobalKey();

_saveLocalImage() async {
  RenderRepaintBoundary boundary =
  _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage(pixelRatio: 1.0);
  ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
  await ImageGallerySaver.saveImage(byteData!.buffer.asUint8List());
}

_saveLocalImageHD() async {
  RenderRepaintBoundary boundary =
  _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage(pixelRatio: 2.0);
  ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
  await ImageGallerySaver.saveImage(byteData!.buffer.asUint8List());
}

_saveLocalImage4k() async {
  RenderRepaintBoundary boundary =
  _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage(pixelRatio: 5.0);
  ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
  await ImageGallerySaver.saveImage(byteData!.buffer.asUint8List());
}

_shareLocalImage(String extraText) async {
  RenderRepaintBoundary boundary =
  _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image imageUi = await boundary.toImage(pixelRatio: 3.0);
  ByteData? byteData = await imageUi.toByteData(format: ui.ImageByteFormat.png);
  Uint8List img = byteData!.buffer.asUint8List();
  final path = await getApplicationCacheDirectory();
  File file = File("${path.path}/img.png");
  file.writeAsBytes(img);
  ShareExtend.share(file.path, "image",extraText: extraText);
}

_shareLocalOnlyImage() async {
  RenderRepaintBoundary boundary =
  _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image imageUi = await boundary.toImage(pixelRatio: 3.0);
  ByteData? byteData = await imageUi.toByteData(format: ui.ImageByteFormat.png);
  Uint8List img = byteData!.buffer.asUint8List();
  final path = await getApplicationCacheDirectory();
  File file = File("${path.path}/img.png");
  file.writeAsBytes(img);
  ShareExtend.share(file.path, "image");
}

captureAndSetWallpaper() async {
  RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image imageUi = await boundary.toImage(pixelRatio: 3.0);
  ByteData? byteData = await imageUi.toByteData(format: ui.ImageByteFormat.png);
  Uint8List img = byteData!.buffer.asUint8List();
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/img.png';
  File file = File(path);
  await file.writeAsBytes(img);
  int location = WallpaperManager.HOME_SCREEN;
  bool result = await WallpaperManager
      .setWallpaperFromFile(
      file.path, location);
}