import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/challenge_data.dart';
import 'challenge_score_screen.dart';
import 'challenge_feedback_popup.dart';

/// Challenge Quiz Screen
///
/// This screen displays True/False questions for the challenge quiz.
/// It uses the same design patterns as the main quiz screen but with
/// only 2 answer options (True/False) aligned as buttons.
///
/// Parameters:
/// - [characterName]: The character result from the personality quiz
///   This determines which set of questions and background color to use.
class ChallengeQuizScreen extends StatefulWidget {
  final String characterName;

  const ChallengeQuizScreen({super.key, required this.characterName});

  @override
  State<ChallengeQuizScreen> createState() => _ChallengeQuizScreenState();
}

class _ChallengeQuizScreenState extends State<ChallengeQuizScreen> {
  int currentQuestion = 0;
  int correctAnswers = 0;
  final List<bool?> userAnswers =
      []; // null = not answered, true/false = answer
  bool _showFeedback = false;

  @override
  void initState() {
    super.initState();
    final questions = getChallengeQuestions(widget.characterName);
    userAnswers.addAll(List.filled(questions.length, null));
  }

  void _selectAnswer(bool answer) {
    if (userAnswers[currentQuestion] != null) return; // Already answered

    setState(() {
      userAnswers[currentQuestion] = answer;
      final question = getChallengeQuestions(
        widget.characterName,
      )[currentQuestion];
      if (answer == question.correctAnswer) {
        correctAnswers++;
      }
      _showFeedback = true; // Show feedback popup
    });
  }

  void _handleNext() {
    setState(() {
      _showFeedback = false;
    });

    final questions = getChallengeQuestions(widget.characterName);
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      // Quiz completed, navigate to score screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChallengeScoreScreen(
            characterName: widget.characterName,
            score: correctAnswers,
            totalQuestions: questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = getChallengeQuestions(widget.characterName);
    final question = questions[currentQuestion];
    final backgroundColor = getChallengeBackgroundColor(widget.characterName);
    final backgroundImage = getChallengeBackgroundImage(widget.characterName);
    final hasAnswered = userAnswers[currentQuestion] != null;

    // Text color - white for better contrast on colored backgrounds
    const textColor = Colors.white;

    // Indicator color - use a lighter shade for visibility
    const indicatorColor = Color(0xFFEB8C1A);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 50),
                      // Main content
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Train image and progress indicator
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Text(
                                      'Question ${currentQuestion + 1} of ${questions.length}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/Train.png',
                                    width: double.infinity,
                                    height: 50,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // The horizontal line
                                        Container(height: 2, color: indicatorColor),
                                        // Dots evenly distributed
                                        Positioned.fill(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: List.generate(
                                              questions.length,
                                              (index) {
                                                bool isPast =
                                                    index < currentQuestion;
                                                bool isCurrent =
                                                    index == currentQuestion;

                                                return Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    // White circle for current question
                                                    if (isCurrent)
                                                      Container(
                                                        width: 22,
                                                        height: 22,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black
                                                                  .withOpacity(0.2),
                                                              blurRadius: 4,
                                                              offset: const Offset(
                                                                0,
                                                                2,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    // Dot
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        color: indicatorColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // Content with max width constraint
                              Center(
                                child: Container(
                                  constraints: const BoxConstraints(maxWidth: 400),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 2,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 12),
                                      // Question text
                                      Text(
                                        textAlign: TextAlign.center,
                                        question.question,
                                        style: GoogleFonts.courgette(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                          color: textColor,
                                          height: 1.2,
                                          shadows: [
                                            const Shadow(
                                              blurRadius: 8.0,
                                              color: Colors.black38,
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 48),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Floating True/False buttons at bottom
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [backgroundColor.withOpacity(0), backgroundColor],
                        ),
                      ),
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // True button
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: InkWell(
                                  onTap: hasAnswered
                                      ? null
                                      : () => _selectAnswer(true),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          hasAnswered &&
                                              userAnswers[currentQuestion] == true
                                          ? const Color(0xFF1E4A7A)
                                          : const Color(0xFFFFFBF5),
                                      border: Border.all(
                                        color:
                                            hasAnswered &&
                                                userAnswers[currentQuestion] == true
                                            ? const Color(0xFF1E4A7A)
                                            : const Color(0xFF1E4A7A),
                                        width:
                                            hasAnswered &&
                                                userAnswers[currentQuestion] == true
                                            ? 0
                                            : 2,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              hasAnswered &&
                                                  userAnswers[currentQuestion] ==
                                                      true
                                              ? const Color(0xFF1E4A7A)
                                              : const Color(
                                                  0xFF1E4A7A,
                                                ).withOpacity(0.4),
                                          blurRadius: 0,
                                          spreadRadius: 0,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'True',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              hasAnswered &&
                                                  userAnswers[currentQuestion] ==
                                                      true
                                              ? Colors.white
                                              : const Color(0xFF1E4A7A),
                                          fontWeight: FontWeight.w600,
                                          height: 1.3,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // False button
                              InkWell(
                                onTap: hasAnswered
                                    ? null
                                    : () => _selectAnswer(false),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 18,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        hasAnswered &&
                                            userAnswers[currentQuestion] == false
                                        ? const Color(0xFF1E4A7A)
                                        : const Color(0xFFFFFBF5),
                                    border: Border.all(
                                      color:
                                          hasAnswered &&
                                              userAnswers[currentQuestion] == false
                                          ? const Color(0xFF1E4A7A)
                                          : const Color(0xFF1E4A7A),
                                      width:
                                          hasAnswered &&
                                              userAnswers[currentQuestion] == false
                                          ? 0
                                          : 2,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            hasAnswered &&
                                                userAnswers[currentQuestion] ==
                                                    false
                                            ? const Color(0xFF1E4A7A)
                                            : const Color(
                                                0xFF1E4A7A,
                                              ).withOpacity(0.4),
                                        blurRadius: 0,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'False',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            hasAnswered &&
                                                userAnswers[currentQuestion] ==
                                                    false
                                            ? Colors.white
                                            : const Color(0xFF1E4A7A),
                                        fontWeight: FontWeight.w600,
                                        height: 1.3,
                                      ),
                                      textAlign: TextAlign.center,
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
                  // Feedback popup overlay
                  if (_showFeedback)
                    ChallengeFeedbackPopup(
                      isCorrect:
                          userAnswers[currentQuestion] == question.correctAnswer,
                      explanation: question.explanation,
                      onNext: _handleNext,
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
