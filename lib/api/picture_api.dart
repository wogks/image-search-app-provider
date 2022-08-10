import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_search_provider/model/picture.dart';

class PictureApi {
  PictureApi() {
    fetchImages('');
  }

  final _imageStreamController = StreamController<List<Picture>>();

  Stream<List<Picture>> get imageStream => _imageStreamController.stream;

  Future fetchImages(String query) async {
    List<Picture> images = await getImages(query);
    _imageStreamController.add(images);
  }

  Future<List<Picture>> getImages(String query) async {
    Uri url = Uri.parse('https://pixabay.com/api/?key=10711147-dc41758b93b263957026bdadb&q=$query&image_type=photo');

    http.Response response = await http.get(url);

    String jsonString = response.body;

    Map<String, dynamic> json = jsonDecode(jsonString);
    List<dynamic> hits = json['hits'];
    return hits.map((e) => Picture.fromJson(e)).toList();
  }

}