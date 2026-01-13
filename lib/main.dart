import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const TravelQuizApp());
}

class TravelQuizApp extends StatelessWidget {
  const TravelQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Personality Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const StartScreen(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Wrap all screens with responsive wrapper
        return ResponsiveWrapper(child: child ?? const SizedBox());
      },
    );
  }
}

/// Wrapper that constrains the app to mobile phone aspect ratio
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF2C2C2C), // Dark grey background for sides
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 430, // Max phone width (iPhone 14 Pro Max width)
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
