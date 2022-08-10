import 'package:flutter/material.dart';
import 'package:image_search_provider/video_search/video_search_screen.dart';
import 'image_search/image_search_screen.dart';

class ImageApp extends StatefulWidget {
  const ImageApp({Key? key}) : super(key: key);

  @override
  State<ImageApp> createState() => _ImageAppState();
}

class _ImageAppState extends State<ImageApp> {
  int _currentIndex = 0;

  final screens = const [ImageSearchScreen(), VideoSearchScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'image'),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'video'),
        ],
      ),
    );
  }
}
