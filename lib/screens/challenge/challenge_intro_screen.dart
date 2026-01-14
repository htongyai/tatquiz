import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../challenge/challenge_quiz_screen.dart';
import '../../models/challenge_data.dart';
import '../../config/app_localizations.dart';

/// Challenge Intro Screen
///
/// This screen introduces the challenge quiz to the user.
/// It displays a welcome message and a button to start the challenge.
///
/// Parameters:
/// - [characterName]: The character result from the personality quiz
///   This determines which set of questions and background color to use.
class ChallengeIntroScreen extends StatelessWidget {
  final String characterName;

  const ChallengeIntroScreen({super.key, required this.characterName});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = getChallengeBackgroundColor(characterName);
    final backgroundImage = getChallengeBackgroundImage(characterName);

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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Trophy icon
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDFCEF),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/challenge_asset/icon_award.svg',
                                width: 60,
                                height: 60,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Subtitle
                          Text(
                            AppLocalizations.howWellDoYouKnowThailand,
                            style: GoogleFonts.courgette(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              shadows: [
                                const Shadow(
                                  blurRadius: 8.0,
                                  color: Colors.black38,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          // Description
                          Text(
                            AppLocalizations.testYourThailandKnowledge,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.95),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 48),
                          // Start Challenge button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                  color: const Color(
                                    0xFFF39C21,
                                  ), // Light-orange border
                                  width: 3,
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Use pushReplacement to replace intro screen with quiz screen
                                  // This keeps Result Screen in the stack for easy navigation back
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChallengeQuizScreen(
                                        characterName: characterName,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                    0xFFEB521A,
                                  ), // Red-orange background
                                  foregroundColor: Colors.white, // White text
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.startChallenge,
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
}
