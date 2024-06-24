import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_live_chat_admin.dart';
import 'package:flutter_app/pages/profil_admin.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tambah_katalog_admin.dart';

class HomeKatalogAdmin extends StatefulWidget {
  const HomeKatalogAdmin({super.key});

  @override
  _HomeKatalogAdminState createState() => _HomeKatalogAdminState();
}

class _HomeKatalogAdminState extends State<HomeKatalogAdmin> {
  final CollectionReference _katalogRef = FirebaseFirestore.instance.collection('katalog');
  int _selectedIndex = 0;

  void _navigateToTambahKatalog() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TambahKatalogAdmin(),
      ),
    );

    if (result != null) {
      // Simpan item baru ke Firestore
      _katalogRef.add({
        'nama': result['nama'],
        'harga': result['harga'],
      });
    }
  }

  void _deleteItem(String docId) {
    _katalogRef.doc(docId).delete();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeKatalogAdmin()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeLiveChatAdmin()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilAdmin()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.storage_sharp),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Pesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: const Color.fromARGB(210, 226, 129, 10),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 31, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(27.9, 0, 0, 23),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: Text(
                      'JASTRA',
                      style: GoogleFonts.getFont(
                        'DM Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                        letterSpacing: 0.2,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Hi, Jastipers',
                            style: GoogleFonts.getFont(
                              'DM Sans',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.3,
                              letterSpacing: 0.2,
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Mau jastip apa hari ini ??',
                        style: GoogleFonts.getFont(
                          'DM Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          height: 1.3,
                          letterSpacing: 0.2,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _katalogRef.snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            final items = snapshot.data!.docs;
                            return Expanded(
                              child: ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  var item = items[index];
                                  return Container(
                                    margin: const EdgeInsets.fromLTRB(24.5, 0, 24.5, 17),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(15, 13, 13, 16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.fromLTRB(0, 10, 7, 0),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                            'assets/images/image_51.png',
                                                          ),
                                                        ),
                                                      ),
                                                      child: const SizedBox(
                                                        width: 67,
                                                        height: 67,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 33),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                          child: Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(
                                                              item['nama'],
                                                              style: GoogleFonts.getFont(
                                                                'DM Sans',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 16,
                                                                letterSpacing: 0.2,
                                                                color: const Color(0xFF000000),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'RP. ${item['harga']}',
                                                          style: GoogleFonts.getFont(
                                                            'DM Sans',
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 14,
                                                            letterSpacing: 0.2,
                                                            color: const Color(0xFF000000),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                                              child: GestureDetector(
                                                onTap: () => _deleteItem(item.id),
                                                child: SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: SvgPicture.asset(
                                                    'assets/vectors/icon_trash_2_x2.svg',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(25, 0, 24, 20),
                          child: GestureDetector(
                            onTap: _navigateToTambahKatalog,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 113,
                                padding: const EdgeInsets.fromLTRB(1, 27, 0, 27),
                                child: Center(
                                  child: Icon(Icons.add, size: 40, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
