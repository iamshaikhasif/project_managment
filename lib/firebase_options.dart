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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyAIl2dmlA39Slo7oZvmYPDsh2UVIJZW0_o',
    appId: '1:183564574917:web:14d639e60730f6cef250ac',
    messagingSenderId: '183564574917',
    projectId: 'project-magment',
    authDomain: 'project-magment.firebaseapp.com',
    storageBucket: 'project-magment.appspot.com',
    measurementId: 'G-9JB59Y6W0Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDst4tp1iTc8OJ_z69m1az1DoKzoeoNc7g',
    appId: '1:183564574917:android:364bd705c7b46852f250ac',
    messagingSenderId: '183564574917',
    projectId: 'project-magment',
    storageBucket: 'project-magment.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDE-gPV9eOHKr-zcpANz_LkQs6xVZXQkwg',
    appId: '1:183564574917:ios:78a511d9cb5c0140f250ac',
    messagingSenderId: '183564574917',
    projectId: 'project-magment',
    storageBucket: 'project-magment.appspot.com',
    iosBundleId: 'com.example.projectMangmentFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDE-gPV9eOHKr-zcpANz_LkQs6xVZXQkwg',
    appId: '1:183564574917:ios:bd191d78614c8eccf250ac',
    messagingSenderId: '183564574917',
    projectId: 'project-magment',
    storageBucket: 'project-magment.appspot.com',
    iosBundleId: 'com.example.projectMangmentFlutter.RunnerTests',
  );
}
