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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blueAccent],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.4, 0.7],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: const Padding(
            padding: EdgeInsets.only(top: 10, right: 5, left: 5),
            child: PhotoListWidget()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CameraPage()));
          },
          backgroundColor: Colors.grey,
          child: const Icon(Icons.add_a_photo),
        ),
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
    _allPhotos.sort(((a, b) => a.photoTakenDate.compareTo(b.photoTakenDate)));
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 0.6,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: _allPhotos.length,
      itemBuilder: (BuildContext ctx, index) {
        return FocusedMenuHolder(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: const SizedBox(),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.file(_allPhotos[index].image,
                                fit: BoxFit.cover)
                            .image,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    _allPhotos[index].title,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ))
            ],
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
