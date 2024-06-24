// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/daftar_pesanan_admin.dart';
import 'pages/forgot_pass_admin.dart';
import 'pages/ganti_sandi_admin.dart';
import 'pages/home_katalog_admin.dart';
import 'pages/home_live_chat_admin.dart';
import 'pages/live_chat_admin.dart';
import 'pages/log_in_admin.dart';
import 'pages/profil_admin.dart';
import 'pages/sign_up_admin.dart';
import 'pages/start_admin.dart';
import 'pages/tambah_katalog_admin.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter App',
      home: Scaffold(

        body: StartAdmin(),
        // body: DaftarPesananAdmin(),
        // body: ForgotPassAdmin(),
        // body: GantiSandiAdmin(),
        // body: HomeKatalogAdmin(),
        // body: HomeLiveChatAdmin(),
        // body: LiveChatAdmin(),
        // body: LogInAdmin(),
        // body: ProfilAdmin(),
        // body: SignUpAdmin(),
        // body: StartAdmin(),
        // body: TambahKatalogAdmin(),

      ),
    );
  }
}
