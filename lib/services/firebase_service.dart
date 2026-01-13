import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../config/language_config.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Get the collection name based on current language
  String _getLanguageCollection() {
    if (LanguageConfig.isEnglish) {
      return 'UnitedKingdom';
    } else if (LanguageConfig.isSpanish) {
      return 'Spain';
    } else if (LanguageConfig.isGerman) {
      return 'Germany';
    } else if (LanguageConfig.isRussian) {
      return 'Russia';
    }
    // Default to UnitedKingdom if no match
    return 'UnitedKingdom';
  }

  /// Create a new session when user starts journey
  Future<void> createUserSession({String? country}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userId = user.uid;
      final languageCollection = _getLanguageCollection();
      // Use language collection as country if not provided
      final sessionCountry = country ?? languageCollection;

      // Get the user document reference
      final userDocRef = _firestore
          .collection('Analytics')
          .doc(languageCollection)
          .collection('users')
          .doc(userId);

      // Get current session count
      final userDoc = await userDocRef.get();
      int sessionNumber = 1;

      if (userDoc.exists) {
        final data = userDoc.data();
        sessionNumber = (data?['sessionCount'] ?? 0) + 1;
      }

      // Create session data
      final sessionData = {
        'sessionNumber': sessionNumber,
        'startTime': FieldValue.serverTimestamp(),
        'country': sessionCountry,
        'language': LanguageConfig.currentLanguageName,
        'languageCode': LanguageConfig.languageCode,
      };

      // Update or create user document with new session
      await userDocRef.set({
        'userId': userId,
        'sessionCount': sessionNumber,
        'lastSession': sessionData,
        'country': sessionCountry, // Add country to user document
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Also add to sessions subcollection for detailed tracking
      await userDocRef.collection('sessions').add(sessionData);

      // Update country document stats for sessions
      final countryDocRef = _firestore
          .collection('Analytics')
          .doc(languageCollection);

      await countryDocRef.set({
        'stats': {
          'totalSessions': FieldValue.increment(1),
          'lastUpdated': FieldValue.serverTimestamp(),
        },
        'sessions': {
          'total': FieldValue.increment(1),
          'lastSessionTime': FieldValue.serverTimestamp(),
        },
      }, SetOptions(merge: true));

      // Update overall document for sessions
      final overallDocRef = _firestore.collection('Analytics').doc('overall');
      await overallDocRef.set({
        'stats': {
          'totalSessions': FieldValue.increment(1),
          'lastUpdated': FieldValue.serverTimestamp(),
        },
        'countryTotals': {languageCollection: FieldValue.increment(1)},
      }, SetOptions(merge: true));

      // Log session start
      await countryDocRef.collection('logs').add({
        'userId': userId,
        'sessionNumber': sessionNumber,
        'timestamp': FieldValue.serverTimestamp(),
        'language': LanguageConfig.currentLanguageName,
        'languageCode': LanguageConfig.languageCode,
        'type': 'session_started',
        'country': sessionCountry,
      });

      // Log to Firebase Analytics
      await logSessionStart();

      print(
        'Session $sessionNumber created for user $userId in $languageCollection',
      );
    } catch (e) {
      print('Error creating user session: $e');
      rethrow;
    }
  }

  /// Submit user quiz data to Firestore
  Future<void> submitQuizData({
    required String gender,
    required String age,
    required String nationality,
    required String characterResult,
    required Map<String, int> characterScores,
  }) async {
    try {
      // Get current user ID
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userId = user.uid;
      final languageCollection = _getLanguageCollection();

      // Get current session number
      final userDocRef = _firestore
          .collection('Analytics')
          .doc(languageCollection)
          .collection('users')
          .doc(userId);

      final userDoc = await userDocRef.get();
      final sessionNumber = userDoc.data()?['sessionCount'] ?? 1;

      // Prepare data
      final data = {
        'userId': userId,
        'sessionNumber': sessionNumber,
        'gender': gender,
        'age': age,
        'nationality': nationality,
        'characterResult': characterResult,
        'characterScores': characterScores,
        'timestamp': FieldValue.serverTimestamp(),
        'language': LanguageConfig.currentLanguageName,
        'languageCode': LanguageConfig.languageCode,
      };

      // Write to Analytics/{languageCollection}/responses collection
      await _firestore
          .collection('Analytics')
          .doc(languageCollection)
          .collection('responses')
          .add(data);

      // Update user document with latest quiz result and demographic info
      await userDocRef.update({
        'latestQuizResult': characterResult,
        'latestQuizTimestamp': FieldValue.serverTimestamp(),
        'nationality': nationality, // Add nationality to user document
        'gender': gender, // Add gender to user document
        'age': age, // Add age to user document
      });

      // Update country document stats and log
      await _updateCountryStats(
        languageCollection: languageCollection,
        characterResult: characterResult,
        gender: gender,
        age: age,
        nationality: nationality,
      );

      // Add to quiz play log
      await _logQuizPlay(
        languageCollection: languageCollection,
        userId: userId,
        sessionNumber: sessionNumber,
        characterResult: characterResult,
      );

      // Log to Firebase Analytics
      await logQuizCompleted(
        characterResult: characterResult,
        characterScores: characterScores,
      );

      // Set user properties in Analytics
      await setUserProperties(
        gender: gender,
        age: age,
        nationality: nationality,
      );

      print('Data submitted successfully to Analytics/$languageCollection');
    } catch (e) {
      print('Error submitting quiz data: $e');
      rethrow;
    }
  }

  /// Update country document statistics
  Future<void> _updateCountryStats({
    required String languageCollection,
    required String characterResult,
    required String gender,
    required String age,
    required String nationality,
  }) async {
    try {
      final countryDocRef = _firestore
          .collection('Analytics')
          .doc(languageCollection);

      // Update stats using increment
      await countryDocRef.set({
        'stats': {
          'totalQuizzes': FieldValue.increment(1),
          'characterCounts': {characterResult: FieldValue.increment(1)},
          'genderCounts': {gender: FieldValue.increment(1)},
          'ageCounts': {age: FieldValue.increment(1)},
          'nationalityCounts': {nationality: FieldValue.increment(1)},
          'lastUpdated': FieldValue.serverTimestamp(),
        },
      }, SetOptions(merge: true));

      // Also update overall stats
      await _updateOverallStats(
        languageCollection: languageCollection,
        characterResult: characterResult,
        gender: gender,
        age: age,
        nationality: nationality,
      );

      print('Country stats updated for $languageCollection');
    } catch (e) {
      print('Error updating country stats: $e');
      // Don't rethrow - we don't want to fail the entire submission if stats update fails
    }
  }

  /// Update overall analytics document
  Future<void> _updateOverallStats({
    required String languageCollection,
    required String characterResult,
    required String gender,
    required String age,
    required String nationality,
  }) async {
    try {
      final overallDocRef = _firestore.collection('Analytics').doc('overall');

      // Update overall stats
      await overallDocRef.set({
        'stats': {
          'totalPlayers': FieldValue.increment(1),
          'totalQuizzes': FieldValue.increment(1),
          'characterCounts': {characterResult: FieldValue.increment(1)},
          'genderCounts': {gender: FieldValue.increment(1)},
          'ageCounts': {age: FieldValue.increment(1)},
          'nationalityCounts': {nationality: FieldValue.increment(1)},
          'lastUpdated': FieldValue.serverTimestamp(),
        },
        'countryTotals': {languageCollection: FieldValue.increment(1)},
      }, SetOptions(merge: true));

      print('Overall stats updated');
    } catch (e) {
      print('Error updating overall stats: $e');
      // Don't rethrow
    }
  }

  /// Log quiz play to country document
  Future<void> _logQuizPlay({
    required String languageCollection,
    required String userId,
    required int sessionNumber,
    required String characterResult,
  }) async {
    try {
      final countryDocRef = _firestore
          .collection('Analytics')
          .doc(languageCollection);

      // Add to log subcollection
      await countryDocRef.collection('logs').add({
        'userId': userId,
        'sessionNumber': sessionNumber,
        'characterResult': characterResult,
        'timestamp': FieldValue.serverTimestamp(),
        'language': LanguageConfig.currentLanguageName,
        'languageCode': LanguageConfig.languageCode,
        'type': 'quiz_completed',
      });

      print('Quiz play logged for $languageCollection');
    } catch (e) {
      print('Error logging quiz play: $e');
      // Don't rethrow - we don't want to fail the entire submission if logging fails
    }
  }

  /// Submit Thailand info data (if needed)
  Future<void> submitThailandInfo(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('Thailand_Info').add({
        ...data,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Thailand info submitted successfully');
    } catch (e) {
      print('Error submitting Thailand info: $e');
      rethrow;
    }
  }

  /// Get user's quiz history
  Future<List<Map<String, dynamic>>> getUserHistory() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userId = user.uid;
      final languageCollection = _getLanguageCollection();

      final snapshot = await _firestore
          .collection('Analytics')
          .doc(languageCollection)
          .collection('responses')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return {'id': doc.id, ...doc.data()};
      }).toList();
    } catch (e) {
      print('Error fetching user history: $e');
      return [];
    }
  }

  /// Get user's session history
  Future<List<Map<String, dynamic>>> getUserSessions() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userId = user.uid;
      final languageCollection = _getLanguageCollection();

      final snapshot = await _firestore
          .collection('Analytics')
          .doc(languageCollection)
          .collection('users')
          .doc(userId)
          .collection('sessions')
          .orderBy('sessionNumber', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return {'id': doc.id, ...doc.data()};
      }).toList();
    } catch (e) {
      print('Error fetching user sessions: $e');
      return [];
    }
  }

  /// Get analytics statistics
  Future<Map<String, dynamic>> getAnalytics() async {
    try {
      final languageCollection = _getLanguageCollection();

      final snapshot = await _firestore
          .collection('Analytics')
          .doc(languageCollection)
          .collection('responses')
          .get();

      // Calculate statistics
      final total = snapshot.docs.length;
      final characterCounts = <String, int>{};

      for (var doc in snapshot.docs) {
        final character = doc.data()['characterResult'] as String?;
        if (character != null) {
          characterCounts[character] = (characterCounts[character] ?? 0) + 1;
        }
      }

      return {
        'total': total,
        'characterCounts': characterCounts,
        'collection': languageCollection,
      };
    } catch (e) {
      print('Error fetching analytics: $e');
      return {};
    }
  }

  /// Track when user starts the challenge
  Future<void> trackChallengeAttempt() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userId = user.uid;
      final languageCollection = _getLanguageCollection();

      // Update user document to mark challenge as attempted
      final userDocRef = _firestore
          .collection('Analytics')
          .doc(languageCollection)
          .collection('users')
          .doc(userId);

      // Get user data for character name
      final userDoc = await userDocRef.get();
      final characterName = userDoc.data()?['latestQuizResult'] ?? 'Unknown';

      await userDocRef.update({
        'challengeAttempted': true,
        'challengeAttemptedAt': FieldValue.serverTimestamp(),
      });

      // Update country document stats
      final countryDocRef = _firestore
          .collection('Analytics')
          .doc(languageCollection);

      await countryDocRef.set({
        'stats': {
          'totalChallengeAttempts': FieldValue.increment(1),
          'lastUpdated': FieldValue.serverTimestamp(),
        },
      }, SetOptions(merge: true));

      // Update overall stats for challenge attempts
      final overallDocRef = _firestore.collection('Analytics').doc('overall');
      await overallDocRef.set({
        'stats': {
          'totalChallengeAttempts': FieldValue.increment(1),
          'lastUpdated': FieldValue.serverTimestamp(),
        },
      }, SetOptions(merge: true));

      // Log challenge attempt
      await countryDocRef.collection('logs').add({
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
        'language': LanguageConfig.currentLanguageName,
        'languageCode': LanguageConfig.languageCode,
        'type': 'challenge_attempted',
      });

      // Log to Firebase Analytics
      await logChallengeAttempted(characterName: characterName);

      print('Challenge attempt tracked for user $userId');
    } catch (e) {
      print('Error tracking challenge attempt: $e');
      rethrow;
    }
  }

  /// Track when user clicks share button
  Future<void> trackShareClick({required String screenType}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userId = user.uid;
      final languageCollection = _getLanguageCollection();

      // Get user document for session info
      final userDocRef = _firestore
          .collection('Analytics')
          .doc(languageCollection)
          .collection('users')
          .doc(userId);

      final userDoc = await userDocRef.get();
      final sessionNumber = userDoc.data()?['sessionCount'] ?? 1;

      // Update user document with share click count
      await userDocRef.update({
        'totalShareClicks': FieldValue.increment(1),
        'lastShareClickAt': FieldValue.serverTimestamp(),
      });

      // Update country document stats
      final countryDocRef = _firestore
          .collection('Analytics')
          .doc(languageCollection);

      await countryDocRef.set({
        'stats': {
          'totalShareClicks': FieldValue.increment(1),
          'lastUpdated': FieldValue.serverTimestamp(),
        },
      }, SetOptions(merge: true));

      // Update overall stats for share clicks
      final overallDocRef = _firestore.collection('Analytics').doc('overall');
      await overallDocRef.set({
        'stats': {
          'totalShareClicks': FieldValue.increment(1),
          'lastUpdated': FieldValue.serverTimestamp(),
        },
      }, SetOptions(merge: true));

      // Log share click with session info
      await countryDocRef.collection('logs').add({
        'userId': userId,
        'sessionNumber': sessionNumber,
        'screenType': screenType, // 'result_screen' or 'full_result_screen'
        'timestamp': FieldValue.serverTimestamp(),
        'language': LanguageConfig.currentLanguageName,
        'languageCode': LanguageConfig.languageCode,
        'type': 'share_clicked',
      });

      // Log to Firebase Analytics
      await logShareClicked(screenType: screenType);

      print(
        'Share click tracked for user $userId on $screenType (session $sessionNumber)',
      );
    } catch (e) {
      print('Error tracking share click: $e');
      // Don't rethrow - we don't want to fail the share action if tracking fails
    }
  }

  /// Submit challenge score to Firestore
  Future<void> submitChallengeScore({
    required String characterName,
    required int score,
    required int totalQuestions,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userId = user.uid;
      final languageCollection = _getLanguageCollection();
      final percentage = (score / totalQuestions * 100).round();

      // Get current session number
      final userDocRef = _firestore
          .collection('Analytics')
          .doc(languageCollection)
          .collection('users')
          .doc(userId);

      final userDoc = await userDocRef.get();
      final sessionNumber = userDoc.data()?['sessionCount'] ?? 1;

      // Prepare challenge data
      final challengeData = {
        'userId': userId,
        'sessionNumber': sessionNumber,
        'characterName': characterName,
        'score': score,
        'totalQuestions': totalQuestions,
        'percentage': percentage,
        'timestamp': FieldValue.serverTimestamp(),
        'language': LanguageConfig.currentLanguageName,
        'languageCode': LanguageConfig.languageCode,
      };

      // Write to Analytics/{languageCollection}/challenges collection
      await _firestore
          .collection('Analytics')
          .doc(languageCollection)
          .collection('challenges')
          .add(challengeData);

      // Update user document with latest challenge result
      await userDocRef.update({
        'latestChallengeScore': score,
        'latestChallengePercentage': percentage,
        'latestChallengeTimestamp': FieldValue.serverTimestamp(),
      });

      // Update country document stats
      final countryDocRef = _firestore
          .collection('Analytics')
          .doc(languageCollection);

      await countryDocRef.set({
        'stats': {
          'totalChallengesCompleted': FieldValue.increment(1),
          'totalChallengeScore': FieldValue.increment(score),
          'totalChallengeQuestions': FieldValue.increment(totalQuestions),
          'lastUpdated': FieldValue.serverTimestamp(),
        },
      }, SetOptions(merge: true));

      // Update overall stats for challenge completion
      final overallDocRef = _firestore.collection('Analytics').doc('overall');
      await overallDocRef.set({
        'stats': {
          'totalChallengesCompleted': FieldValue.increment(1),
          'totalChallengeScore': FieldValue.increment(score),
          'totalChallengeQuestions': FieldValue.increment(totalQuestions),
          'lastUpdated': FieldValue.serverTimestamp(),
        },
      }, SetOptions(merge: true));

      // Log challenge completion
      await countryDocRef.collection('logs').add({
        'userId': userId,
        'sessionNumber': sessionNumber,
        'characterName': characterName,
        'score': score,
        'totalQuestions': totalQuestions,
        'percentage': percentage,
        'timestamp': FieldValue.serverTimestamp(),
        'language': LanguageConfig.currentLanguageName,
        'languageCode': LanguageConfig.languageCode,
        'type': 'challenge_completed',
      });

      // Log to Firebase Analytics
      await logChallengeCompleted(
        characterName: characterName,
        score: score,
        totalQuestions: totalQuestions,
        percentage: percentage,
      );

      print(
        'Challenge score submitted successfully: $score/$totalQuestions ($percentage%)',
      );
    } catch (e) {
      print('Error submitting challenge score: $e');
      rethrow;
    }
  }

  // ============================================================================
  // FIREBASE ANALYTICS EVENT LOGGING
  // ============================================================================

  /// Log session start event
  Future<void> logSessionStart() async {
    try {
      await _analytics.logEvent(
        name: 'session_start',
        parameters: {
          'language': LanguageConfig.currentLanguageName,
          'language_code': LanguageConfig.languageCode,
          'country': _getLanguageCollection(),
        },
      );
      print('Analytics: Session start logged');
    } catch (e) {
      print('Error logging session start: $e');
    }
  }

  /// Log quiz started event
  Future<void> logQuizStarted() async {
    try {
      await _analytics.logEvent(
        name: 'quiz_started',
        parameters: {
          'language': LanguageConfig.currentLanguageName,
          'language_code': LanguageConfig.languageCode,
        },
      );
      print('Analytics: Quiz started logged');
    } catch (e) {
      print('Error logging quiz started: $e');
    }
  }

  /// Log quiz completed event
  Future<void> logQuizCompleted({
    required String characterResult,
    required Map<String, int> characterScores,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'quiz_completed',
        parameters: {
          'character_result': characterResult,
          'language': LanguageConfig.currentLanguageName,
          'language_code': LanguageConfig.languageCode,
          'mali_score': characterScores['Mali'] ?? 0,
          'chai_score': characterScores['Chai'] ?? 0,
          'ping_score': characterScores['Ping'] ?? 0,
          'changnoi_score': characterScores['Chang-Noi'] ?? 0,
          'plakad_score': characterScores['Pla-Kad'] ?? 0,
        },
      );

      // Set user property for character result
      await _analytics.setUserProperty(
        name: 'character_type',
        value: characterResult,
      );

      print('Analytics: Quiz completed logged - $characterResult');
    } catch (e) {
      print('Error logging quiz completed: $e');
    }
  }

  /// Log challenge attempted event
  Future<void> logChallengeAttempted({required String characterName}) async {
    try {
      await _analytics.logEvent(
        name: 'challenge_attempted',
        parameters: {
          'character_name': characterName,
          'language': LanguageConfig.currentLanguageName,
          'language_code': LanguageConfig.languageCode,
        },
      );
      print('Analytics: Challenge attempted logged');
    } catch (e) {
      print('Error logging challenge attempted: $e');
    }
  }

  /// Log challenge completed event
  Future<void> logChallengeCompleted({
    required String characterName,
    required int score,
    required int totalQuestions,
    required int percentage,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'challenge_completed',
        parameters: {
          'character_name': characterName,
          'score': score,
          'total_questions': totalQuestions,
          'percentage': percentage,
          'language': LanguageConfig.currentLanguageName,
          'language_code': LanguageConfig.languageCode,
        },
      );
      print('Analytics: Challenge completed logged - $score/$totalQuestions');
    } catch (e) {
      print('Error logging challenge completed: $e');
    }
  }

  /// Log share button click event
  Future<void> logShareClicked({required String screenType}) async {
    try {
      await _analytics.logEvent(
        name: 'share',
        parameters: {
          'content_type': 'quiz_result',
          'screen_type': screenType,
          'method': 'download_image',
          'language': LanguageConfig.currentLanguageName,
          'language_code': LanguageConfig.languageCode,
        },
      );
      print('Analytics: Share clicked logged - $screenType');
    } catch (e) {
      print('Error logging share clicked: $e');
    }
  }

  /// Log screen view event
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass ?? screenName,
      );
      print('Analytics: Screen view logged - $screenName');
    } catch (e) {
      print('Error logging screen view: $e');
    }
  }

  /// Set user properties for demographics
  Future<void> setUserProperties({
    required String gender,
    required String age,
    required String nationality,
  }) async {
    try {
      await _analytics.setUserProperty(name: 'gender', value: gender);
      await _analytics.setUserProperty(name: 'age_group', value: age);
      await _analytics.setUserProperty(name: 'nationality', value: nationality);
      print('Analytics: User properties set');
    } catch (e) {
      print('Error setting user properties: $e');
    }
  }
}
