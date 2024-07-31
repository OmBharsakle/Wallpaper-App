import 'dart:async';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/wallpaper_provider.dart';
import '../Details/Details_Page.dart';
import '../home/view/home_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController SearchContraoll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WallpaperProvider wallpaperProvider = Provider.of<WallpaperProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: SearchBar(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.search),
                ),
                hintText: 'Search',
                controller: SearchContraoll,
                onSubmitted: (value) {
                  wallpaperProvider.searchData(value);

                },
              ),
            ),
          Consumer<WallpaperProvider>(builder: (context, provider, child) {
            if(provider.isLoading)
              {
                return Center(child: CircularProgressIndicator(color: Colors.white,),);
              }
            if(provider.wallpaperModelSerach.hits==null)
              {
                return Column();

              }

            return Expanded(
              child: GridView.builder(
                  itemCount: provider.wallpaperModelSerach.hits!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 16,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () async {
                      name=wallpaperProvider.wallpaperModelSerach.hits![index].user;
                      user=wallpaperProvider.wallpaperModelSerach.hits![index].userImageUrl;
                      views=wallpaperProvider.wallpaperModelSerach.hits![index].views.toString();
                      wallpaper=wallpaperProvider.wallpaperModelSerach.hits![index].largeImageUrl;
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(),));
                      // String url = provider.wallpaperModelSerach.hits![index].webFormatURL; // URL of the wallpaper image
                      //  await AsyncWallpaper.setWallpaper(
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
                          image: NetworkImage(provider.wallpaperModelSerach.hits![index].webformatUrl,),
                        ),
                      ),
                    ),
                  ),
                ),
            );}
            ,)
          ],
        ),
      ),
    );
  }
}
