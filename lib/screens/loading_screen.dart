import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'result_screen.dart';
import '../config/app_localizations.dart';

class LoadingScreen extends StatefulWidget {
  final Map<String, int> characterScores;
  final String userAge;
  final String userInterest;

  const LoadingScreen({
    super.key,
    required this.characterScores,
    required this.userAge,
    required this.userInterest,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // Animation controller for progress bar
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Find the character with the highest score
        String winningCharacter = widget.characterScores.entries
            .reduce((a, b) => a.value > b.value ? a : b)
            .key;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              characterName: winningCharacter,
              userAge: widget.userAge,
              userInterest: widget.userInterest,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
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
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Train image
                      Image.asset(
                        'assets/Train_loading.png',
                        width: 500,
                        height: 80,
                        fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(height: 10),
                      // Loading text
                      Text(
                        AppLocalizations.findingYourTravelSpirit,
                        style: GoogleFonts.courgette(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      // Progress bar
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: _animationController.value,
                              minHeight: 12,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFFEB8C1A),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
