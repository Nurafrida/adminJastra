import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahKatalogAdmin extends StatefulWidget {
  const TambahKatalogAdmin({super.key});

  @override
  _TambahKatalogAdminState createState() => _TambahKatalogAdminState();
}

class _TambahKatalogAdminState extends State<TambahKatalogAdmin> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  Uint8List? _webImage;
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    if (kIsWeb) {
      final pickedFile = await ImagePickerWeb.getImageAsBytes();
      if (pickedFile != null) {
        setState(() {
          _webImage = pickedFile;
        });
      } else {
        print('No image selected.');
      }
    } else {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    }
  }

  Future<void> _uploadKatalog() async {
    try {
      if ((_webImage != null || _image != null) &&
          _namaController.text.isNotEmpty &&
          _kategoriController.text.isNotEmpty &&
          _hargaController.text.isNotEmpty) {
        // Upload image to Firebase Storage
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

        if (kIsWeb && _webImage != null) {
          await ref.putData(_webImage!);
        } else {
          await ref.putFile(_image!);
        }

        String imageUrl = await ref.getDownloadURL();

        // Add katalog to Firestore
        await FirebaseFirestore.instance.collection('catalog').add({
          'name': _namaController.text,
          'category': _kategoriController.text,
          'price': int.parse(_hargaController.text),
          'image_url': imageUrl,
        });

        // Navigate back to previous screen
        Navigator.of(context).pop();
      } else {
        // Show error message if fields are empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all fields and select an image.')),
        );
      }
    } catch (e) {
      print('Error uploading katalog: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Katalog'),
        backgroundColor: Color.fromARGB(210, 226, 129, 10),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: getImage,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 38),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    border: Border.all(color: const Color(0xFFD38609)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: _webImage != null
                      ? Image.memory(_webImage!, width: double.infinity, height: 150, fit: BoxFit.cover)
                      : _image != null
                          ? Image.file(_image!, width: double.infinity, height: 150, fit: BoxFit.cover)
                          : SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: Center(
                                child: Text(
                                  'Upload here',
                                  style: GoogleFonts.getFont(
                                    'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    letterSpacing: 0.2,
                                    color: const Color(0x5CD38609),
                                  ),
                                ),
                              ),
                            ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Nama Barang',
                style: GoogleFonts.getFont(
                  'DM Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.4,
                  letterSpacing: 0.2,
                  color: const Color(0xFF000000),
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: const Color(0xFFD38609)),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Kategori',
                style: GoogleFonts.getFont(
                  'DM Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.4,
                  letterSpacing: 0.2,
                  color: const Color(0xFF000000),
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _kategoriController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: const Color(0xFFD38609)),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Harga',
                style: GoogleFonts.getFont(
                  'DM Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.4,
                  letterSpacing: 0.2,
                  color: const Color(0xFF000000),
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _hargaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: const Color(0xFFD38609)),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _uploadKatalog,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color.fromRGBO(226, 129, 10, 0.824)),
                    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
                    textStyle: WidgetStateProperty.all(
                      GoogleFonts.getFont(
                        'DM Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white
                      ),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: Text('Tambah Katalog',),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
