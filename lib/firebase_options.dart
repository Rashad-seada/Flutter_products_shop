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
    apiKey: 'AIzaSyD3YQzA4FqLpeTgSmcI9KRu43q8smPrho8',
    appId: '1:799374770568:web:82deb2955f567e8da43a3d',
    messagingSenderId: '799374770568',
    projectId: 'sign-in-434c6',
    authDomain: 'sign-in-434c6.firebaseapp.com',
    storageBucket: 'sign-in-434c6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAk95o9Utr9AftKH2ffIjzA5RaG-gEUST4',
    appId: '1:799374770568:android:0502870dc62b0059a43a3d',
    messagingSenderId: '799374770568',
    projectId: 'sign-in-434c6',
    storageBucket: 'sign-in-434c6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7wkLQ25sbf-SswkYfcvcOkO5OSAzwmSc',
    appId: '1:799374770568:ios:e8065f0a28669c50a43a3d',
    messagingSenderId: '799374770568',
    projectId: 'sign-in-434c6',
    storageBucket: 'sign-in-434c6.appspot.com',
    iosClientId: '799374770568-3l6sl9gp30o9n5ar3j6fsmkf9li6g1qa.apps.googleusercontent.com',
    iosBundleId: 'com.example.engShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7wkLQ25sbf-SswkYfcvcOkO5OSAzwmSc',
    appId: '1:799374770568:ios:a2cd8886067bf77aa43a3d',
    messagingSenderId: '799374770568',
    projectId: 'sign-in-434c6',
    storageBucket: 'sign-in-434c6.appspot.com',
    iosClientId: '799374770568-5ed0vfscees2fjajknilqd77vv18ft9v.apps.googleusercontent.com',
    iosBundleId: 'com.example.engShop.RunnerTests',
  );
}
