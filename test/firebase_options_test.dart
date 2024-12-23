import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:expense_tracker/firebase_options.dart';

void main() {
  group('DefaultFirebaseOptions Tests', () {
    test('should return correct FirebaseOptions for web platform', () {
      // Simulating that the platform is Web
      if (kIsWeb) {
        final options = DefaultFirebaseOptions.currentPlatform;

        expect(options.apiKey, 'AIzaSyBmY33_C39mTjretin7qUZqrc56cEsDGL4');
        expect(options.appId, '1:980153311724:web:f0769df8f4ff2cf13560c9');
        expect(options.messagingSenderId, '980153311724');
        expect(options.projectId, 'expensetracker-b6e55');
      }
    });

    test('should return correct FirebaseOptions for android platform', () {
      // Simulating Android platform by checking if defaultTargetPlatform is Android
      if (defaultTargetPlatform == TargetPlatform.android) {
        final options = DefaultFirebaseOptions.currentPlatform;

        expect(options.apiKey, 'AIzaSyBhhifaPqr9HSBiG30YswtJsJjqCH42cs8');
        expect(options.appId, '1:980153311724:android:c7f7bbc8c33668753560c9');
        expect(options.messagingSenderId, '980153311724');
        expect(options.projectId, 'expensetracker-b6e55');
      }
    });

    test('should return correct FirebaseOptions for iOS platform', () {
      // Simulating iOS platform by checking if defaultTargetPlatform is iOS
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        final options = DefaultFirebaseOptions.currentPlatform;

        expect(options.apiKey, 'AIzaSyDkAoSisDneUpvzEiyqYrsUpebZCe_stns');
        expect(options.appId, '1:980153311724:ios:c9d45a649c671de93560c9');
        expect(options.messagingSenderId, '980153311724');
        expect(options.projectId, 'expensetracker-b6e55');
        expect(options.iosBundleId, 'com.example.expenseTracker');
      }
    });

    test('should throw UnsupportedError for linux platform', () {
      // Simulating Linux platform by checking if defaultTargetPlatform is Linux
      if (defaultTargetPlatform == TargetPlatform.linux) {
        expect(() => DefaultFirebaseOptions.currentPlatform,
            throwsA(isA<UnsupportedError>()));
      }
    });

    test('should return correct FirebaseOptions for macOS platform', () {
      // Simulating macOS platform by checking if defaultTargetPlatform is macOS
      if (defaultTargetPlatform == TargetPlatform.macOS) {
        final options = DefaultFirebaseOptions.currentPlatform;

        expect(options.apiKey, 'AIzaSyDkAoSisDneUpvzEiyqYrsUpebZCe_stns');
        expect(options.appId, '1:980153311724:ios:c9d45a649c671de93560c9');
        expect(options.messagingSenderId, '980153311724');
        expect(options.projectId, 'expensetracker-b6e55');
        expect(options.iosBundleId, 'com.example.expenseTracker');
      }
    });

    test('should return correct FirebaseOptions for Windows platform', () {
      // Simulating Windows platform by checking if defaultTargetPlatform is Windows
      if (defaultTargetPlatform == TargetPlatform.windows) {
        final options = DefaultFirebaseOptions.currentPlatform;

        expect(options.apiKey, 'AIzaSyBmY33_C39mTjretin7qUZqrc56cEsDGL4');
        expect(options.appId, '1:980153311724:web:e147ca5842bf109c3560c9');
        expect(options.messagingSenderId, '980153311724');
        expect(options.projectId, 'expensetracker-b6e55');
      }
    });
  });
}
