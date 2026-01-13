import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/quiz_data.dart';
import 'user_info_screen.dart';
import '../config/app_localizations.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({super.key});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  int currentQuestion = 0;
  final Map<String, int> characterScores = {
    'Chang-Noi': 0,
    'Mali': 0,
    'Ping': 0,
    'Chai': 0,
    'Pla-Kad': 0,
  };

  String? selectedAnswer;
  String? selectedCharacter;

  @override
  void initState() {
    super.initState();

    // Preload all quiz background images once, so switching questions is instant
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 1; i <= quizQuestions.length; i++) {
        precacheImage(AssetImage('assets/Background_Q$i.jpg'), context);
      }
    });
  }

  void _selectAnswer(String character, String answer) {
    setState(() {
      selectedAnswer = answer;
      selectedCharacter = character;
    });

    // Add point to the selected character
    characterScores[character] = characterScores[character]! + 1;

    // Automatically move to next question after a short delay
    Future.delayed(const Duration(milliseconds: 250), () {
      if (currentQuestion < quizQuestions.length - 1) {
        setState(() {
          currentQuestion++;
          selectedAnswer = null;
          selectedCharacter = null;
        });
      } else {
        // Quiz completed, navigate to user info
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                UserInfoScreen(characterScores: characterScores),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[currentQuestion];
    final backgroundImage = 'assets/Background_Q${currentQuestion + 1}.jpg';

    // Define text colors for each question based on background
    final List<Color> questionTextColors = [
      const Color(0xFF80011D), // Q1 - dark maroon
      const Color(0xFFFFFFFF), // Q2 - white
      const Color(0xFFFFFFFF), // Q3 - dark maroon
      const Color(0xFFFFFFFF), // Q4 - white
      const Color(0xFF80011D), // Q5 - dark maroon
      const Color(0xFFFFFFFF), // Q6 - dark maroon
      const Color(0xFFFFFFFF), // Q7 - dark maroon
      const Color(0xFF80011D), // Q8 - dark maroon
      const Color(0xFFFFFFFF), // Q9 - white
      const Color(0xFFFFFFFF), // Q10 - dark maroon
      const Color(0xFFFFFFFF), // Q11 - dark maroon
      const Color(0xFF80011D), // Q12 - dark maroon
    ];

    final textColor = questionTextColors[currentQuestion];

    // Define indicator colors for specific questions (Q1, Q3, Q6, Q7 use blue, others use orange)
    final bool usesBlueIndicator =
        currentQuestion == 0 ||
        currentQuestion == 2 ||
        currentQuestion == 5 ||
        currentQuestion == 6;
    final Color indicatorColor = usesBlueIndicator
        ? const Color(0xFF00477A)
        : const Color(0xFFD17B3C);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // AppBar content
              SizedBox(height: 10),
              // Text(
              //   'Question ${currentQuestion + 1} of ${quizQuestions.length}',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.bold,
              //     color: textColor,
              //   ),
              // ),
              // Main content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Train image full screen width
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              AppLocalizations.questionOf(
                                currentQuestion + 1,
                                quizQuestions.length,
                              ),
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
                            height: 20,
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
                                      quizQuestions.length,
                                      (index) {
                                        bool isPast = index < currentQuestion;
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
                                                color: isPast || isCurrent
                                                    ? indicatorColor
                                                    : indicatorColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                // Full-width train image
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
                              const SizedBox(height: 5),
                              Text(
                                textAlign: TextAlign.center,
                                question.question,
                                style: GoogleFonts.courgette(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: textColor,
                                  height: 1.2,
                                  shadows: textColor == const Color(0xFFFFFFFF)
                                      ? [
                                          const Shadow(
                                            blurRadius: 8.0,
                                            color: Colors.black38,
                                            offset: Offset(1.0, 1.0),
                                          ),
                                        ]
                                      : [],
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Answer options
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: question.options.length,
                                itemBuilder: (context, index) {
                                  final character = question.options.keys
                                      .elementAt(index);
                                  final option = question.options[character]!;
                                  final isSelected = selectedAnswer == option;

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: InkWell(
                                      onTap: () =>
                                          _selectAnswer(character, option),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? const Color(0xFFEB8C1A)
                                              : const Color(0xFFFFFBF5),
                                          border: Border.all(
                                            color: isSelected
                                                ? const Color(0xFFEB8C1A)
                                                : const Color(0xFF1E4A7A),
                                            width: isSelected ? 0 : 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: isSelected
                                                  ? const Color(0xFFD17B3C)
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
                                            option,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isSelected
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
                                  );
                                },
                              ),
                              const SizedBox(height: 40),
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
        ),
      ),
    );
  }
}
