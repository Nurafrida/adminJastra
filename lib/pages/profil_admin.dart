import 'package:flutter/material.dart';
import 'package:flutter_app/pages/daftar_pesanan_admin.dart';
import 'package:flutter_app/pages/ganti_sandi_admin.dart';
import 'package:flutter_app/pages/log_in_admin.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_katalog_admin.dart';
import 'home_live_chat_admin.dart';

class ProfilAdmin extends StatelessWidget {
  const ProfilAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/vectors/vector_31_x2.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Profil',
          style: GoogleFonts.getFont(
            'DM Sans',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.3,
            letterSpacing: 0.2,
            color: const Color(0xFF000000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(26, 20, 24, 35),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF000000)),
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      width: 67,
                      height: 63,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE0E0E0),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/vectors/ellipse_12_x2.svg',
                          width: 36,
                          height: 36,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
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
                        Text(
                          'Admin 1',
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
                    const Spacer(),
                    Container(
                      width: 36,
                      height: 37.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE0E0E0),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/vectors/vector_24_x2.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildMenuItem(
              context,
              label: 'Ganti Kata Sandi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GantiSandiAdmin()),
                );
              },
            ),
            _buildMenuItem(
              context,
              label: 'Daftar Pesanan',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DaftarPesananAdmin()),
                );
              },
            ),
            _buildMenuItem(
              context,
              label: 'Keluar',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInAdmin()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required String label, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 26, 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD38609)),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFFFFFF),
      ),
      child: ListTile(
        title: Text(
          label,
          style: GoogleFonts.getFont(
            'DM Sans',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 1.4,
            letterSpacing: 0.2,
            color: const Color(0xFF000000),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(210, 226, 129, 10),
      child: SizedBox(
        height: 50, // Adjusted height
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

  const BottomNavItem({
    required this.iconPath,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, height: 35), // Adjusted icon height
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w700,
              fontSize: 12, // Adjusted font size
              letterSpacing: 0.2,
              color: const Color(0xFFFDFDFD),
            ),
          ),
        ],
      ),
    );
  }
}
