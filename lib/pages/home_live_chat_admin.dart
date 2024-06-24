import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'live_chat_admin.dart';
import 'home_katalog_admin.dart';
import 'profil_admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Chat Admin',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeLiveChatAdmin(),
    );
  }
}

class HomeLiveChatAdmin extends StatelessWidget {
  const HomeLiveChatAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Chat',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700,
            fontSize: 19,
            letterSpacing: 0.2,
            color: const Color(0xFF000000),
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset('assets/vectors/vector_23_x2.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('messages').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              children: snapshot.data!.docs.map((doc) {
                return ChatItem(
                  name: doc['name'],
                  message: doc['message'],
                  imageUrl: doc['imageUrl'],
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMessagePage()),
          );
        },
        backgroundColor: Color.fromARGB(210, 226, 129, 10),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String name;
  final String message;
  final String imageUrl;

  const ChatItem({super.key, 
    required this.name,
    required this.message,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LiveChatAdmin(
              name: name,
              imageUrl: imageUrl, message: '',
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xA6D38609)),
          borderRadius: BorderRadius.circular(15),
          color: const Color(0x4AD9D9D9),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(21, 20, 0, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color.fromARGB(210, 226, 129, 10)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 4, 0, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          name,
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            letterSpacing: 0.2,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      message,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: 0.2,
                        color: const Color(0x6ED38609),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddMessagePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  AddMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pesan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Pesan'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'URL Foto Profil'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_nameController.text.isNotEmpty &&
                    _messageController.text.isNotEmpty &&
                    _imageUrlController.text.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('messages').add({
                    'name': _nameController.text,
                    'message': _messageController.text,
                    'imageUrl': _imageUrlController.text,
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color.fromARGB(210, 226, 129, 10),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              iconPath: 'assets/vectors/chapter_1_x2.svg',
              label: 'Katalog',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeKatalogAdmin(),
                  ),
                );
              },
            ),
            BottomNavItem(
              iconPath: 'assets/vectors/chat_6_x2.svg',
              label: 'Pesan',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeLiveChatAdmin(),
                  ),
                );
              },
            ),
            BottomNavItem(
              iconPath: 'assets/vectors/account_4_x2.svg',
              label: 'Profil',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilAdmin(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const BottomNavItem({super.key, 
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, height: 35),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.2,
              color: const Color(0xFFFDFDFD),
            ),
          ),
        ],
      ),
    );
  }
}
