import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_fonts/google_fonts.dart';
import '../../models/challenge_data.dart';
import '../../services/firebase_service.dart';

// Conditional import for web
import 'challenge_score_screen_stub.dart'
    if (dart.library.html) 'challenge_score_screen_web.dart'
    as web_helper;

/// Challenge Score Screen
///
/// This screen displays the final score after completing the challenge quiz.
/// It shows both text score (e.g., "Your Score: 4/5") and a percentage gauge.
///
/// Parameters:
/// - [characterName]: The character result from the personality quiz
/// - [score]: Number of correct answers
/// - [totalQuestions]: Total number of questions (should be 5)
class ChallengeScoreScreen extends StatefulWidget {
  final String characterName;
  final int score;
  final int totalQuestions;

  const ChallengeScoreScreen({
    super.key,
    required this.characterName,
    required this.score,
    required this.totalQuestions,
  });

  @override
  State<ChallengeScoreScreen> createState() => _ChallengeScoreScreenState();
}

class _ChallengeScoreScreenState extends State<ChallengeScoreScreen> {
  final GlobalKey _cardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Submit challenge score to Firebase
    _submitChallengeScore();
  }

  Future<void> _submitChallengeScore() async {
    try {
      await FirebaseService().submitChallengeScore(
        characterName: widget.characterName,
        score: widget.score,
        totalQuestions: widget.totalQuestions,
      );
      print('Challenge score submitted successfully');
    } catch (e) {
      print('Error submitting challenge score: $e');
      // Don't show error to user, just log it
    }
  }

  String _getScoreMessage() {
    final percentage = (widget.score / widget.totalQuestions * 100).round();
    if (percentage >= 80) {
      return 'Thailand Expert! You really know your stuff! Great job! Your answers show strong knowledge about Thailand\'s culture and travel gems.';
    } else if (percentage >= 60) {
      return 'Well done! You have good knowledge about Thailand. Keep exploring to learn more!';
    } else {
      return 'Good try! There\'s always more to discover about Thailand. Try again to improve your score!';
    }
  }

  Future<Uint8List?> _captureWidget() async {
    try {
      final RenderRepaintBoundary boundary =
          _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveAndShareImage() async {
    try {
      // Capture the screenshot
      final imageBytes = await _captureWidget();
      if (imageBytes == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to capture image')),
          );
        }
        return;
      }

      // Use web helper for browser download
      if (kIsWeb) {
        web_helper.downloadImage(
          imageBytes,
          'thailand_challenge_result_${DateTime.now().millisecondsSinceEpoch}.png',
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image download is only available on web'),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving image: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = getChallengeBackgroundColor(widget.characterName);
    final backgroundImage = getChallengeBackgroundImage(widget.characterName);
    final percentage = (widget.score / widget.totalQuestions * 100).round();
    final screenWidth = MediaQuery.of(context).size.width;
    final constrainedWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final cardWidth = constrainedWidth > 400 ? 400.0 : (constrainedWidth - 48).toDouble();
    final cardHeight = cardWidth * 16 / 9; // 9:16 aspect ratio

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      // Result card container with Stack for floating share button
                      Stack(
                        children: [
                          // RepaintBoundary for screenshot capture - card without share button
                          RepaintBoundary(
                            key: _cardKey,
                            child: Container(
                              width: cardWidth,
                              height: cardHeight,
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFDFCEF),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Top content
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // "Based on your travel personality" text
                                        Text(
                                          'Based on your travel personality',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 8),
                                        // Character name
                                        Text(
                                          '${widget.characterName} The ${_getCharacterSubtitle(widget.characterName)}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 32),
                                        // Score text
                                        Text(
                                          'Your score is',
                                          style: GoogleFonts.courgette(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 32),
                                        // Circular progress gauge with inner lighter shade
                                        SizedBox(
                                          width: 150,
                                          height: 150,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              // Outer background circle
                                              SizedBox(
                                                width: 150,
                                                height: 150,
                                                child: CircularProgressIndicator(
                                                  value: 1.0,
                                                  strokeWidth: 24,
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.grey[300]!),
                                                ),
                                              ),
                                              // Progress circle (thicker, to the inside)
                                              SizedBox(
                                                width: 150,
                                                height: 150,
                                                child: CircularProgressIndicator(
                                                  value: percentage / 100,
                                                  strokeWidth: 24,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(
                                                        const Color(0xFFFFD56D),
                                                      ),
                                                ),
                                              ),
                                              // Inner lighter shade circle
                                              SizedBox(
                                                width: 120,
                                                height: 120,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: const Color(
                                                      0xFFFFD56D,
                                                    ).withOpacity(0.3),
                                                  ),
                                                ),
                                              ),
                                              // Percentage text
                                              Text(
                                                '$percentage%',
                                                style: const TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        // Score message in red box
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF8B1538),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            _getScoreMessage(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              height: 1.5,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Hashtags at bottom with 20px padding
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      'Thailand Challenge — how well do you know Thailand? #AmazingThailand #TravelPersonality',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        height: 1.4,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Floating share button at bottom right corner of card
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: _saveAndShareImage,
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // Back to My Result button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate back to result screen
                              // Since we used pushReplacement in the challenge flow,
                              // the stack is: Result Screen -> Challenge Score
                              // So we just need to pop once to get back to Result Screen
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEB521A),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Text(
                              'Back to My Result',
                              style: TextStyle(
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
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    ),
    );
  }

  String _getCharacterSubtitle(String character) {
    switch (character) {
      case 'Mali':
        return 'Chic Cat';
      case 'Chang-Noi':
        return 'Heritage Guardian';
      case 'Ping':
        return 'Thrill Chaser';
      case 'Chai':
        return 'Peaceful Soul';
      case 'Pla-Kad':
        return 'Refined Traveler';
      default:
        return 'Chic Cat';
    }
  }
}
