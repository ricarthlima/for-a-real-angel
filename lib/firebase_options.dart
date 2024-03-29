// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBdfjjKeR3WHClk-AEWNWewpXDaBkrTbd8',
    appId: '1:274526408897:web:c0a5fba911c5a915c08440',
    messagingSenderId: '274526408897',
    projectId: 'fara-535bf',
    authDomain: 'fara-535bf.firebaseapp.com',
    databaseURL: 'https://fara-535bf.firebaseio.com',
    storageBucket: 'fara-535bf.appspot.com',
    measurementId: 'G-ZC506GBF3V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgy9mFC0cYGs1SkqGYVcRBctPoUByjxa8',
    appId: '1:274526408897:android:7c58dec585fa3c01c08440',
    messagingSenderId: '274526408897',
    projectId: 'fara-535bf',
    databaseURL: 'https://fara-535bf.firebaseio.com',
    storageBucket: 'fara-535bf.appspot.com',
  );
}
