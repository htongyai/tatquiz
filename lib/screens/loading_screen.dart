import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'result_screen.dart';
import '../config/app_localizations.dart';
import '../config/language_config.dart';

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
  double _loadingProgress = 0.0;
  double _targetProgress = 0.0;
  String? _winningCharacter;
  List<String> _preloadedTopSpotImages = [];
  String? _preloadedDishImage;
  String? _preloadedFestivalImage;
  Timer? _smoothProgressTimer;

  @override
  void initState() {
    super.initState();

    // Determine winning character
    _winningCharacter = widget.characterScores.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    // Animation controller with smooth animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Smooth transition duration
    );

    // Start continuous slow progress animation
    _startSmoothProgressAnimation();

    // Precache loading screen's own assets immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/Background_Red.jpg'), context);
      precacheImage(const AssetImage('assets/Train_loading.png'), context);
      // Start preloading all assets for result screen after context is ready
      _preloadAllAssets();
    });
  }

  String _getCountryCode() {
    if (LanguageConfig.isEnglish) return 'UnitedKingdom';
    if (LanguageConfig.isSpanish) return 'Spain';
    if (LanguageConfig.isGerman) return 'Germany';
    if (LanguageConfig.isRussian) return 'Russia';
    return 'UnitedKingdom';
  }

  String _getCharacterBackendId(String characterName) {
    switch (characterName) {
      case 'Mali':
        return 'Chic';
      case 'Chai':
        return 'Chill';
      case 'Ping':
        return 'Adventure';
      case 'Chang-Noi':
        return 'Culture';
      case 'Pla-Kad':
        return 'Luxury';
      default:
        return 'Chic';
    }
  }

  String _getCharacterImagePath(String characterName) {
    // Get language suffix
    String languageSuffix;
    switch (LanguageConfig.currentLanguage) {
      case AppLanguage.spanish:
        languageSuffix = 'sp';
        break;
      case AppLanguage.german:
        languageSuffix = 'en';
        break;
      case AppLanguage.russian:
        languageSuffix = 'en';
        break;
      case AppLanguage.english:
        languageSuffix = 'en';
        break;
    }

    // Return character-specific image with language suffix
    switch (characterName) {
      case 'Chai':
        return 'assets/Chai Result $languageSuffix.jpg';
      case 'Chang-Noi':
        return 'assets/Chang noi Result $languageSuffix.jpg';
      case 'Ping':
        return 'assets/Ping result $languageSuffix.jpg';
      case 'Pla-Kad':
        return 'assets/Pla kad result $languageSuffix.jpg';
      case 'Mali':
      default:
        return 'assets/Mali Result $languageSuffix.jpg';
    }
  }

  void _startSmoothProgressAnimation() {
    // Continuously animate progress bar slowly
    _smoothProgressTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      // If we have a target and haven't reached it yet
      if (_loadingProgress < _targetProgress) {
        setState(() {
          // Smooth increment towards target (faster when target is 1.0)
          final increment = _targetProgress >= 1.0 ? 0.015 : 0.01;
          _loadingProgress = (_loadingProgress + increment).clamp(0.0, _targetProgress.clamp(0.0, 1.0));
          _animationController.value = _loadingProgress;
        });
      } else if (_loadingProgress < 0.95 && _targetProgress < 1.0) {
        // Keep slowly moving even when waiting (very slow increment, but only if not at final target)
        setState(() {
          _loadingProgress = (_loadingProgress + 0.002).clamp(0.0, 0.95);
          _animationController.value = _loadingProgress;
        });
      } else if (_targetProgress >= 1.0 && _loadingProgress < 1.0) {
        // Continue to 1.0 when target is set to completion
        setState(() {
          _loadingProgress = (_loadingProgress + 0.015).clamp(0.0, 1.0);
          _animationController.value = _loadingProgress;
        });
      }
    });
  }

  void _updateProgress(double progress) {
    if (mounted) {
      setState(() {
        _targetProgress = progress.clamp(0.0, 1.0);
        // Don't set _loadingProgress directly - let the smooth animation catch up
      });
    }
  }

  Future<void> _preloadAllAssets() async {
    if (_winningCharacter == null) return;

    final startTime = DateTime.now();
    const minDuration = Duration(seconds: 2); // Minimum 2 seconds for smooth UX

    try {
      // Task 1: Fetch Firebase data FIRST (doesn't need context) - 20% progress
      _updateProgress(0.2);
      final firestore = FirebaseFirestore.instance;
      final countryCode = _getCountryCode();
      final characterBackendId = _getCharacterBackendId(_winningCharacter!);

      // Fetch all Firebase data in parallel
      final results = await Future.wait([
        firestore
            .collection('characters')
            .doc(countryCode)
            .collection(characterBackendId)
            .doc('content')
            .collection('locations')
            .limit(3)
            .get(),
        firestore
            .collection('characters')
            .doc(countryCode)
            .collection(characterBackendId)
            .doc('content')
            .collection('foodMatches')
            .limit(1)
            .get(),
        firestore
            .collection('characters')
            .doc(countryCode)
            .collection(characterBackendId)
            .doc('content')
            .collection('festivalFits')
            .limit(1)
            .get(),
      ]);

      _updateProgress(0.3);

      // Extract image URLs from Firebase
      final locationsSnapshot = results[0] as QuerySnapshot;
      final foodsSnapshot = results[1] as QuerySnapshot;
      final festivalsSnapshot = results[2] as QuerySnapshot;

      final topSpotUrls = locationsSnapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>?;
            return data?['imageUrl'] as String?;
          })
          .where((url) => url != null && url.isNotEmpty)
          .cast<String>()
          .toList();

      String? dishUrl;
      if (foodsSnapshot.docs.isNotEmpty) {
        final data = foodsSnapshot.docs.first.data() as Map<String, dynamic>?;
        dishUrl = data?['imageUrl'] as String?;
      }

      String? festivalUrl;
      if (festivalsSnapshot.docs.isNotEmpty) {
        final data = festivalsSnapshot.docs.first.data() as Map<String, dynamic>?;
        festivalUrl = data?['imageUrl'] as String?;
      }

      // Store Firebase URLs immediately (even if precaching fails later)
      setState(() {
        _preloadedTopSpotImages = topSpotUrls;
        _preloadedDishImage = dishUrl;
        _preloadedFestivalImage = festivalUrl;
      });

      // Task 2: Preload character result image (40% progress)
      _updateProgress(0.4);
      final characterImagePath = _getCharacterImagePath(_winningCharacter!);
      await precacheImage(AssetImage(characterImagePath), context);

      // Task 3: Preload fallback assets (50% progress)
      _updateProgress(0.5);
      await Future.wait([
        precacheImage(const AssetImage('assets/top1.png'), context),
        precacheImage(const AssetImage('assets/top2.png'), context),
        precacheImage(const AssetImage('assets/top3.png'), context),
        precacheImage(const AssetImage('assets/dish.png'), context),
        precacheImage(const AssetImage('assets/fest.png'), context),
      ]);

      // Task 4: Preload background image (60% progress)
      _updateProgress(0.6);
      await precacheImage(const AssetImage('assets/Background_Red.jpg'), context);

      // Task 5: Preload Firebase network images (80% progress when done)
      _updateProgress(0.7);
      final networkImageFutures = <Future>[];

      for (final url in topSpotUrls) {
        networkImageFutures.add(
          precacheImage(NetworkImage(url), context).catchError((e) {
            print('Error precaching network image: $url - $e');
          }),
        );
      }

      if (dishUrl != null && dishUrl.isNotEmpty) {
        networkImageFutures.add(
          precacheImage(NetworkImage(dishUrl), context).catchError((e) {
            print('Error precaching dish image: $dishUrl - $e');
          }),
        );
      }

      if (festivalUrl != null && festivalUrl.isNotEmpty) {
        networkImageFutures.add(
          precacheImage(NetworkImage(festivalUrl), context).catchError((e) {
            print('Error precaching festival image: $festivalUrl - $e');
          }),
        );
      }

      if (networkImageFutures.isNotEmpty) {
        await Future.wait(networkImageFutures);
      }

      _updateProgress(0.8);

      // Ensure we've reached minimum duration
      final elapsed = DateTime.now().difference(startTime);
      if (elapsed < minDuration) {
        await Future.delayed(minDuration - elapsed);
      }

      // Set target to 1.0 and wait for smooth animation to reach it
      _updateProgress(1.0);
      // Wait for smooth animation to catch up to 1.0 (with timeout)
      int waitCount = 0;
      const maxWaitCount = 100; // 5 seconds max wait (100 * 50ms)
      while (_loadingProgress < 0.995 && mounted && waitCount < maxWaitCount) {
        await Future.delayed(const Duration(milliseconds: 50));
        waitCount++;
      }
      // Ensure we're at 1.0
      if (mounted) {
        setState(() {
          _loadingProgress = 1.0;
          _animationController.value = 1.0;
        });
      }
      // Small delay to show 100% before navigation
      await Future.delayed(const Duration(milliseconds: 200));

      // Navigate to result screen with preloaded data
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              characterName: _winningCharacter!,
              userAge: widget.userAge,
              userInterest: widget.userInterest,
              preloadedTopSpotImages: _preloadedTopSpotImages,
              preloadedDishImage: _preloadedDishImage,
              preloadedFestivalImage: _preloadedFestivalImage,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error preloading assets: $e');
      // Even if there's an error, navigate after minimum duration
      final elapsed = DateTime.now().difference(startTime);
      if (elapsed < minDuration) {
        await Future.delayed(minDuration - elapsed);
      }
      _updateProgress(1.0);
      // Wait for smooth animation to catch up to 1.0 (with timeout)
      int waitCount = 0;
      const maxWaitCount = 100; // 5 seconds max wait (100 * 50ms)
      while (_loadingProgress < 0.995 && mounted && waitCount < maxWaitCount) {
        await Future.delayed(const Duration(milliseconds: 50));
        waitCount++;
      }
      // Ensure we're at 1.0
      if (mounted) {
        setState(() {
          _loadingProgress = 1.0;
          _animationController.value = 1.0;
        });
      }
      // Small delay to show 100% before navigation
      await Future.delayed(const Duration(milliseconds: 200));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              characterName: _winningCharacter!,
              userAge: widget.userAge,
              userInterest: widget.userInterest,
              preloadedTopSpotImages: _preloadedTopSpotImages,
              preloadedDishImage: _preloadedDishImage,
              preloadedFestivalImage: _preloadedFestivalImage,
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _smoothProgressTimer?.cancel();
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
