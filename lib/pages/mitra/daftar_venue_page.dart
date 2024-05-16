import 'package:flutter/material.dart';
// import 'package:gallery_picker/gallery_picker.dart';

// class DaftarVenuePage extends StatefulWidget {
//   const DaftarVenuePage({super.key});

//   @override
//   State<DaftarVenuePage> createState() => _DaftarVenuePageState();
// }

// class _DaftarVenuePageState extends State<DaftarVenuePage> {
//   List<MediaFile> _selectedFiles = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildUI(),
//       floatingActionButton: _selectImageFromGalleryButton(),
//     );
//   }

//   Widget _selectImageFromGalleryButton() {
//     return FloatingActionButton(
//       onPressed: () async {
//         List<MediaFile> mediaFiles = await GalleryPicker.pickMedia(
//               context: context,
//               singleMedia: false,
//             ) ??
//             [];
//         setState(() {
//           _selectedFiles = mediaFiles;
//         });
//       },
//       child: const Icon(
//         Icons.image,
//       ),
//     );
//   }

//   Widget _buildUI() {
//     return GridView.builder(
//       scrollDirection: Axis.horizontal,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//       ),
//       itemCount: _selectedFiles.length,
//       itemBuilder: (context, index) {
//         MediaFile file = _selectedFiles[index];
//         if (file.isImage) {
//           return PhotoProvider(media: file);
//         } else if (file.isVideo) {
//           return VideoProvider(media: file);
//         }
//       },
//     );
//   }
// }

class DaftarVenuePage extends StatelessWidget {
  const DaftarVenuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Venue'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [],
      )),
    );
  }
}
