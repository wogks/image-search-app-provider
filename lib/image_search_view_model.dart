import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_search_provider/model/picture.dart';
import 'api/picture_api.dart';

class ImageSearchViewModel extends ChangeNotifier {
  final _pictureApi = PictureApi();

  List<Picture> images = [];

  Future<void> fetchImages(String query) async {
    images = await _pictureApi.getImages(query);
    notifyListeners(); //상태 바뀔때마다 붙임
  }

  
}