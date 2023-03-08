import 'package:flutter/material.dart';
import 'package:flutter_api_retriever/classes/photo.dart';
import 'package:flutter_api_retriever/providers/photo_drawer.dart';
import 'package:flutter_api_retriever/providers/photos.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Container(),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      selected:
                          context.watch<DrawerProvider>().getSelectedIndex ==
                                  index
                              ? true
                              : false,
                      onTap: () {
                        context
                            .read<DrawerProvider>()
                            .selectedIndexChange(index);
                        context.read<PhotosProvider>().changeId(index + 1);

                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.image),
                      title: Text('Album ID ${index + 1}'),
                    );
                  }),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Album ID ${context.watch<PhotosProvider>().getId}'),
      ),
      body: FutureBuilder<List<Photo>>(
        future: context.watch<PhotosProvider>().fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Center(
                child: Image.network(
                  photos[index].thumbnailUrl,
                ),
              );
            }, childCount: photos.length),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0))
      ],
    );
  }
}
