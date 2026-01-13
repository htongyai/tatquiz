import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'personality_intro_screen.dart';
import '../config/app_localizations.dart';
import '../config/language_config.dart';
import '../widgets/language_selector.dart';
import '../services/firebase_service.dart';
import '../models/quiz_data.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  bool _isAuthenticating = false;
  bool _authCompleted = false;

  @override
  void initState() {
    super.initState();
    // Log screen view
    _firebaseService.logScreenView(screenName: 'start_screen');
    // Start authentication in background
    _authenticateInBackground();
    // Precache background and UI images for instant loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/Background_home.webp'), context);
      precacheImage(const AssetImage('assets/Info layer2.png'), context);
      // Preload images for next screen (personality_intro_screen) in background
      _preloadNextScreenImages();
    });
  }

  void _preloadNextScreenImages() {
    // Preload personality_intro_screen images in background (non-blocking)
    precacheImage(const AssetImage('assets/Background_Red.webp'), context);
    precacheImage(const AssetImage('assets/step1.png'), context);
    precacheImage(const AssetImage('assets/step2.png'), context);
    precacheImage(const AssetImage('assets/step3.png'), context);
    precacheImage(const AssetImage('assets/indi.png'), context);
    // Preload all quiz backgrounds (non-blocking, will continue in background)
    for (int i = 1; i <= quizQuestions.length; i++) {
      final image = AssetImage('assets/Background_Q$i.webp');
      precacheImage(image, context).catchError((e) {
        // Silently handle errors, continue preloading others
      });
    }
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Language',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            LanguageSelector(
              onLanguageChanged: () {
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _authenticateInBackground() async {
    if (_isAuthenticating || _authCompleted) return;

    setState(() {
      _isAuthenticating = true;
    });

    try {
      // Check if already signed in
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        print('Already signed in: ${currentUser.uid}');
        _authCompleted = true;
        return;
      }

      // Sign in anonymously
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print('Signed in anonymously in background: ${userCredential.user?.uid}');

      // Create user session
      await _firebaseService.createUserSession(country: 'Unknown');

      if (mounted) {
        setState(() {
          _authCompleted = true;
        });
      }
    } catch (e) {
      print('Error during background authentication: $e');
      // Don't show error to user, will retry when they click Start Journey
    } finally {
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  Future<void> _onStartJourney() async {
    // Navigate immediately - don't wait for anything
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PersonalityIntroScreen()),
      );
    }

    // Continue authentication in background (non-blocking)
    if (!_authCompleted && !_isAuthenticating) {
      _authenticateInBackground().catchError((e) {
        print('Background auth error: $e');
        // Retry once in background
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted && !_authCompleted) {
            _authenticateInBackground();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Background_home.webp'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              // Info layer image
                              Image.asset(
                                'assets/Info layer2.png',
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                              // Button positioned inside the ticket
                              Positioned(
                                bottom: 60,
                                left: 40,
                                right: 40,
                                child: SizedBox(
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: _onStartJourney,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00477A),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                        side: const BorderSide(
                                          color: Color(0xFFF39C21),
                                          width: 3,
                                        ),
                                      ),
                                      elevation: 4,
                                    ),
                                    child: Text(
                                      AppLocalizations.startJourney,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  // Globe icon for language selector (always visible)
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _showLanguageSelector,
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            //color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.2),
                            //     blurRadius: 8,
                            //     offset: const Offset(0, 2),
                            //   ),
                            //],
                          ),
                          child: const Icon(
                            Icons.language,
                            size: 18,
                            color: Color(0xFF00477A),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Language selector (debug only - kept for backward compatibility)
                  if (debugLanguage)
                    Positioned(
                      top: 70,
                      right: 20,
                      child: LanguageSelector(
                        onLanguageChanged: () {
                          setState(() {});
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
