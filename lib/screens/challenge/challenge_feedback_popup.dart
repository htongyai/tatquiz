import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Challenge Feedback Popup Widget
/// 
/// Displays feedback after user answers a True/False question.
/// Shows encouraging message and explanation with True/False icon.
class ChallengeFeedbackPopup extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final VoidCallback onNext;

  const ChallengeFeedbackPopup({
    super.key,
    required this.isCorrect,
    required this.explanation,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // Prevent dismissing on background tap
      child: Material(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: 0.8 + (value * 0.2), // Scale from 0.8 to 1.0
                child: child,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 60),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF6EC), // Cream background
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // True/False icon with circular backdrop
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Thicker effect - draw icon with slight offsets in 8 directions
                        for (int i = 0; i < 8; i++)
                          Transform.translate(
                            offset: Offset(
                              1.0 * (i % 2 == 0 ? 1 : -1) * (i < 4 ? 1 : 0.7),
                              1.0 * ((i ~/ 2) % 2 == 0 ? 1 : -1) * (i < 4 ? 0.7 : 1),
                            ),
                            child: Icon(
                              isCorrect ? Icons.check : Icons.close,
                              color: isCorrect 
                                  ? const Color(0xFF007930).withOpacity(0.5) // Green for correct
                                  : const Color(0xFF81021F).withOpacity(0.5), // Red for incorrect
                              size: 32,
                            ),
                          ),
                        // Main icon on top
                        Icon(
                          isCorrect ? Icons.check : Icons.close,
                          color: isCorrect 
                              ? const Color(0xFF007930) // Green for correct
                              : const Color(0xFF81021F), // Red for incorrect
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Encouraging message
                Text(
                  isCorrect 
                      ? 'Great job!' 
                      : 'Not quite! But keep going!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Explanation text
                Text(
                  explanation,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Next button - matching intro screen style but smaller (secondary)
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFF39C21),
                        width: 2,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEB521A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: const BorderSide(
                            color: Color(0xFFF39C21),
                            width: 3,
                          ),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16,
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
    );
  }
}

