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
    apiKey: 'AIzaSyBNuMXqiUeMiiWXneC6FsqylZWHs1uAYKg',
    appId: '1:560735137860:web:b90bfcea0645c349ddcc11',
    messagingSenderId: '560735137860',
    projectId: 'to-do-list-69233',
    authDomain: 'to-do-list-69233.firebaseapp.com',
    databaseURL: 'https://to-do-list-69233-default-rtdb.firebaseio.com',
    storageBucket: 'to-do-list-69233.firebasestorage.app',
    measurementId: 'G-ZM0HNJLSMK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAblQ5MGAqY4bTSjIanvwqF9ZNK5yA4C_k',
    appId: '1:560735137860:android:06d07a028612ddebddcc11',
    messagingSenderId: '560735137860',
    projectId: 'to-do-list-69233',
    databaseURL: 'https://to-do-list-69233-default-rtdb.firebaseio.com',
    storageBucket: 'to-do-list-69233.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBNuMXqiUeMiiWXneC6FsqylZWHs1uAYKg',
    appId: '1:560735137860:web:f0fe50b53dc6683cddcc11',
    messagingSenderId: '560735137860',
    projectId: 'to-do-list-69233',
    authDomain: 'to-do-list-69233.firebaseapp.com',
    databaseURL: 'https://to-do-list-69233-default-rtdb.firebaseio.com',
    storageBucket: 'to-do-list-69233.firebasestorage.app',
    measurementId: 'G-2ZT16VR5J7',
  );
}
