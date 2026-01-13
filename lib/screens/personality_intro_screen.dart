import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quiz_question_screen.dart';
import '../config/app_localizations.dart';
import '../config/language_config.dart';
import '../widgets/language_selector.dart';
import '../models/quiz_data.dart';
import '../services/firebase_service.dart';

class PersonalityIntroScreen extends StatefulWidget {
  const PersonalityIntroScreen({super.key});

  @override
  State<PersonalityIntroScreen> createState() => _PersonalityIntroScreenState();
}

class _PersonalityIntroScreenState extends State<PersonalityIntroScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.85,
    initialPage: 0,
  );
  int _currentPage = 0;
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();

    // Log screen view
    FirebaseService().logScreenView(screenName: 'personality_intro_screen');

    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });

    // Start auto-slide timer
    _startAutoSlide();

    // Preload all quiz backgrounds while user is on the intro screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 1; i <= quizQuestions.length; i++) {
        final image = AssetImage('assets/Background_Q$i.jpg');
        precacheImage(image, context);
      }
    });
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % 3;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoSlide() {
    _autoSlideTimer?.cancel();
  }

  void _resetAutoSlide() {
    _stopAutoSlide();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _stopAutoSlide();
    _pageController.dispose();
    super.dispose();
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
                image: AssetImage('assets/Background_Red.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      // Title
                      Text(
                        AppLocalizations.howToPlay,
                        style: GoogleFonts.courgette(
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Progress indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildProgressDot(0, true),
                          _buildProgressLine(0),
                          _buildProgressDot(1, true),
                          _buildProgressLine(1),
                          _buildProgressDot(2, false),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // Scrollable cards
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: 3,
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: (index) {
                            // Reset auto-slide timer when user manually changes page
                            _resetAutoSlide();
                          },
                          itemBuilder: (context, index) {
                            final images = [
                              'assets/step1.png',
                              'assets/step2.png',
                              'assets/step3.png',
                            ];
                            return GestureDetector(
                              onPanDown: (_) {
                                // Stop auto-slide when user starts dragging
                                _stopAutoSlide();
                              },
                              onPanEnd: (_) {
                                // Resume auto-slide after dragging ends
                                _resetAutoSlide();
                              },
                              child: _buildStepImage(images[index], index),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Begin Quiz button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              // Log quiz started
                              FirebaseService().logQuizStarted();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QuizQuestionScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEB521A),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                                side: const BorderSide(
                                  color: Color(0xFFF39C21),
                                  width: 3,
                                ),
                              ),
                              elevation: 6,
                              shadowColor: Colors.black.withOpacity(0.3),
                            ),
                            child: Text(
                              AppLocalizations.beginQuiz,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                  // Language selector (debug only)
                  if (debugLanguage)
                    Positioned(
                      top: 20,
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

  Widget _buildProgressDot(int index, bool isComplete) {
    bool isCurrent = index == _currentPage;

    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background image
          Image.asset(
            'assets/indi.png',
            width: 50,
            height: 50,
            fit: BoxFit.contain,
            color: isCurrent
                ? Colors.white
                : (isComplete
                      ? const Color(0xFFE89B5C)
                      : const Color(0xFFE8D5B7)),
          ),
          // Checkmark
          if (isComplete || isCurrent)
            const Icon(Icons.check, color: Color(0xFFD17B3C), size: 28),
        ],
      ),
    );
  }

  Widget _buildProgressLine(int index) {
    return Container(width: 60, height: 3, color: const Color(0xFFD17B3C));
  }

  Widget _buildStepImage(String imagePath, int index) {
    bool isCurrent = index == _currentPage;

    return AnimatedScale(
      scale: isCurrent ? 1.0 : 0.9,
      duration: const Duration(milliseconds: 300),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
