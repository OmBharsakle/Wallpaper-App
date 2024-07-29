class WallpaperModel
{
  int? total,totalHits;
  List<Hits>? hits;

  WallpaperModel({required this.total,required this.totalHits,required this.hits});
WallpaperModel.f();
  factory WallpaperModel.fromJson(Map json)
  {
    return WallpaperModel(total: json['total'], totalHits: json['totalHits'], hits: (json['hits'] as List).map((e)=> Hits.fromJson(e)).toList());
  }
}

class Hits
{
  String webFormatURL;

  Hits({required this.webFormatURL});

  factory Hits.fromJson(Map json)
  {
    return Hits(webFormatURL: json['webformatURL']);
  }

}