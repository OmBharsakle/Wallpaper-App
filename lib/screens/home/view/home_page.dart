import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpepar_app/provider/wallpaper_provider.dart';
import 'package:wallpepar_app/screens/SearchScrean/SearchScrean.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WallpaperProvider wallpaperProvider = Provider.of<WallpaperProvider>(context, listen: false);
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
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholderFit: BoxFit.cover,
                        placeholder: AssetImage('assets/img/b6e0b072897469.5bf6e79950d23 (1).gif'),
                        image: NetworkImage(wallpaperProvider.wallpaperModel.hits![index].webFormatURL,),
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
