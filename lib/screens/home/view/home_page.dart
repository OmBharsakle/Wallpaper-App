import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpepar_app/provider/wallpaper_provider.dart';
import 'package:wallpepar_app/screens/Details/Details_Page.dart';
import 'package:wallpepar_app/screens/SearchScrean/SearchScrean.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WallpaperProvider wallpaperProvider = Provider.of<WallpaperProvider>(context, listen: false);
    // system. wallpaperProvider.listNull();
    return Scaffold(
      appBar: AppBar(
        title: Text('BackDrops',style: TextStyle(fontWeight: FontWeight.w600,letterSpacing: 1),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen(),));
          }, icon: Icon(Icons.search))
        ],
      ),
      drawer: Drawer(),
      body: FutureBuilder(
        future: wallpaperProvider.loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                    child: GridView.builder(
                  itemCount: wallpaperProvider.wallpaperModel.hits?.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 16,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () async {
                      selectWall=index;
                      name=wallpaperProvider.wallpaperModel.hits![index].user;
                      user=wallpaperProvider.wallpaperModel.hits![index].userImageUrl;
                      views=wallpaperProvider.wallpaperModel.hits![index].views.toString();
                      wallpaper=wallpaperProvider.wallpaperModel.hits![index].largeImageUrl;
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(),));
                      // String url = wallpaperProvider.wallpaperModel.hits![index].webFormatURL; // URL of the wallpaper image
                      // bool result = await AsyncWallpaper.setWallpaper(
                      //   url: url,
                      //   goToHome: false,
                      //   toastDetails: ToastDetails.success(),
                      //   errorToastDetails: ToastDetails.error(),
                      //   wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
                      // );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.cover,
                          placeholder: AssetImage('assets/img/b6e0b072897469.5bf6e79950d23 (1).gif'),
                          image: NetworkImage(wallpaperProvider.wallpaperModel.hits![index].webformatUrl,),
                          ),
                      ),
                    ),
                  ),

                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

int selectWall=0;
String? wallpaper,user,name,views;