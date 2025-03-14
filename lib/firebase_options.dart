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
    apiKey: 'AIzaSyD6DXdM8C-j4tNl25Vc0xAR1A2y1k7_6KA',
    appId: '1:1021370042273:web:dd0cf2bfa390da5d3c2de0',
    messagingSenderId: '1021370042273',
    projectId: 'expensestracker-96b6c',
    authDomain: 'expensestracker-96b6c.firebaseapp.com',
    storageBucket: 'expensestracker-96b6c.firebasestorage.app',
    measurementId: 'G-4F30D00VGY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGJZSkWLcw2Mx47M8lCKX1w_-GxooYz88',
    appId: '1:1021370042273:android:898e9e80f910542f3c2de0',
    messagingSenderId: '1021370042273',
    projectId: 'expensestracker-96b6c',
    storageBucket: 'expensestracker-96b6c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgspN4A71_1JpEgSe5R5BUS2RWAKS2o10',
    appId: '1:1021370042273:ios:0c152d3d812bd3693c2de0',
    messagingSenderId: '1021370042273',
    projectId: 'expensestracker-96b6c',
    storageBucket: 'expensestracker-96b6c.firebasestorage.app',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgspN4A71_1JpEgSe5R5BUS2RWAKS2o10',
    appId: '1:1021370042273:ios:0c152d3d812bd3693c2de0',
    messagingSenderId: '1021370042273',
    projectId: 'expensestracker-96b6c',
    storageBucket: 'expensestracker-96b6c.firebasestorage.app',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD6DXdM8C-j4tNl25Vc0xAR1A2y1k7_6KA',
    appId: '1:1021370042273:web:dab19be52ab206dd3c2de0',
    messagingSenderId: '1021370042273',
    projectId: 'expensestracker-96b6c',
    authDomain: 'expensestracker-96b6c.firebaseapp.com',
    storageBucket: 'expensestracker-96b6c.firebasestorage.app',
    measurementId: 'G-11C7NRRZKF',
  );
}
