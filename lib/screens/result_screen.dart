import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'full_result_screen.dart';
import '../config/app_localizations.dart';
import '../config/language_config.dart';
import 'challenge/challenge_intro_screen.dart';
import '../services/firebase_service.dart';

// Conditional import for web
import 'result_screen_stub.dart'
    if (dart.library.html) 'result_screen_web.dart'
    as web_helper;

class ResultScreen extends StatefulWidget {
  final String characterName;
  final String userAge;
  final String userInterest;

  const ResultScreen({
    super.key,
    required this.characterName,
    required this.userAge,
    required this.userInterest,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final GlobalKey _cardKey = GlobalKey();
  bool _isLoadingChallenge = false;
  bool _isLoadingData = true;
  List<String> _topSpotImages = [];
  String? _dishImage;
  String? _festivalImage;

  @override
  void initState() {
    super.initState();
    // Log screen view
    FirebaseService().logScreenView(screenName: 'result_screen');
    // Fetch Firebase data
    _fetchFirebaseImages();
  }

  Future<void> _fetchFirebaseImages() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final countryCode = _getCountryCode();
      final characterBackendId = _getCharacterBackendId(widget.characterName);

      // Fetch top 3 locations
      final locationsSnapshot = await firestore
          .collection('characters')
          .doc(countryCode)
          .collection(characterBackendId)
          .doc('content')
          .collection('locations')
          .limit(3)
          .get();

      // Fetch 1 food
      final foodsSnapshot = await firestore
          .collection('characters')
          .doc(countryCode)
          .collection(characterBackendId)
          .doc('content')
          .collection('foodMatches')
          .limit(1)
          .get();

      // Fetch 1 festival
      final festivalsSnapshot = await firestore
          .collection('characters')
          .doc(countryCode)
          .collection(characterBackendId)
          .doc('content')
          .collection('festivalFits')
          .limit(1)
          .get();

      setState(() {
        _topSpotImages = locationsSnapshot.docs
            .map((doc) => doc.data()['imageUrl'] as String?)
            .where((url) => url != null && url.isNotEmpty)
            .cast<String>()
            .toList();

        if (foodsSnapshot.docs.isNotEmpty) {
          _dishImage = foodsSnapshot.docs.first.data()['imageUrl'] as String?;
        }

        if (festivalsSnapshot.docs.isNotEmpty) {
          _festivalImage =
              festivalsSnapshot.docs.first.data()['imageUrl'] as String?;
        }

        _isLoadingData = false;
      });
    } catch (e) {
      print('Error fetching result screen images: $e');
      setState(() {
        _isLoadingData = false;
      });
    }
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
      // Track share button click
      try {
        await FirebaseService().trackShareClick(screenType: 'result_screen');
      } catch (e) {
        print('Error tracking share click: $e');
      }

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
          'thailand_result_${DateTime.now().millisecondsSinceEpoch}.png',
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
    final String characterImage = _getCharacterImage(widget.characterName);
    var size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    // Card width = screen width - 40px horizontal padding (20px each side)
    final double cardWidth = screenWidth - 40;
    // Card height maintains 9:16 aspect ratio
    final double cardHeight = cardWidth * 16 / 9;

    // Calculate image sizes using percentage-based logic for perfect responsiveness
    // Horizontal padding: 12% of card width on each side (24% total)
    final horizontalPadding = cardWidth * 0.12;
    final availableWidth = cardWidth - (horizontalPadding * 2);

    // First row: 3 images with 1:1 aspect ratio
    // Spacing between images: 3% of card width
    final firstRowSpacing = cardWidth * 0.03;
    final firstRowImageSize = (availableWidth - (firstRowSpacing * 2)) / 3;

    // Second row: 2 images with 136:80 aspect ratio (17:10)
    // Spacing between images: 3% of card width
    final secondRowSpacing = cardWidth * 0.03;
    final secondRowImageWidth = (availableWidth - secondRowSpacing) / 2;
    final secondRowImageHeight =
        secondRowImageWidth * 80 / 136; // 136:80 aspect ratio

    return Scaffold(
      body: Stack(
        children: [
          // Background and scrollable content
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Background_Red.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top header section
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        // Top row with export icon, TAT logo, and challenge icon
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Export icon - same size as challenge icon
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFDFCEF),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: _saveAndShareImage,
                                  icon: Icon(
                                    Icons.ios_share,
                                    color: Colors.grey[700],
                                    size: 24,
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                              // TAT logo centered between buttons
                              Expanded(
                                child: Center(
                                  child: Image.asset(
                                    'assets/logo_tat.png',
                                    height: 70,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                              ),
                              // Trophy icon - navigates to challenge
                              GestureDetector(
                                onTap: () async {
                                  if (_isLoadingChallenge) return;

                                  setState(() {
                                    _isLoadingChallenge = true;
                                  });

                                  // Track challenge attempt in background (don't wait)
                                  FirebaseService()
                                      .trackChallengeAttempt()
                                      .catchError((e) {
                                        print(
                                          'Error tracking challenge attempt: $e',
                                        );
                                      });

                                  // Navigate immediately
                                  if (mounted) {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChallengeIntroScreen(
                                              characterName:
                                                  widget.characterName,
                                            ),
                                      ),
                                    );

                                    if (mounted) {
                                      setState(() {
                                        _isLoadingChallenge = false;
                                      });
                                    }
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFDFCEF),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: _isLoadingChallenge
                                            ? const SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Color(0xFF8B1538)),
                                                ),
                                              )
                                            : SvgPicture.asset(
                                                'assets/challenge_asset/icon_award.svg',
                                                width: 32,
                                                height: 32,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Title text below
                        Text(
                          AppLocalizations.yourTourismPersonalityIs,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Character image card with fixed 9:16 aspect ratio
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: [
                        // RepaintBoundary for screenshot capture - includes card and overlays
                        RepaintBoundary(
                          key: _cardKey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: cardWidth,
                              height: cardHeight,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(characterImage),
                                  fit: BoxFit
                                      .fill, // Use fill to ensure image always fills the card
                                  alignment: Alignment.center,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Top Spots for You section overlay
                                  // Positioned at 58% from top of card to align below "Top Spots for You" text
                                  // This percentage ensures images align correctly regardless of card size
                                  Positioned(
                                    top: cardHeight * 0.58,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: horizontalPadding,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Three image spots horizontally (1:1 aspect ratio)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              _buildSpotBox(
                                                firstRowImageSize,
                                                firstRowImageSize,
                                                _topSpotImages.isNotEmpty
                                                    ? _topSpotImages[0]
                                                    : null,
                                                'assets/top1.png',
                                              ),
                                              _buildSpotBox(
                                                firstRowImageSize,
                                                firstRowImageSize,
                                                _topSpotImages.length > 1
                                                    ? _topSpotImages[1]
                                                    : null,
                                                'assets/top2.png',
                                              ),
                                              _buildSpotBox(
                                                firstRowImageSize,
                                                firstRowImageSize,
                                                _topSpotImages.length > 2
                                                    ? _topSpotImages[2]
                                                    : null,
                                                'assets/top3.png',
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: cardHeight * 0.09,
                                          ), // 6% of card height
                                          // Local Dish and Thai Festival row (136:80 aspect ratio)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              _buildDishBox(
                                                secondRowImageWidth,
                                                secondRowImageHeight,
                                                _dishImage,
                                                'assets/dish.png',
                                              ),
                                              _buildDishBox(
                                                secondRowImageWidth,
                                                secondRowImageHeight,
                                                _festivalImage,
                                                'assets/fest.png',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom padding to account for floating button
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Floating bottom button (doesn't scroll)
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
                  colors: [
                    const Color(0xFF8B1538).withOpacity(0),
                    const Color(0xFF8B1538),
                  ],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFFF39C21),
                      width: 3,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullResultScreen(
                            characterName: widget.characterName,
                            userAge: widget.userAge,
                            userInterest: widget.userInterest,
                            onShareImage: _captureWidget,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEB521A),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.viewFullResult,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getCharacterImage(String character) {
    // Get language suffix
    String languageSuffix;
    switch (LanguageConfig.currentLanguage) {
      case AppLanguage.spanish:
        languageSuffix = 'sp';
        break;
      case AppLanguage.german:
        languageSuffix =
            'en'; // Default to English until German images are provided
        break;
      case AppLanguage.russian:
        languageSuffix =
            'en'; // Default to English until Russian images are provided
        break;
      case AppLanguage.english:
        languageSuffix = 'en';
        break;
    }

    // Return character-specific image with language suffix
    switch (character) {
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

  Widget _buildSpotBox(
    double width,
    double height,
    String? firebaseImageUrl,
    String fallbackAsset,
  ) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: firebaseImageUrl != null && firebaseImageUrl.isNotEmpty
            ? Image.network(
                firebaseImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(fallbackAsset, fit: BoxFit.cover);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                },
              )
            : Image.asset(fallbackAsset, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildDishBox(
    double width,
    double height,
    String? firebaseImageUrl,
    String fallbackAsset,
  ) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: firebaseImageUrl != null && firebaseImageUrl.isNotEmpty
            ? Image.network(
                firebaseImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(fallbackAsset, fit: BoxFit.cover);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                },
              )
            : Image.asset(fallbackAsset, fit: BoxFit.cover),
      ),
    );
  }
}
