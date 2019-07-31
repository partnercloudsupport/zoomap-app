import 'package:http/http.dart' as http;
import 'dart:convert';

class FlickrImages {
  List<String> imageList = [];

  String urlImage;

  http.Response response;

  Future getImageList({double latitude, double longitude}) async {
    try {
      response = await http.get(
          'https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=ab1b8b33a98bcf6636a412bb79eeebda&&privacy_filter=1&lat=$latitude&lon=$longitude&radius=1&radius_units=mi&per_page=20&page=1&format=json&nojsoncallback=1');
    } catch (e) {
      print('$e : sem net');
      return null;
    }

    for (int i = 0; i <= 19; i++) {
      try {
        var data = response.body;

        var decodedTotal = int.parse(jsonDecode(data)['photos']['total']);

        if (decodedTotal == 0) {
          imageList.add('noImagesFound');
        } else {
          var decodedFarm = jsonDecode(data)['photos']['photo'][i]['farm'];
          var decodedId = jsonDecode(data)['photos']['photo'][i]['id'];
          var decodedSecret = jsonDecode(data)['photos']['photo'][i]['secret'];
          var decodedServer = jsonDecode(data)['photos']['photo'][i]['server'];

          urlImage =
              'https://farm$decodedFarm.staticflickr.com/$decodedServer/${decodedId}_${decodedSecret}_z_d.jpg';

          imageList.add(urlImage);
        }
      } catch (e) {
        print(e);
      }
    }
    return imageList;
  }
}
