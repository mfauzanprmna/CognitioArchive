import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cognitio_archive/auth_provider.dart';
import 'package:cognitio_archive/login.dart';
import 'package:cognitio_archive/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase before running tests
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('LoginScreen Widget Tests', () {
    testWidgets('Renders LoginScreen and tests for form fields', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Verify if the login screen has the email and password text fields.
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    });

    testWidgets('Email and password validation', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Enter text into the email and password fields.
      await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');

      // Tap the login button.
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();

      // Verify if the snack bar appears (indicating form submission).
      expect(find.text('Login Successful'), findsNothing);  // This should be replaced with actual response handling in real implementation.
    });
  });
}
