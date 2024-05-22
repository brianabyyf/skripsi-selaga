import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DaftarVenuePage extends StatefulWidget {
  const DaftarVenuePage({super.key});

  @override
  State<DaftarVenuePage> createState() => _DaftarVenuePageState();
}

class _DaftarVenuePageState extends State<DaftarVenuePage> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _alamatController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? _imageFileList = [];
  XFile? _image;

  var _isSending = false;
  var _boxChecked = false;
  var _boxChecked2 = false;
  var _boxChecked3 = false;
  var _boxChecked4 = false;

  void _selectImages() async {
    final XFile? selectedImages = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (selectedImages != null) {
        _image = XFile(selectedImages.path);
      }
    });

    print(_image!.path);
  }

  void _selectMultiImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      _imageFileList!.addAll(selectedImages);
    }
    print("Image List Length: ${_imageFileList!.length.toString()}");
    print(_imageFileList!.first.path);
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
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nama Venue',
                      ),
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Nama Venue is missing!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi Venue',
                      ),
                      controller: _descController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Deskripsi Venue is missing!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Alamat Venue',
                      ),
                      controller: _alamatController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Alamat Venue is missing!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  checkColor:
                                      const Color.fromRGBO(76, 76, 220, 1),
                                  fillColor: const MaterialStatePropertyAll(
                                      Colors.white),
                                  value: _boxChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _boxChecked = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Free Wifi',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor:
                                      const Color.fromRGBO(76, 76, 220, 1),
                                  fillColor: const MaterialStatePropertyAll(
                                      Colors.white),
                                  value: _boxChecked2,
                                  onChanged: (value) {
                                    setState(() {
                                      _boxChecked2 = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Warung/Cafe',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  checkColor:
                                      const Color.fromRGBO(76, 76, 220, 1),
                                  fillColor: const MaterialStatePropertyAll(
                                      Colors.white),
                                  value: _boxChecked3,
                                  onChanged: (value) {
                                    setState(() {
                                      _boxChecked3 = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Parkir Motor',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor:
                                      const Color.fromRGBO(76, 76, 220, 1),
                                  fillColor: const MaterialStatePropertyAll(
                                      Colors.white),
                                  value: _boxChecked4,
                                  onChanged: (value) {
                                    setState(() {
                                      _boxChecked4 = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Parkir Mobil',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Foto lapangan (utama)',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        _selectImages();
                      },
                      child: Container(
                          height: 135,
                          width: 135,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: _image != null
                              ? Image.file(
                                  File(_image!.path),
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 30,
                                  ),
                                )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Foto lainnya', style: TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                _selectMultiImages();
                              },
                              child: Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 30,
                                    ),
                                  )),
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _imageFileList!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: SizedBox(
                                    width: 120,
                                    child: Image.file(
                                      File(_imageFileList![index].path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              InkWell(
                // onTap: _isSending ? null : _signInUser,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  // margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(76, 76, 220, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: _isSending
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Daftar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
