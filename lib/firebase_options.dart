// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDae-T8_G_U7AnYa7yWHYx8twTsqYG0L2U',
    appId: '1:13364387461:web:22ecc110554ae51a3e13ec',
    messagingSenderId: '13364387461',
    projectId: 'jastraadmin',
    authDomain: 'jastraadmin.firebaseapp.com',
    storageBucket: 'jastraadmin.appspot.com',
    measurementId: 'G-LV1JQVBFE4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB6QevTTMCT-RAUthtMpDB6n8LUAQhjE2U',
    appId: '1:13364387461:android:ff2387c8fa311a3c3e13ec',
    messagingSenderId: '13364387461',
    projectId: 'jastraadmin',
    storageBucket: 'jastraadmin.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyIXGDkhQd1p-wVp152vntF1biRVqLsZY',
    appId: '1:13364387461:ios:489d77cfcd6948d53e13ec',
    messagingSenderId: '13364387461',
    projectId: 'jastraadmin',
    storageBucket: 'jastraadmin.appspot.com',
    iosBundleId: 'com.example.flutterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyIXGDkhQd1p-wVp152vntF1biRVqLsZY',
    appId: '1:13364387461:ios:489d77cfcd6948d53e13ec',
    messagingSenderId: '13364387461',
    projectId: 'jastraadmin',
    storageBucket: 'jastraadmin.appspot.com',
    iosBundleId: 'com.example.flutterApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDae-T8_G_U7AnYa7yWHYx8twTsqYG0L2U',
    appId: '1:13364387461:web:6a92069462ee3e593e13ec',
    messagingSenderId: '13364387461',
    projectId: 'jastraadmin',
    authDomain: 'jastraadmin.firebaseapp.com',
    storageBucket: 'jastraadmin.appspot.com',
    measurementId: 'G-LNKNFFSLJY',
  );
}
