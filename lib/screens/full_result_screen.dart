import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:js' as js;
import '../models/quiz_data.dart';
import '../models/challenge_data.dart';
import '../config/app_localizations.dart';
import '../config/language_config.dart';
import '../services/firebase_service.dart';
import 'challenge/challenge_intro_screen.dart';

// Conditional import for web
import 'result_screen_stub.dart'
    if (dart.library.html) 'result_screen_web.dart'
    as web_helper;

class FullResultScreen extends StatefulWidget {
  final String characterName;
  final String userAge;
  final String userInterest;
  final Future<Uint8List?> Function() onShareImage;

  const FullResultScreen({
    super.key,
    required this.characterName,
    required this.userAge,
    required this.userInterest,
    required this.onShareImage,
  });

  @override
  State<FullResultScreen> createState() => _FullResultScreenState();
}

class _FullResultScreenState extends State<FullResultScreen> {
  bool _isLoadingChallenge = false;
  bool _isLoadingData = true;
  List<Map<String, dynamic>> _locations = [];
  List<Map<String, dynamic>> _foods = [];
  List<Map<String, dynamic>> _festivals = [];

  @override
  void initState() {
    super.initState();
    // Log screen view
    FirebaseService().logScreenView(screenName: 'full_result_screen');
    // Fetch data from Firebase
    _fetchFirebaseData();
  }

  Future<void> _fetchFirebaseData() async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Get country code from language config
      final countryCode = _getCountryCode();

      // Get character backend ID
      final characterBackendId = _getCharacterBackendId(widget.characterName);

      // Fetch locations (limit to 5)
      final locationsSnapshot = await firestore
          .collection('characters')
          .doc(countryCode)
          .collection(characterBackendId)
          .doc('content')
          .collection('locations')
          .limit(5)
          .get();

      // Fetch foods
      final foodsSnapshot = await firestore
          .collection('characters')
          .doc(countryCode)
          .collection(characterBackendId)
          .doc('content')
          .collection('foodMatches')
          .get();

      // Fetch festivals
      final festivalsSnapshot = await firestore
          .collection('characters')
          .doc(countryCode)
          .collection(characterBackendId)
          .doc('content')
          .collection('festivalFits')
          .get();

      setState(() {
        _locations = locationsSnapshot.docs
            .map((doc) => {...doc.data(), 'id': doc.id})
            .toList();
        _foods = foodsSnapshot.docs
            .map((doc) => {...doc.data(), 'id': doc.id})
            .toList();
        _festivals = festivalsSnapshot.docs
            .map((doc) => {...doc.data(), 'id': doc.id})
            .toList();
        _isLoadingData = false;
      });

      print(
        'Loaded ${_locations.length} locations, ${_foods.length} foods, ${_festivals.length} festivals',
      );
    } catch (e) {
      print('Error fetching Firebase data: $e');
      setState(() {
        _isLoadingData = false;
      });
    }
  }

  String _getCountryCode() {
    // Get country code based on language config (same logic as FirebaseService)
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

  String _getCharacterBackendId(String characterName) {
    // Map character names to backend IDs
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
        return 'Chic'; // Default fallback
    }
  }

  String _getRegionIconPath(String region) {
    // Map region names to icon assets
    final regionLower = region.toLowerCase();
    if (regionLower.contains('west') || regionLower.contains('oeste')) {
      return 'assets/West.png';
    } else if (regionLower.contains('central') ||
        regionLower.contains('centro')) {
      return 'assets/Central.png';
    } else if (regionLower.contains('east') &&
            !regionLower.contains('northeast') ||
        regionLower.contains('este') && !regionLower.contains('noreste')) {
      return 'assets/East.png';
    } else if (regionLower.contains('north') &&
            !regionLower.contains('northeast') ||
        regionLower.contains('norte') && !regionLower.contains('noreste')) {
      return 'assets/North.png';
    } else if (regionLower.contains('northeast') ||
        regionLower.contains('noreste')) {
      return 'assets/Northeast.png';
    } else if (regionLower.contains('south') || regionLower.contains('sur')) {
      return 'assets/South.png';
    }
    // Default fallback
    return 'assets/Central.png';
  }

  Future<void> _saveAndShareImage() async {
    try {
      // Track share button click
      try {
        await FirebaseService().trackShareClick(
          screenType: 'full_result_screen',
        );
      } catch (e) {
        print('Error tracking share click: $e');
      }

      // Use the capture function from result screen
      final imageBytes = await widget.onShareImage();
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

  // Open location in Google Maps
  Future<void> _openLocation(String placeName, String location) async {
    try {
      // Create search query with place name and location
      final query = Uri.encodeComponent('$placeName $location Thailand');
      final googleMapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$query';

      if (kIsWeb) {
        // For web, use js interop to open in new tab
        js.context.callMethod('open', [googleMapsUrl, '_blank']);
      } else {
        final uri = Uri.parse(googleMapsUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open maps')),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error opening maps: $e')));
      }
    }
  }

  String _getCharacterProfileImagePath(String characterName) {
    // Spanish language images
    if (LanguageConfig.isSpanish) {
      switch (characterName) {
        case 'Pla-Kad':
          return 'assets/Pla kad Profile_Full Result_Spanish.png';
        case 'Ping':
          return 'assets/Ping Profile_Full  Result_Spanish.png';
        case 'Mali':
          return 'assets/Mali Profile_Full Result_Spanish.png';
        case 'Chang-Noi':
          return 'assets/Chang noi Profile_Full Result_Spanish.png';
        case 'Chai':
          return 'assets/Chai Profile_Full Result_Spanish.png';
        default:
          return 'assets/Mali Profile_Full Result_Spanish.png';
      }
    }

    // Default English images
    switch (characterName) {
      case 'Pla-Kad':
        return 'assets/character_profiles/plakad_profile.png';
      case 'Ping':
        return 'assets/character_profiles/ping_profile.png';
      case 'Mali':
        return 'assets/character_profiles/mali_profile.png';
      case 'Chang-Noi':
        return 'assets/character_profiles/changnoi_profile.png';
      case 'Chai':
        return 'assets/character_profiles/chai_profile.png';
      default:
        return 'assets/character_profiles/mali_profile.png';
    }
  }

  // Get character-specific travel vibe description
  String _getCharacterTravelVibe(String characterName) {
    if (LanguageConfig.isSpanish) {
      switch (characterName) {
        case 'Mali':
          return 'Mali es elegante y conoce todos los cafés de la ciudad. Cuida su feed con sky bars, hoteles de diseño y espacios de arte. Si es lindo, acogedor o cool, Mali está ahí.';
        case 'Chai':
          return 'Chai es todo paz, naturaleza y una buena siesta con vistas a la montaña. Se toma su tiempo para absorber lentamente el ambiente de cada lugar que visita. Camina descalzo sobre el césped y disfruta hablando con las señoras en los mercados locales.';
        case 'Chang-Noi':
          return 'A Chang-Noi le encantan los templos escondidos de Tailandia, los mercados y las tradiciones antiguas. Con una pequeña libreta y una cámara vintage, Chang-Noi siempre hace preguntas y aprende de los lugareños.';
        case 'Ping':
          return 'Ping se mueve en motocicleta y se sumerge en olas—literalmente. Siempre busca la próxima emoción o puesta de sol en la playa. A Ping le importan las experiencias, no los horarios.';
        case 'Pla-Kad':
          return 'Pla-Kad viaja con estilo, desde resorts de lujo en Phuket hasta spas de alta gama en Bangkok. Sofisticado, pero audaz, encuentra consuelo en fine dining, hoteles de diseño y experiencias exclusivas. Para Pla-Kad, el lujo no es sólo riqueza, sino refinamiento, arte y detalle.';
        default:
          return 'Mali es elegante y conoce todos los cafés de la ciudad. Cuida su feed con sky bars, hoteles de diseño y espacios de arte.';
      }
    }

    // English (default)
    switch (characterName) {
      case 'Mali':
        return 'Mali is stylish and knows all the best cafés in town. She curates her feed with sky bars, design hotels, and art spaces. If it\'s cute, cozy, or cool — Mali\'s there.';
      case 'Chai':
        return 'Chai is all about peace, nature, and a good nap with a mountain view. He takes his time slowly to absorb the atmosphere of each place he visits. He walks barefoot on the grass, and enjoys talking to aunties in local markets.';
      case 'Chang-Noi':
        return 'Chang-Noi loves hidden temples, local markets, and age-old traditions. With a little notepad and vintage camera, Chang-Noi always asks questions and learns from locals.';
      case 'Ping':
        return 'Ping zips around on motorbikes and dives into waves — literally. Always looking for the next thrill or beach sunset, Ping\'s about experiences, not schedules.';
      case 'Pla-Kad':
        return 'Pla-Kad travels in style — from luxury resorts in Phuket to high-end spas in Bangkok. Sophisticated yet bold, she finds comfort in fine dining, design hotels, and exclusive experiences. For Pla-Kad, luxury isn\'t just wealth — it\'s refinement, artistry, and detail.';
      default:
        return 'Mali is stylish and knows all the best cafés in town. She curates her feed with sky bars, design hotels, and art spaces.';
    }
  }

  // Get character-specific animal/symbol info
  Map<String, String> _getCharacterAnimal(String characterName) {
    if (LanguageConfig.isSpanish) {
      switch (characterName) {
        case 'Mali':
          return {
            'name': 'Gato Siamés (Wichien Maat)',
            'image': 'assets/ Character/Mali/Siamese Cat.jpg',
            'description':
                'Nacida en la realeza del antiguo Siam, esta elegante gata con ojos de zafiro azul traía fortuna y protegía los templos sagrados. Antiguamente, solo la nobleza podía poseerlos. Ahora, el gato siamés lleva la gracia tailandesa a través del mundo, su calma mirada cuenta historias de fe, belleza y amistad.',
          };
        case 'Chai':
          return {
            'name': 'Búfalo',
            'image': 'assets/ Character/Chai/Buffalo.png',
            'description':
                'Antes de las máquinas, era el búfalo de agua el que araba los arrozales tailandeses, compartiendo sudor y tierra con los agricultores a través de generaciones. Representa gratitud, paciencia y fuerza humilde.',
          };
        case 'Chang-Noi':
          return {
            'name': 'Elefante',
            'image': 'assets/ Character/Chang noi/Elephant.png',
            'description':
                'El elefante, símbolo nacional de Tailandia, utilizado históricamente en ceremonias reales y rituales culturales. Durante mucho tiempo han sido compañeros de la vida tailandesa. Hoy, los elefantes se han convertido en símbolos de sabiduría, lealtad y fuerza, y son un recordatorio del poderoso y amable corazón de Tailandia.',
          };
        case 'Ping':
          return {
            'name': 'Dugongo',
            'image': 'assets/ Character/Ping/Dugong.png',
            'description':
                'El dugongo, la "vaca marina" de Tailandia, vive pacíficamente a lo largo de la costa de Andamán. Es amable, curioso y amado como símbolo de conservación marina y del encanto de las islas tailandesas.',
          };
        case 'Pla-Kad':
          return {
            'name': 'Pez Betta',
            'image': 'assets/ Character/Pla kad/Betta Fish.png',
            'description':
                'El tesoro acuático nacional de Tailandia, el pez Betta, es admirado mundialmente por sus vibrantes colores, aletas gráciles y espíritu de lucha. Representa tanto el arte tailandés como la capacidad del país de combinar la tradición con la sofisticación moderna.',
          };
        default:
          return {
            'name': 'Gato Siamés',
            'image': 'assets/ Character/Mali/Siamese Cat.jpg',
            'description':
                'Un gato elegante que representa la gracia y belleza tailandesa.',
          };
      }
    }

    // English (default)
    switch (characterName) {
      case 'Mali':
        return {
          'name': 'Siamese Cat (Wichien Maat)',
          'image': 'assets/ Character/Mali/Siamese Cat.jpg',
          'description':
              'Born in ancient Siam\'s royal courts, this elegant cat with sapphire-blue eyes was believed to bring fortune and protect sacred temples. Once, only nobles could own them. Now, the Siamese cat carries Thai grace across the world, its calm gaze telling stories of faith, beauty, and friendship.',
        };
      case 'Chai':
        return {
          'name': 'Buffalo',
          'image': 'assets/ Character/Chai/Buffalo.png',
          'description':
              'Before machines, it was the water buffalo that plowed Thai rice fields, sharing sweat and soil with farmers through generations. It represents gratitude, patience, and humble strength.',
        };
      case 'Chang-Noi':
        return {
          'name': 'Elephant',
          'image': 'assets/ Character/Chang noi/Elephant.png',
          'description':
              'The elephant, Thailand\'s national symbol, historically used in royal ceremonies and cultural rituals. They have long been companions of Thai life. Today, elephants became symbols of wisdom, loyalty, and strength and be reminders of Thailand\'s heart: powerful yet kind.',
        };
      case 'Ping':
        return {
          'name': 'Dugong',
          'image': 'assets/ Character/Ping/Dugong.png',
          'description':
              'The dugong, Thailand\'s "sea cow," lives peacefully along the Andaman coast. It\'s gentle, curious, and loved as a symbol of marine conservation and the charm of Thai islands.',
        };
      case 'Pla-Kad':
        return {
          'name': 'Betta Fish',
          'image': 'assets/ Character/Pla kad/Betta Fish.png',
          'description':
              'Thailand\'s national aquatic treasure, the betta fish, is admired worldwide for its vibrant colors, graceful fins, and fighting spirit. It represents both Thai artistry and the country\'s ability to blend tradition with modern sophistication.',
        };
      default:
        return {
          'name': 'Siamese Cat',
          'image': 'assets/ Character/Mali/Siamese Cat.jpg',
          'description': 'An elegant cat representing Thai grace and beauty.',
        };
    }
  }

  List<Map<String, String>> _getCharacterActivities(String characterName) {
    switch (characterName) {
      case 'Mali':
        return [
          {
            'label': AppLocalizations.cafeHopping,
            'icon': 'assets/activity_icons/mali/icon_cafe.png',
          },
          {
            'label': AppLocalizations.artWalk,
            'icon': 'assets/activity_icons/mali/icon_art.png',
          },
          {
            'label': AppLocalizations.boutiqueStay,
            'icon': 'assets/activity_icons/mali/icon_boutiquestay.png',
          },
          {
            'label': AppLocalizations.contemporaryFestivals,
            'icon': 'assets/activity_icons/mali/icon_festival.png',
          },
          {
            'label': AppLocalizations.rooftopDining,
            'icon': 'assets/activity_icons/mali/icon_rooftop.png',
          },
          {
            'label': AppLocalizations.fashionDesignMarket,
            'icon': 'assets/activity_icons/mali/icon_deisgnmarket.png',
          },
        ];
      case 'Chai':
        return [
          {
            'label': AppLocalizations.homestay,
            'icon': 'assets/activity_icons/chai/icon_homestay.png',
          },
          {
            'label': AppLocalizations.mindfulness,
            'icon': 'assets/activity_icons/chai/icon_mindfullness.png',
          },
          {
            'label': AppLocalizations.farmWalk,
            'icon': 'assets/activity_icons/chai/icon_farmwalk.png',
          },
          {
            'label': AppLocalizations.marketBreakfast,
            'icon': 'assets/activity_icons/chai/icon_marketbreakfast.png',
          },
          {
            'label': AppLocalizations.readingByRiver,
            'icon': 'assets/activity_icons/chai/icon_reading.png',
          },
          {
            'label': AppLocalizations.softAdventure,
            'icon': 'assets/activity_icons/chai/icon_softadventure.png',
          },
        ];
      case 'Chang-Noi':
        return [
          {
            'label': AppLocalizations.heritageTempleTour,
            'icon': 'assets/activity_icons/changnoi/icon_templetour.png',
          },
          {
            'label': AppLocalizations.localMarket,
            'icon': 'assets/activity_icons/changnoi/icon_localmarket.png',
          },
          {
            'label': AppLocalizations.craftWorkshop,
            'icon': 'assets/activity_icons/changnoi/icon_craftworkshop.png',
          },
          {
            'label': AppLocalizations.vintageSouvenir,
            'icon': 'assets/activity_icons/changnoi/icon_vintagesouvenir.png',
          },
          {
            'label': AppLocalizations.cookingClass,
            'icon': 'assets/activity_icons/changnoi/icon_cookingclass.png',
          },
          {
            'label': AppLocalizations.traditionalFestival,
            'icon': 'assets/activity_icons/changnoi/icon_traditionalfestival.png',
          },
        ];
      case 'Ping':
        return [
          {
            'label': AppLocalizations.snorkeling,
            'icon': 'assets/activity_icons/ping/icon_snorkeling.png',
          },
          {
            'label': AppLocalizations.kayaking,
            'icon': 'assets/activity_icons/ping/icon_kayaking.png',
          },
          {
            'label': AppLocalizations.beachBonfire,
            'icon': 'assets/activity_icons/ping/icon_beachbonfire.png',
          },
          {
            'label': AppLocalizations.coastalRide,
            'icon': 'assets/activity_icons/ping/icon_coastalride.png',
          },
          {
            'label': AppLocalizations.divingTrip,
            'icon': 'assets/activity_icons/ping/icon_divingtrip.png',
          },
          {
            'label': AppLocalizations.seafoodHunt,
            'icon': 'assets/activity_icons/ping/icon_seafoodhunt.png',
          },
        ];
      case 'Pla-Kad':
        return [
          {
            'label': AppLocalizations.luxurySpa,
            'icon': 'assets/activity_icons/plakad/icon_wellness.png',
          },
          {
            'label': AppLocalizations.fineDining,
            'icon': 'assets/activity_icons/plakad/icon_finedining.png',
          },
          {
            'label': AppLocalizations.artGallery,
            'icon': 'assets/activity_icons/plakad/icon_artgallery.png',
          },
          {
            'label': AppLocalizations.beachfrontResort,
            'icon': 'assets/activity_icons/plakad/icon_beachfrontresort.png',
          },
          {
            'label': AppLocalizations.fashion,
            'icon': 'assets/activity_icons/plakad/icon_fashion.png',
          },
          {
            'label': AppLocalizations.festivals,
            'icon': 'assets/activity_icons/plakad/icon_festival.png',
          },
        ];
      default:
        return [
          {
            'label': AppLocalizations.cafeHopping,
            'icon': 'assets/activity_icons/mali/icon_cafe.png',
          },
          {
            'label': AppLocalizations.artWalk,
            'icon': 'assets/activity_icons/mali/icon_art.png',
          },
          {
            'label': AppLocalizations.boutiqueStay,
            'icon': 'assets/activity_icons/mali/icon_boutiquestay.png',
          },
          {
            'label': AppLocalizations.contemporaryFestivals,
            'icon': 'assets/activity_icons/mali/icon_festival.png',
          },
          {
            'label': AppLocalizations.rooftopDining,
            'icon': 'assets/activity_icons/mali/icon_rooftop.png',
          },
          {
            'label': AppLocalizations.fashionDesignMarket,
            'icon': 'assets/activity_icons/mali/icon_deisgnmarket.png',
          },
        ];
    }
  }

  // Get character-specific food recommendations
  List<Map<String, String>> _getCharacterFoods(String characterName) {
    // Food structure: title, thai, description
    switch (characterName) {
      case 'Mali':
        return [
          {
            'title': 'Mango Sticky Rice',
            'thai': 'Khao Niao Mamuang',
            'description':
                'A popular Thai dessert where ripe, sweet mango is served with sticky rice soaked in coconut milk and topped with crispy mung beans. It\'s a simple, refreshing treat that\'s not too heavy.',
          },
          {
            'title': 'Glass Noodle Stir-Fry (Pad Woon Sen)',
            'thai': 'ผัดวุ้นเส้น',
            'description':
                'A light, flavorful stir-fry made with glass noodles, vegetables, and your choice of protein. The dish is quick and delicious — ideal for casual street food spots and cozy eateries.',
          },
          {
            'title': 'Grilled Pork (Thai Coconut Milk Style)',
            'thai': 'หมูย่างสไตล์ไทย',
            'description':
                'Juicy pork grilled to perfection and served with a sweet coconut-based sauce. It\'s often paired with sticky rice and papaya salad, making it a satisfying yet light meal.',
          },
        ];
      case 'Chai':
        return [
          {
            'title': 'Khao Soi (Northern Curry Noodles)',
            'thai': 'ข้าวซอย',
            'description':
                'A comforting bowl of egg noodles in a creamy, mildly spiced curry broth, topped with crispy noodles and served with pickled mustard greens and shallots. It\'s a Northern Thai specialty that feels like a warm hug.',
          },
          {
            'title': 'Som Tam (Green Papaya Salad)',
            'thai': 'ส้มตำ',
            'description':
                'Fresh, crunchy green papaya tossed with tomatoes, peanuts, lime, and chili. It\'s tangy, slightly spicy, and perfectly refreshing — a classic Thai street food that pairs well with grilled chicken and sticky rice.',
          },
          {
            'title': 'Pla Pao (Grilled Salted Fish)',
            'thai': 'ปลาเผา',
            'description':
                'Whole fish stuffed with lemongrass and herbs, grilled over charcoal until crispy on the outside and tender inside. It\'s simple, rustic, and bursting with natural flavors — often enjoyed by the river.',
          },
        ];
      case 'Chang-Noi':
        return [
          {
            'title': 'Khao Lam (Bamboo Sticky Rice)',
            'thai': 'ข้าวหลาม',
            'description':
                'Sticky rice mixed with coconut milk and black beans, cooked inside bamboo tubes over an open fire. This traditional snack has a smoky, sweet flavor and is popular at local festivals and markets.',
          },
          {
            'title': 'Nam Prik Ong (Northern Thai Chili Dip)',
            'thai': 'น้ำพริกอ่อง',
            'description':
                'A rich tomato-based chili dip made with minced pork and Thai spices. It\'s eaten with fresh vegetables and sticky rice, and is a staple in northern Thai households.',
          },
          {
            'title': 'Sai Oua (Northern Thai Sausage)',
            'thai': 'ไส้อั่ว',
            'description':
                'Aromatic pork sausage flavored with lemongrass, kaffir lime leaves, and Thai spices. It\'s grilled to perfection and served with sticky rice and fresh herbs — a must-try at local markets.',
          },
        ];
      case 'Ping':
        return [
          {
            'title': 'Pla Nueng Manao (Steamed Fish with Lime)',
            'thai': 'ปลานึ่งมะนาว',
            'description':
                'Fresh fish steamed with lime, garlic, and chili, creating a zesty and aromatic dish. It\'s light yet packed with bold flavors — perfect for those who love seafood and citrusy kicks.',
          },
          {
            'title': 'Tom Yum Goong (Spicy Shrimp Soup)',
            'thai': 'ต้มยำกุ้ง',
            'description':
                'A hot and sour soup with succulent shrimp, mushrooms, tomatoes, and fragrant herbs like lemongrass and galangal. It\'s Thailand\'s most famous soup — fiery, tangy, and utterly addictive.',
          },
          {
            'title':
                'Goong Pad Nam Prik Pao (Stir-Fried Shrimp in Chili Paste)',
            'thai': 'กุ้งผัดน้ำพริกเผา',
            'description':
                'Juicy shrimp stir-fried in a smoky, sweet chili paste with onions and peppers. This dish packs a flavorful punch and pairs wonderfully with steamed rice.',
          },
        ];
      case 'Pla-Kad':
        return [
          {
            'title': 'Massaman Curry with Beef',
            'thai': 'แกงมัสมั่น',
            'description':
                'A rich, mild curry with tender beef, potatoes, and roasted peanuts. Influenced by Persian flavors, it\'s creamy, slightly sweet, and incredibly comforting — often considered Thailand\'s most elegant curry.',
          },
          {
            'title': 'Pla Rad Prik (Fried Fish with Chili Sauce)',
            'thai': 'ปลาราดพริก',
            'description':
                'Crispy fried whole fish topped with a sweet, tangy, and mildly spicy chili sauce. It\'s a restaurant favorite, beautifully presented and bursting with balanced flavors.',
          },
          {
            'title': 'Gaeng Phed Ped Yang (Red Curry with Roasted Duck)',
            'thai': 'แกงเผ็ดเป็ดย่าง',
            'description':
                'Roasted duck in a fragrant red curry with pineapple, tomatoes, and Thai basil. It\'s a sophisticated dish with layers of flavor — sweet, savory, and slightly spicy.',
          },
        ];
      default:
        return [
          {
            'title': 'Mango Sticky Rice',
            'thai': 'Khao Niao Mamuang',
            'description':
                'A popular Thai dessert where ripe, sweet mango is served with sticky rice soaked in coconut milk and topped with crispy mung beans.',
          },
          {
            'title': 'Pad Thai',
            'thai': 'ผัดไทย',
            'description':
                'Stir-fried rice noodles with eggs, tofu, and tamarind sauce, topped with peanuts and lime.',
          },
          {
            'title': 'Tom Yum Soup',
            'thai': 'ต้มยำ',
            'description':
                'A hot and sour soup with fragrant herbs, mushrooms, and your choice of protein.',
          },
        ];
    }
  }

  // Get character-specific Thai events
  List<Map<String, String>> _getCharacterEvents(String characterName) {
    // Event structure: title, description
    switch (characterName) {
      case 'Mali':
        return [
          {
            'title': 'Loy Krathong Music Festival',
            'description':
                'Also known as the Festival of Lights, when people float small "krathongs" — decorative boats made from banana leaves — down rivers. It\'s a big festival that symbolizes letting go of bad luck and making wishes. Some towns also hold lantern releases, which create stunning night views.',
          },
          {
            'title': 'Amazing Thailand Grand Sale',
            'description':
                'Thailand\'s nationwide shopping festival, held annually from June to August. Participate in exclusive deals, special promotions, and cultural events in shopping malls and markets across the country. Perfect for fashion lovers.',
          },
          {
            'title': 'Chiang Mai Art Triennale (Chiang Mai)',
            'description':
                'A contemporary art festival held every three years in Chiang Mai. It showcases local and international artists through installations, exhibitions, and performances across historic and modern art venues.',
          },
        ];
      case 'Chai':
        return [
          {
            'title': 'Makha Bucha Day',
            'description':
                'A Buddhist holiday that commemorates the gathering of 1,250 monks to hear Buddha preach. Temples hold candlelit processions at night, creating a serene and spiritual atmosphere perfect for reflection.',
          },
          {
            'title': 'Bun Bang Fai (Rocket Festival)',
            'description':
                'A traditional rain-making festival in Northeast Thailand where locals launch handmade rockets into the sky. It\'s a colorful, joyful celebration with music, dance, and community spirit.',
          },
          {
            'title': 'Royal Ploughing Ceremony (Bangkok)',
            'description':
                'An ancient Brahmin ritual that marks the start of the rice-growing season. Held at Sanam Luang, it features sacred oxen predicting the year\'s harvest. It\'s a rare glimpse into Thailand\'s agricultural traditions.',
          },
        ];
      case 'Chang-Noi':
        return [
          {
            'title': 'Songkran Festival',
            'description':
                'The Thai New Year celebration, famous for its nationwide water fights. Beyond the fun, it\'s a time for paying respect to elders, visiting temples, and honoring family traditions. Chiang Mai\'s celebration is especially grand.',
          },
          {
            'title': 'Yi Peng Lantern Festival (Chiang Mai)',
            'description':
                'Thousands of glowing lanterns are released into the night sky, creating a magical, dreamlike scene. This northern tradition coincides with Loy Krathong and symbolizes letting go of worries and making wishes.',
          },
          {
            'title': 'Phi Ta Khon Festival (Dan Sai, Loei)',
            'description':
                'A vibrant ghost festival featuring colorful masks, traditional music, and spirited parades. Rooted in local folklore, it\'s a unique cultural event that blends fun, art, and ancient beliefs.',
          },
        ];
      case 'Ping':
        return [
          {
            'title': 'Full Moon Party (Koh Phangan)',
            'description':
                'An iconic beach party held every full moon on Haad Rin Beach. It features fire shows, live DJs, and non-stop dancing under the stars. It\'s a must for thrill-seekers and party lovers.',
          },
          {
            'title': 'Krabi Naga Fest',
            'description':
                'A cultural and adventure event in Krabi featuring rock climbing, kayaking, and traditional performances. It celebrates the region\'s stunning natural landscape and vibrant local culture.',
          },
          {
            'title': 'Phuket King\'s Cup Regatta',
            'description':
                'Asia\'s premier sailing event, attracting international sailors to compete in Phuket\'s crystal-clear waters. It\'s a week of high-energy racing, beachside parties, and ocean adventures.',
          },
        ];
      case 'Pla-Kad':
        return [
          {
            'title': 'Bangkok International Film Festival',
            'description':
                'An annual celebration of cinema from around the world, showcasing independent films, documentaries, and Thai cinema. It\'s a sophisticated cultural event for film enthusiasts.',
          },
          {
            'title': 'Thailand International Jazz Festival (Bangkok & Pattaya)',
            'description':
                'World-class jazz performances in elegant venues and outdoor settings. The festival attracts top international and local artists, offering a refined musical experience.',
          },
          {
            'title': 'Hua Hin Jazz Festival',
            'description':
                'A free beachfront jazz festival held annually in the royal resort town of Hua Hin. It features international and Thai jazz musicians performing against a backdrop of ocean views and sunset.',
          },
        ];
      default:
        return [
          {
            'title': 'Loy Krathong',
            'description':
                'The Festival of Lights, when people float decorative boats down rivers to pay respect to the water goddess.',
          },
          {
            'title': 'Songkran',
            'description':
                'Thai New Year water festival celebrated with water fights and temple visits.',
          },
          {
            'title': 'Yi Peng',
            'description':
                'Lantern festival in Northern Thailand where thousands of lanterns are released into the sky.',
          },
        ];
    }
  }

  // Get character-specific top spots
  List<Map<String, String>> _getCharacterSpots(String characterName) {
    // Spot structure: title, location, area, description
    switch (characterName) {
      case 'Mali':
        return [
          {
            'title': 'Neighbor Thonglor',
            'location': 'Bangkok',
            'area': 'Central Thailand',
            'description':
                'A laid-back bar in Bangkok\'s Thonglor area, designed like a cozy, stylish friend\'s apartment, featuring live music, creative cocktails, and a friendly vibe.',
          },
          {
            'title': 'OKAPI Café - Cozy Art Chic Town',
            'location': 'Chiang Mai',
            'area': 'Northern Thailand',
            'description':
                'A café set near Nimmanhaemin that\'s perfect for aesthetic shots. Known for its wooden decor and chic interior design. The café has big windows, allowing a lot of natural light in.',
          },
          {
            'title': 'Phuket 346 Art Gallery & Café',
            'location': 'Phuket Old Town',
            'area': 'Southern Thailand',
            'description':
                'A quaint café in Phuket Old Town that showcases local artists and modern art installations. Inside offers a lot of Instagrammable moments with cultural flair.',
          },
          {
            'title': 'Baan Kang Wat Artist Village',
            'location': 'Chiang Mai',
            'area': 'Northern Thailand',
            'description':
                'A creative community space where local artists, designers, and craftspeople showcase their work. The village features cozy cafés, art studios, and boutique shops in a peaceful, rustic setting.',
          },
          {
            'title': 'Tha Maharaj Market',
            'location': 'Bangkok',
            'area': 'Central Thailand',
            'description':
                'A trendy riverside market near the Grand Palace offering art, food, and vintage goods. With river views and cultural charm, it\'s a great place to explore local design and cuisine.',
          },
        ];
      case 'Chai':
        return [
          {
            'title': 'Pai Canyon (Kong Lan)',
            'location': 'Pai, Mae Hong Son',
            'area': 'Northern Thailand',
            'description':
                'A series of narrow ridges with stunning valley views, perfect for a peaceful walk or sunset watching. The trails are easy and rewarding, offering tranquility and natural beauty.',
          },
          {
            'title': 'Phu Chi Fa',
            'location': 'Chiang Rai',
            'area': 'Northern Thailand',
            'description':
                'A mountain peak known for breathtaking sunrise views above the sea of mist. It\'s a serene spot for nature lovers and early risers seeking peace and inspiration.',
          },
          {
            'title': 'Khao Sok National Park',
            'location': 'Surat Thani',
            'area': 'Southern Thailand',
            'description':
                'A lush rainforest with limestone cliffs, waterfalls, and Cheow Lan Lake. Stay in floating bungalows, kayak through calm waters, and immerse yourself in unspoiled nature.',
          },
          {
            'title': 'Baan Tawai Village',
            'location': 'Chiang Mai',
            'area': 'Northern Thailand',
            'description':
                'A peaceful handicraft village where local artisans create wood carvings, furniture, and traditional crafts. It\'s a great place to watch artisans at work and find unique souvenirs.',
          },
          {
            'title': 'Amphawa Floating Market',
            'location': 'Samut Songkhram',
            'area': 'Central Thailand',
            'description':
                'A charming riverside market where vendors sell fresh seafood and Thai desserts from boats. It\'s less touristy than Damnoen Saduak and offers an authentic local experience.',
          },
        ];
      case 'Chang-Noi':
        return [
          {
            'title': 'Wat Phra That Doi Suthep',
            'location': 'Chiang Mai',
            'area': 'Northern Thailand',
            'description':
                'A sacred Buddhist temple perched on a mountain, offering panoramic views of Chiang Mai. Climb the 306 steps to reach the golden pagoda and experience its spiritual atmosphere.',
          },
          {
            'title': 'Sukhothai Historical Park',
            'location': 'Sukhothai',
            'area': 'Central Thailand',
            'description':
                'A UNESCO World Heritage Site showcasing the ruins of Thailand\'s first capital. Explore ancient temples, Buddha statues, and lotus-filled ponds by bike or on foot.',
          },
          {
            'title': 'Ban Rai Kong Khing (Thai Wisdom Village)',
            'location': 'Nakhon Ratchasima',
            'area': 'Northeastern Thailand',
            'description':
                'A living museum dedicated to preserving Thai traditions, crafts, and architecture. Visitors can learn traditional weaving, pottery, and farming practices from local artisans.',
          },
          {
            'title': 'Chatuchak Weekend Market',
            'location': 'Bangkok',
            'area': 'Central Thailand',
            'description':
                'One of the world\'s largest markets with over 15,000 stalls selling everything from antiques and handicrafts to clothing and street food. A treasure trove for culture and shopping enthusiasts.',
          },
          {
            'title': 'Bo Sang Umbrella Village',
            'location': 'Chiang Mai',
            'area': 'Northern Thailand',
            'description':
                'A traditional village famous for handmade paper umbrellas and fans. Watch artisans paint intricate designs and even try your hand at the craft.',
          },
        ];
      case 'Ping':
        return [
          {
            'title': 'Railay Beach',
            'location': 'Krabi',
            'area': 'Southern Thailand',
            'description':
                'A stunning peninsula accessible only by boat, famous for rock climbing, clear waters, and dramatic limestone cliffs. Perfect for kayaking, snorkeling, and beach adventures.',
          },
          {
            'title': 'Similan Islands',
            'location': 'Phang Nga',
            'area': 'Southern Thailand',
            'description':
                'A group of islands renowned for world-class diving and snorkeling. Crystal-clear waters, vibrant coral reefs, and diverse marine life make it a paradise for underwater explorers.',
          },
          {
            'title': 'Koh Tao',
            'location': 'Surat Thani',
            'area': 'Southern Thailand',
            'description':
                'A small island famous for scuba diving and snorkeling. With affordable dive courses, beautiful beaches, and a laid-back vibe, it\'s a hotspot for adventure seekers.',
          },
          {
            'title': 'Chiang Mai Flight of the Gibbon',
            'location': 'Chiang Mai',
            'area': 'Northern Thailand',
            'description':
                'An exhilarating zipline adventure through the rainforest canopy. Fly between treetops, cross suspension bridges, and abseil down from platforms for an adrenaline-packed experience.',
          },
          {
            'title': 'Mu Ko Ang Thong National Marine Park',
            'location': 'Surat Thani',
            'area': 'Southern Thailand',
            'description':
                'A pristine archipelago of 42 islands with emerald lagoons, hidden coves, and towering limestone peaks. Perfect for kayaking, snorkeling, and island hopping.',
          },
        ];
      case 'Pla-Kad':
        return [
          {
            'title': 'Mandarin Oriental Bangkok',
            'location': 'Bangkok',
            'area': 'Central Thailand',
            'description':
                'A legendary 5-star hotel along the Chao Phraya River, known for impeccable service, elegant rooms, and world-class dining. It\'s a timeless symbol of Thai luxury and hospitality.',
          },
          {
            'title': 'Amanpuri Resort',
            'location': 'Phuket',
            'area': 'Southern Thailand',
            'description':
                'An ultra-luxurious beachfront resort offering private pavilions, holistic spa treatments, and gourmet dining. It\'s a serene sanctuary for relaxation and refined indulgence.',
          },
          {
            'title': 'Four Seasons Tented Camp Golden Triangle',
            'location': 'Chiang Rai',
            'area': 'Northern Thailand',
            'description':
                'A unique luxury tented camp where guests can interact with rescued elephants in an ethical, intimate setting. It blends adventure with five-star comfort and breathtaking jungle views.',
          },
          {
            'title': 'MOCA Bangkok (Museum of Contemporary Art)',
            'location': 'Bangkok',
            'area': 'Central Thailand',
            'description':
                'A five-story museum showcasing modern and contemporary Thai art. Its impressive collection includes paintings, sculptures, and multimedia installations from renowned Thai artists.',
          },
          {
            'title': 'Siam Paragon & EmQuartier',
            'location': 'Bangkok',
            'area': 'Central Thailand',
            'description':
                'Bangkok\'s most upscale shopping malls featuring luxury brands, fine dining restaurants, and premium entertainment. A haven for fashion enthusiasts and gourmet lovers.',
          },
        ];
      default:
        return [
          {
            'title': 'Grand Palace',
            'location': 'Bangkok',
            'area': 'Central Thailand',
            'description':
                'The former royal residence and Thailand\'s most famous landmark, featuring intricate architecture and the sacred Emerald Buddha.',
          },
          {
            'title': 'Wat Arun',
            'location': 'Bangkok',
            'area': 'Central Thailand',
            'description':
                'The Temple of Dawn, known for its stunning riverside location and ornate spires decorated with colorful porcelain.',
          },
          {
            'title': 'Phi Phi Islands',
            'location': 'Krabi',
            'area': 'Southern Thailand',
            'description':
                'A group of islands famous for dramatic cliffs, clear waters, and vibrant marine life. Perfect for diving and beach relaxation.',
          },
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = characterProfiles[widget.characterName];
    if (profile == null) {
      return const Scaffold(body: Center(child: Text('Character not found')));
    }

    final backgroundImage = getChallengeBackgroundImage(widget.characterName);

    return Scaffold(
      backgroundColor: const Color(0xFFFDFCEF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Character Introduction Section with Background
                  Stack(
                    children: [
                      // Character image section
                      Container(
                        width: double.infinity,
                        // Add padding at bottom for the overlap effect
                        padding: const EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(backgroundImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Image.asset(
                          _getCharacterProfileImagePath(widget.characterName),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) return child;
                            return frame != null
                                ? child
                                : Container(
                                    height: 400,
                                    color: Colors.white.withOpacity(0.2),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFF8B1538),
                                        ),
                                      ),
                                    ),
                                  );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            // Log the error for debugging
                            print(
                              'Error loading image: ${_getCharacterProfileImagePath(widget.characterName)}',
                            );
                            print('Error: $error');
                            return Container(
                              height: 400,
                              color: Colors.white.withOpacity(0.2),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      profile.emoji,
                                      style: const TextStyle(fontSize: 80),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Image not found',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      _getCharacterProfileImagePath(
                                        widget.characterName,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Rounded corner overlay at the bottom
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFDFCEF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Your Travel Vibe Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.yourTravelVibe,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _getCharacterTravelVibe(widget.characterName),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            height: 1.6,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Animal/Symbol Section
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7D1332),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Animal image
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      _getCharacterAnimal(
                                        widget.characterName,
                                      )['image']!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Animal info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getCharacterAnimal(
                                        widget.characterName,
                                      )['name']!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      _getCharacterAnimal(
                                        widget.characterName,
                                      )['description']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Your Perfect Travel Activities
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.yourPerfectTravelActivities,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 3x2 Grid layout - Dynamic based on character
                        Builder(
                          builder: (context) {
                            final activities = _getCharacterActivities(
                              widget.characterName,
                            );
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildActivityIconWithSvg(
                                      activities[0]['label']!,
                                      activities[0]['icon']!,
                                    ),
                                    _buildActivityIconWithSvg(
                                      activities[1]['label']!,
                                      activities[1]['icon']!,
                                    ),
                                    _buildActivityIconWithSvg(
                                      activities[2]['label']!,
                                      activities[2]['icon']!,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildActivityIconWithSvg(
                                      activities[3]['label']!,
                                      activities[3]['icon']!,
                                    ),
                                    _buildActivityIconWithSvg(
                                      activities[4]['label']!,
                                      activities[4]['icon']!,
                                    ),
                                    _buildActivityIconWithSvg(
                                      activities[5]['label']!,
                                      activities[5]['icon']!,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Food Match Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.foodMatchFor(widget.characterName),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_isLoadingData)
                          const Center(child: CircularProgressIndicator())
                        else if (_foods.isEmpty)
                          Text(AppLocalizations.noFoodRecommendations)
                        else
                          ..._foods.map((food) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildFoodCardFromFirebase(food),
                            );
                          }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Thai Events Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.thaiEventsFor(widget.characterName),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_isLoadingData)
                          const Center(child: CircularProgressIndicator())
                        else if (_festivals.isEmpty)
                          Text(AppLocalizations.noFestivalRecommendations)
                        else
                          ..._festivals.map((festival) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildEventCardFromFirebase(festival),
                            );
                          }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Top Spots Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.topSpotsForYou,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_isLoadingData)
                          const Center(child: CircularProgressIndicator())
                        else if (_locations.isEmpty)
                          Text(AppLocalizations.noLocationRecommendations)
                        else
                          ..._locations.map((location) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildSpotCardFromFirebase(location),
                            );
                          }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Discover the Beauty of Thailand Section
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/skyline.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Dark overlay for better text visibility
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                      // Text overlay
                      Container(
                        width: double.infinity,
                        height: 300,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 40,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.discoverBeautyOfThailand,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              AppLocalizations.thailandDescription,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.95),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // CTA Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: const Color(0xFFF5B544),
                                  width: 4,
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: _isLoadingChallenge
                                    ? null
                                    : () async {
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
                                        if (context.mounted) {
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
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEB521A),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (_isLoadingChallenge)
                                      const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    else ...[
                                      SvgPicture.asset(
                                        'assets/challenge_asset/icon_award.svg',
                                        width: 20,
                                        height: 20,
                                        colorFilter: const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: Text(
                                          AppLocalizations.challenge,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: const Color(0xFFF5B544),
                                  width: 4,
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: _saveAndShareImage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEB521A),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.share_rounded, size: 20),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        AppLocalizations.shareResult,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Hashtags
                  Center(
                    child: Text(
                      AppLocalizations.hashtags,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFFEB521A),
        ),
      ),
    );
  }

  Widget _buildActivityIconWithSvg(String label, String imagePath) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5E6D3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              width: 68,
              height: 68,
              fit: BoxFit.contain,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return frame != null
                    ? child
                    : const Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF8B1538),
                            ),
                          ),
                        ),
                      );
              },
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: $imagePath - $error');
                return const Icon(
                  Icons.explore,
                  size: 48,
                  color: Color(0xFF8B1538),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityIcon(String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.image_outlined, size: 24, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFoodCard(String title, String subtitle, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.restaurant, size: 32, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                // Text(
                //   subtitle,
                //   style: TextStyle(
                //     fontSize: 13,
                //     color: Colors.grey[600],
                //     fontStyle: FontStyle.italic,
                //   ),
                // ),
                // const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCardFromFirebase(Map<String, dynamic> food) {
    final name = food['name'] ?? food['foodStyle'] ?? 'Unknown Food';
    final foodStyle = food['foodStyle'] ?? '';
    final description = food['description'] ?? '';
    final imageUrl = food['imageUrl'] as String?;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: imageUrl != null && imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.restaurant,
                          size: 32,
                          color: Colors.grey,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF8B1538),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Icon(Icons.restaurant, size: 32, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.event, size: 32, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCardFromFirebase(Map<String, dynamic> festival) {
    final name = festival['name'] ?? 'Unknown Festival';
    final description = festival['description'] ?? '';
    final festivalPeriod = festival['festivalPeriod'] ?? '';
    final imageUrl = festival['imageUrl'] as String?;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: imageUrl != null && imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.event,
                          size: 32,
                          color: Colors.grey,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF8B1538),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Icon(Icons.event, size: 32, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                if (festivalPeriod.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    festivalPeriod,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpotCard(
    String title,
    String location,
    String area,
    String description,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full image at top (no border, full width)
          Container(
            width: double.infinity,
            height: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Orange row with name and location
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFFEB521A),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  location,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
          // Dash line divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomPaint(
              painter: DashedLinePainter(),
              size: const Size(double.infinity, 1),
            ),
          ),
          const SizedBox(height: 16),
          // Last section with map icon, area text, and View Map button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.map, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    area,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
                GestureDetector(
                  onTap: () => _openLocation(title, location),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEB521A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      AppLocalizations.viewMap,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSpotCardFromFirebase(Map<String, dynamic> location) {
    final name =
        location['destinationName'] ?? location['name'] ?? 'Unknown Location';
    final province = location['province'] ?? '';
    final region = location['region'] ?? '';
    final description = location['description'] ?? '';
    final highlight = location['highlight'] ?? '';
    final imageUrl = location['imageUrl'] as String?;
    final googleMapLink = location['googleMapLink'] as String?;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full image at top (no border, full width)
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.place, size: 48, color: Colors.grey),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF8B1538),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Icon(Icons.place, size: 48, color: Colors.grey),
                  ),
          ),
          // Orange row with name and location
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFFEB521A),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (province.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Text(
                    province,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ],
            ),
          ),
          // Description and Highlight
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  "Highlights:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[900],
                    height: 1.5,
                  ),
                ),
                if (highlight.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    // Remove extra newlines and spaces
                    highlight
                        .replaceAll(RegExp(r'\n+'), ' ')
                        .replaceAll(RegExp(r'\s+'), ' ')
                        .trim(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Dash line divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomPaint(
              painter: DashedLinePainter(),
              size: const Size(double.infinity, 1),
            ),
          ),
          const SizedBox(height: 16),
          // Last section with region icon, area text, and View Map button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.asset(
                  _getRegionIconPath(region.isNotEmpty ? region : province),
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.map, size: 20, color: Colors.grey);
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    region.isNotEmpty ? region : province,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
                GestureDetector(
                  onTap: () => googleMapLink != null && googleMapLink.isNotEmpty
                      ? _openGoogleMapLink(googleMapLink)
                      : _openLocation(name, province),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEB521A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      AppLocalizations.viewMap,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Open Google Maps link directly
  Future<void> _openGoogleMapLink(String googleMapLink) async {
    try {
      if (kIsWeb) {
        // For web, use js interop to open in new tab
        js.context.callMethod('open', [googleMapLink, '_blank']);
      } else {
        final uri = Uri.parse(googleMapLink);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open maps')),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error opening maps: $e')));
      }
    }
  }

  Widget _buildHighlightItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, size: 20, color: Color(0xFFEB521A)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

// Custom painter for dashed line
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
