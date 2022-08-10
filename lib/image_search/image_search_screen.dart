import 'package:flutter/material.dart';
import 'package:image_search_provider/api/picture_api.dart';
import 'package:image_search_provider/model/picture.dart';

class ImageSearchScreen extends StatefulWidget {
  const ImageSearchScreen({Key? key}) : super(key: key);

  @override
  State<ImageSearchScreen> createState() => _ImageSearchScreenState();
}

class _ImageSearchScreenState extends State<ImageSearchScreen> {
  final _pictureApi = PictureApi();

  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '이미지 검색 앱',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _pictureApi.fetchImages(_controller.text);
                  },
                  child: const Icon(Icons.search),
                ),
                hintText: '검색어 입력',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('결과 : ', style: Theme.of(context).textTheme.titleSmall),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<List<Picture>>(
                stream: _pictureApi.imageStream,
                initialData: const [],
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('에러가 발생했습니다'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('데이터가 없습니다'),
                    );
                  }

                  final List<Picture> images = snapshot.data!;

                  if (images.isEmpty) {
                    return const Center(
                      child: Text('데이터가 0개입니다'),
                    );
                  }

                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    children: images.map((Picture image) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          image.previewURL,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
