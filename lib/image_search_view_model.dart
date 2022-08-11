import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_search_provider/model/picture.dart';
import 'api/picture_api.dart';

class ImageSearchViewModel extends ChangeNotifier {
  //데이터 저장소
  final _pictureApi = PictureApi();

  List<Picture> images = [];

  bool isLoading = false;

  Future<void> fetchImages(String query) async {
    isLoading = true;
    notifyListeners();

    images = await _pictureApi.getImages(query);
    notifyListeners(); //상태 바뀔때마다 붙임

    isLoading = false;
    notifyListeners();
  }
}
