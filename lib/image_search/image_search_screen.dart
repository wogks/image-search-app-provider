import 'package:flutter/material.dart';
import 'package:image_search_provider/api/picture_api.dart';
import 'package:image_search_provider/image_search_view_model.dart';
import 'package:image_search_provider/model/picture.dart';
import 'package:provider/provider.dart';

class ImageSearchScreen extends StatefulWidget {
  const ImageSearchScreen({Key? key}) : super(key: key);

  @override
  State<ImageSearchScreen> createState() => _ImageSearchScreenState();
}

class _ImageSearchScreenState extends State<ImageSearchScreen> {
  final _controller = TextEditingController();
  @override
  void initState() {
    Future.delayed(Duration.zero, (() {
      final viewModel = context.read<ImageSearchViewModel>();
      viewModel.fetchImages('');
    }));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final viewModel = context.watch<ImageSearchViewModel>();

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
                    viewModel.fetchImages(_controller.text);
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
              child:  viewModel.isLoading? const Center(child: CircularProgressIndicator()) : GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    children: viewModel.images.map((Picture image) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          image.previewURL,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  )
            ),
          ),
        ],
      ),
    );
  }
}
