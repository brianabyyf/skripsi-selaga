import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DaftarVenuePage extends StatefulWidget {
  const DaftarVenuePage({super.key});

  @override
  State<DaftarVenuePage> createState() => _DaftarVenuePageState();
}

class _DaftarVenuePageState extends State<DaftarVenuePage> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length: ${imageFileList!.length.toString()}");
    print(imageFileList!.first.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Venue'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 300,
            child: GridView.builder(
              itemCount: imageFileList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.file(
                    File(imageFileList![index].path),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              selectImages();
            },
            child: Container(
                height: 200,
                width: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: const Center(
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 30,
                  ),
                )),
          )
        ],
      )),
    );
  }
}
