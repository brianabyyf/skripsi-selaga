import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selaga_ver1/pages/components/my_checkbox.dart';
import 'package:selaga_ver1/pages/mitra/success_daftar_venue_page.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';

class DaftarVenuePage extends StatefulWidget {
  final String token;
  const DaftarVenuePage({super.key, required this.token});

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

  List<File> _uploadImg = [];

  var _isSending = false;
  var _boxChecked = false;
  var _boxChecked2 = false;
  var _boxChecked3 = false;
  var _boxChecked4 = false;

  void _uploadVenue() async {
    if (_image == null) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukan Foto Lapangan Utama'),
          duration: Duration(milliseconds: 1200),
        ),
      );
    }
    if (_imageFileList!.isEmpty) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukan Foto lainnya'),
          duration: Duration(milliseconds: 1200),
        ),
      );
    }
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      _uploadImg.add(File(_image!.path));
      for (XFile image in _imageFileList!) {
        _uploadImg.add(File(image.path));
      }

      var data = await ApiRepository().daftarVenue(widget.token, _uploadImg);
      if (data.result != null) {
        if (!context.mounted) {
          return;
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SuccesssDaftarVenuePage(
                    token: widget.token,
                  )),
        );
      } else {
        setState(() {
          _isSending = false;
        });
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data.error}'),
            duration: const Duration(milliseconds: 1100),
          ),
        );
      }
    }
  }

  void _selectImages() async {
    final XFile? selectedImages = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    setState(() {
      if (selectedImages != null) {
        _image = XFile(selectedImages.path);
      }
    });
  }

  void _selectMultiImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage(
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);
    if (selectedImages.isNotEmpty) {
      _imageFileList!.addAll(selectedImages);
    }
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
              Column(
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
                          MyCheckBox(
                            hintText: 'Free Wifi',
                            velue: _boxChecked,
                            onChanged: (value) {
                              setState(() {
                                _boxChecked = value!;
                              });
                            },
                          ),
                          MyCheckBox(
                            hintText: 'Warung/Cafe',
                            velue: _boxChecked2,
                            onChanged: (value) {
                              setState(() {
                                _boxChecked2 = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          MyCheckBox(
                            hintText: 'Parkir Motor',
                            velue: _boxChecked3,
                            onChanged: (value) {
                              setState(() {
                                _boxChecked3 = value!;
                              });
                            },
                          ),
                          MyCheckBox(
                            hintText: 'Parkir Mobil',
                            velue: _boxChecked4,
                            onChanged: (value) {
                              setState(() {
                                _boxChecked4 = value!;
                              });
                            },
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
              InkWell(
                onTap: _isSending ? null : _uploadVenue,
                // onTap: () {
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => SuccesssDaftarVenuePage(
                //               token: widget.token,
                //             )),
                //   );
                // },
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
