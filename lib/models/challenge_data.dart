import 'package:flutter/material.dart';
import '../config/language_config.dart';

/// Challenge Data Model
/// 
/// This file contains the challenge quiz questions organized by character.
/// Each character has 5 True/False questions about Thailand knowledge.

class ChallengeQuestion {
  final int number;
  final String question;
  final bool correctAnswer; // true = True, false = False
  final String explanation; // Explanation text from CSV

  ChallengeQuestion({
    required this.number,
    required this.question,
    required this.correctAnswer,
    required this.explanation,
  });
}

/// Get challenge questions based on character and current language
/// 
/// Each character has a unique set of 5 questions.
/// Questions are organized by language, similar to the main quiz.
List<ChallengeQuestion> getChallengeQuestions(String character) {
  if (LanguageConfig.isRussian) {
    return _getCharacterQuestions(character, _russianChallengeQuestions);
  }
  if (LanguageConfig.isSpanish) {
    return _getCharacterQuestions(character, _spanishChallengeQuestions);
  }
  if (LanguageConfig.isGerman) {
    return _getCharacterQuestions(character, _germanChallengeQuestions);
  }
  // Default to English
  return _getCharacterQuestions(character, _englishChallengeQuestions);
}

/// Helper function to get questions for a specific character from a language map
List<ChallengeQuestion> _getCharacterQuestions(
  String character,
  Map<String, List<ChallengeQuestion>> languageMap,
) {
  switch (character) {
    case 'Mali':
      return languageMap['Mali'] ?? _englishChallengeQuestions['Mali']!;
    case 'Chang-Noi':
      return languageMap['Chang-Noi'] ?? _englishChallengeQuestions['Chang-Noi']!;
    case 'Ping':
      return languageMap['Ping'] ?? _englishChallengeQuestions['Ping']!;
    case 'Chai':
      return languageMap['Chai'] ?? _englishChallengeQuestions['Chai']!;
    case 'Pla-Kad':
      return languageMap['Pla-Kad'] ?? _englishChallengeQuestions['Pla-Kad']!;
    default:
      return languageMap['Mali'] ?? _englishChallengeQuestions['Mali']!;
  }
}

/// Get background color for challenge screens based on character
Color getChallengeBackgroundColor(String character) {
  switch (character) {
    case 'Mali':
      return const Color(0xFFF5A623); // Orange/Yellow
    case 'Chang-Noi':
      return const Color(0xFF8B0000); // Dark Red
    case 'Ping':
      return const Color(0xFF00A3A3); // Turquoise/Teal
    case 'Chai':
      return const Color(0xFF2E7D32); // Green
    case 'Pla-Kad':
      return const Color(0xFF1E3A5F); // Blue
    default:
      return const Color(0xFFF5A623);
  }
}

/// Get background image path for challenge screens based on character.
/// 
/// The images live under `assets/challenge_asset/` and are named:
/// - background_challenge_mali.webp
/// - background_challenge_changnoi.webp
/// - background_challenge_ping.webp
/// - background_challenge_chai.webp
/// - background_challenge_plakad.webp
/// 
String getChallengeBackgroundImage(String character) {
  switch (character) {
    case 'Mali':
      return 'assets/challenge_asset/background_challenge_mali.webp';
    case 'Chang-Noi':
      return 'assets/challenge_asset/background_challenge_changnoi.webp';
    case 'Ping':
      return 'assets/challenge_asset/background_challenge_ping.webp';
    case 'Chai':
      return 'assets/challenge_asset/background_challenge_chai.webp';
    case 'Pla-Kad':
      return 'assets/challenge_asset/background_challenge_plakad.webp';
    default:
      return 'assets/challenge_asset/background_challenge_mali.webp';
  }
}

// ============================================
// ENGLISH CHALLENGE QUESTIONS
// ============================================

final Map<String, List<ChallengeQuestion>> _englishChallengeQuestions = {
  'Chang-Noi': [
    ChallengeQuestion(
      number: 1,
      question: 'Elephants are deeply connected to Thai history and used to appear in ancient royal ceremonies.',
      correctAnswer: true,
      explanation: 'Elephants symbolize wisdom, strength, and royal heritage in Thailand.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Visitors should dress with covered shoulders and knees when entering Thai temples.',
      correctAnswer: true,
      explanation: 'Modest clothing shows respect in sacred spaces.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Thai flower garlands (phuang malai) are commonly used as offerings at shrines.',
      correctAnswer: true,
      explanation: 'Garlands represent respect, blessings, and good intentions.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Most Thai temples encourage visitors to chant aloud upon entering.',
      correctAnswer: false,
      explanation: 'Temples are quiet spaces; silence is considered respectful.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'The Songkran festival originally began as a royal celebration held only in palaces.',
      correctAnswer: false,
      explanation: 'It started as a community tradition to cleanse, renew, and give blessings.',
    ),
  ],
  'Mali': [
    ChallengeQuestion(
      number: 1,
      question: 'Siamese cats are believed to bring good luck in Thai folklore.',
      correctAnswer: true,
      explanation: 'The "Wichian Mat" is one of Thailand\'s heritage cat breeds.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Butterfly pea tea gets its blue-purple color naturally.',
      correctAnswer: true,
      explanation: 'It\'s made from the dok anchan flower.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Ari is a Bangkok neighborhood famous for cafés and lifestyle spots.',
      correctAnswer: true,
      explanation: 'It\'s known for calm streets and stylish creative cafés.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Most Thai boutique cafés are decorated entirely with neon lights.',
      correctAnswer: false,
      explanation: 'Thai café culture leans toward handcrafted, cozy, aesthetic design.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Old Thai shophouses were originally built with minimal decoration for modern city planning.',
      correctAnswer: false,
      explanation: 'They were built long ago with wooden textures and Sino-Thai charm.',
    ),
  ],
  'Ping': [
    ChallengeQuestion(
      number: 1,
      question: 'Dugongs are gentle marine mammals found in Thailand\'s southern waters.',
      correctAnswer: true,
      explanation: 'Especially near Trang and the Andaman coast.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'A good snorkeling practice is avoiding touching coral and marine animals.',
      correctAnswer: true,
      explanation: 'Even slight contact can damage fragile ecosystems.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'The Andaman Sea is famous for turquoise waters and limestone cliffs.',
      correctAnswer: true,
      explanation: 'This is what makes Krabi and Phuket iconic.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'It is safe to approach sea turtles closely while snorkeling.',
      correctAnswer: false,
      explanation: 'Turtles need space to breathe and behave naturally.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Koh Tao is known mainly for nightlife and has few diving sites.',
      correctAnswer: false,
      explanation: 'It\'s one of the world\'s major diving capitals.',
    ),
  ],
  'Chai': [
    ChallengeQuestion(
      number: 1,
      question: 'Water buffaloes are symbols of Thai countryside life and farming traditions.',
      correctAnswer: true,
      explanation: 'They are beloved companions in rural culture.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Northern Thailand is known for peaceful rice terraces.',
      correctAnswer: true,
      explanation: 'Places like Mae Chaem and Chiang Mai are famous for them.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'A herbal compress in Thai wellness is used to relax muscles.',
      correctAnswer: true,
      explanation: 'It\'s filled with lemongrass, kaffir lime, turmeric, and herbs.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Moo Krata is a traditional Thai dessert.',
      correctAnswer: false,
      explanation: 'It\'s the iconic Thai BBQ-hotpot combo.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'The Thai wai gesture is mainly used during sports events.',
      correctAnswer: false,
      explanation: 'Its purpose is greeting, respect, and gratitude.',
    ),
  ],
  'Pla-Kad': [
    ChallengeQuestion(
      number: 1,
      question: 'Betta fish are admired in Thailand for their vibrant colors and elegant fins.',
      correctAnswer: true,
      explanation: 'They\'re considered living art and a Thai cultural symbol.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Many Michelin-recognized restaurants in Thailand serve modern interpretations of Thai dishes.',
      correctAnswer: true,
      explanation: 'Thai fine dining is globally respected.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Thai silk is famed for its texture and shimmering handwoven finish.',
      correctAnswer: true,
      explanation: 'Especially Jim Thompson and Isaan weavers.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Benjarong ceramics usually come in one solid color.',
      correctAnswer: false,
      explanation: 'Benjarong is known for elaborate multi-color patterns.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Traditional Thai massage mainly uses oils instead of pressure techniques.',
      correctAnswer: false,
      explanation: 'Thai massage focuses on stretching and deep pressure.',
    ),
  ],
};

// ============================================
// SPANISH CHALLENGE QUESTIONS
// TODO: Add Spanish translations when provided
// ============================================
final Map<String, List<ChallengeQuestion>> _spanishChallengeQuestions = {
  'Chang-Noi': _englishChallengeQuestions['Chang-Noi']!,
  'Mali': _englishChallengeQuestions['Mali']!,
  'Ping': _englishChallengeQuestions['Ping']!,
  'Chai': _englishChallengeQuestions['Chai']!,
  'Pla-Kad': _englishChallengeQuestions['Pla-Kad']!,
};

// ============================================
// GERMAN CHALLENGE QUESTIONS
// TODO: Add German translations when provided
// ============================================
final Map<String, List<ChallengeQuestion>> _germanChallengeQuestions = {
  'Chang-Noi': _englishChallengeQuestions['Chang-Noi']!,
  'Mali': _englishChallengeQuestions['Mali']!,
  'Ping': _englishChallengeQuestions['Ping']!,
  'Chai': _englishChallengeQuestions['Chai']!,
  'Pla-Kad': _englishChallengeQuestions['Pla-Kad']!,
};

// ============================================
// RUSSIAN CHALLENGE QUESTIONS
// TODO: Add Russian translations when provided
// ============================================
final Map<String, List<ChallengeQuestion>> _russianChallengeQuestions = {
  'Chang-Noi': _englishChallengeQuestions['Chang-Noi']!,
  'Mali': _englishChallengeQuestions['Mali']!,
  'Ping': _englishChallengeQuestions['Ping']!,
  'Chai': _englishChallengeQuestions['Chai']!,
  'Pla-Kad': _englishChallengeQuestions['Pla-Kad']!,
};
