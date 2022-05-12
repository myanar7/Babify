import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/camera_page.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
          padding: EdgeInsets.only(top: 10, right: 5, left: 5),
          child: PhotoListWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CameraPage()));
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

class PhotoListWidget extends ConsumerStatefulWidget {
  const PhotoListWidget({Key? key}) : super(key: key);

  ConsumerState<PhotoListWidget> createState() => _PhotoListWidgetState();
}

class _PhotoListWidgetState extends ConsumerState<PhotoListWidget> {
  @override
  Widget build(BuildContext context) {
    var _allPhotos = ref.watch(photoAlbumProvider);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 1 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: _allPhotos.length,
      itemBuilder: (BuildContext ctx, index) {
        return FocusedMenuHolder(
          child: Container(
            alignment: Alignment.center,
            child: Image.file(
              _allPhotos[index].image,
              fit: BoxFit.fill,
            ),
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: () {},
          menuItems: <FocusedMenuItem>[
            // Add Each FocusedMenuItem  for Menu Options
            FocusedMenuItem(
                title: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.redAccent),
                ),
                trailingIcon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  ref
                      .read(photoAlbumProvider.notifier)
                      .remove(_allPhotos[index]);
                }),
          ],
        );
      },
    );
  }
}
