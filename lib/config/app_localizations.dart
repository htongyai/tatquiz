import 'language_config.dart';

class AppLocalizations {
  // Helper method to get text based on language config
  static String getText({
    required String english,
    required String spanish,
    required String german,
    required String russian,
  }) {
    if (LanguageConfig.isSpanish) return spanish;
    if (LanguageConfig.isGerman) return german;
    if (LanguageConfig.isRussian) return russian;
    return english;
  }

  // ============================================
  // START SCREEN
  // ============================================
  static String get letsFind => getText(
    english: 'Let\'s find your Thai',
    spanish: 'Encuentra tu personalidad',
    german: 'Finde deine Thai',
    russian: 'Давайте найдем вашу тайскую',
  );

  static String get travelPersonality => getText(
    english: 'travel personality',
    spanish: 'viajera tailandesa',
    german: 'Reisepersönlichkeit',
    russian: 'личность путешественника',
  );

  static String get uncoverYours => getText(
    english: 'Uncover yours and see',
    spanish: 'Descubre la tuya y mira',
    german: 'Entdecke deine und sieh',
    russian: 'Откройте свою и посмотрите',
  );

  static String get whereItBegins => getText(
    english: 'where it begins in Thailand',
    spanish: 'dónde comienza en Tailandia',
    german: 'wo es in Thailand beginnt',
    russian: 'где это начинается в Таиланде',
  );

  static String get world => getText(
    english: 'World',
    spanish: 'Mundo',
    german: 'Welt',
    russian: 'Мир',
  );

  static String get thailand => getText(
    english: 'Thailand',
    spanish: 'Tailandia',
    german: 'Thailand',
    russian: 'Таиланд',
  );

  static String get startJourney => getText(
    english: 'Start Journey',
    spanish: 'Comenzar Viaje',
    german: 'Reise Beginnen',
    russian: 'Начать Путешествие',
  );

  // ============================================
  // PERSONALITY INTRO SCREEN
  // ============================================
  static String get howToPlay => getText(
    english: 'How To Play',
    spanish: 'Cómo Jugar',
    german: 'Wie Man Spielt',
    russian: 'Как Играть',
  );

  static String get step1Title => getText(
    english: 'Answer 12 Questions',
    spanish: 'Responde 12 Preguntas',
    german: 'Beantworte 12 Fragen',
    russian: 'Ответьте на 12 вопросов',
  );

  static String get step1Description => getText(
    english: 'Share your travel preferences and style',
    spanish: 'Comparte tus preferencias y estilo de viaje',
    german: 'Teile deine Reisepräferenzen und deinen Stil',
    russian: 'Поделитесь своими предпочтениями и стилем путешествий',
  );

  static String get step2Title => getText(
    english: 'Discover Your Match',
    spanish: 'Descubre Tu Compatibilidad',
    german: 'Entdecke Deine Übereinstimmung',
    russian: 'Откройте свое соответствие',
  );

  static String get step2Description => getText(
    english: 'Find out which Thai travel personality fits you',
    spanish: 'Descubre qué personalidad viajera tailandesa te queda',
    german:
        'Finde heraus, welche thailändische Reisepersönlichkeit zu dir passt',
    russian: 'Узнайте, какая тайская личность путешественника вам подходит',
  );

  static String get step3Title => getText(
    english: 'Get Personalized Tips',
    spanish: 'Obtén Consejos Personalizados',
    german: 'Erhalte Personalisierte Tipps',
    russian: 'Получите персональные советы',
  );

  static String get step3Description => getText(
    english: 'Receive customized recommendations for your trip',
    spanish: 'Recibe recomendaciones personalizadas para tu viaje',
    german: 'Erhalte maßgeschneiderte Empfehlungen für deine Reise',
    russian: 'Получите индивидуальные рекомендации для вашей поездки',
  );

  static String get beginQuiz => getText(
    english: 'Begin Quiz',
    spanish: 'Comenzar Quiz',
    german: 'Quiz Beginnen',
    russian: 'Начать Викторину',
  );

  // ============================================
  // QUIZ QUESTION SCREEN
  // ============================================
  static String questionOf(int current, int total) => getText(
    english: 'Question $current of $total',
    spanish: 'Pregunta $current de $total',
    german: 'Frage $current von $total',
    russian: 'Вопрос $current из $total',
  );

  static String get nextQuestion => getText(
    english: 'Next',
    spanish: 'Siguiente',
    german: 'Weiter',
    russian: 'Далее',
  );

  static String get previousQuestion => getText(
    english: 'Previous',
    spanish: 'Anterior',
    german: 'Zurück',
    russian: 'Назад',
  );

  // ============================================
  // USER INFO SCREEN
  // ============================================
  static String get almostThere => getText(
    english: 'Almost there!',
    spanish: '¡Casi está!',
    german: 'Fast geschafft!',
    russian: 'Почти готово!',
  );

  static String get tellUsAboutYou => getText(
    english: 'Tell us a bit about you',
    spanish: 'Cuéntanos un poco sobre ti',
    german: 'Erzähl uns etwas über dich',
    russian: 'Расскажите немного о себе',
  );

  static String get gender => getText(
    english: 'Gender',
    spanish: 'Género',
    german: 'Geschlecht',
    russian: 'Пол',
  );

  static String get selectGender => getText(
    english: 'Select gender',
    spanish: 'Seleccionar género',
    german: 'Geschlecht wählen',
    russian: 'Выберите пол',
  );

  static String get age => getText(
    english: 'Age',
    spanish: 'Edad',
    german: 'Alter',
    russian: 'Возраст',
  );

  static String get selectYourAge => getText(
    english: 'Select your age',
    spanish: 'Selecciona tu edad',
    german: 'Wähle dein Alter',
    russian: 'Выберите свой возраст',
  );

  static String get nationality => getText(
    english: 'Nationality',
    spanish: 'Nacionalidad',
    german: 'Nationalität',
    russian: 'Национальность',
  );

  static String get selectNationality => getText(
    english: 'Select nationality',
    spanish: 'Seleccionar nacionalidad',
    german: 'Nationalität wählen',
    russian: 'Выберите национальность',
  );

  static String get getMyResult => getText(
    english: 'Get My Result',
    spanish: 'Obtener Mi Resultado',
    german: 'Mein Ergebnis',
    russian: 'Получить Результат',
  );

  // Gender options
  static String get female => getText(
    english: 'Female',
    spanish: 'Femenino',
    german: 'Weiblich',
    russian: 'Женский',
  );

  static String get male => getText(
    english: 'Male',
    spanish: 'Masculino',
    german: 'Männlich',
    russian: 'Мужской',
  );

  static String get others => getText(
    english: 'I rather not say',
    spanish: 'Prefiero no decirlo',
    german: 'Möchte ich nicht angeben',
    russian: 'Предпочитаю не отвечать',
  );

  // ============================================
  // LOADING SCREEN
  // ============================================
  static String get findingYourTravelSpirit => getText(
    english: 'Finding your travel spirit...',
    spanish: 'Encontrando tu espíritu viajero...',
    german: 'Finde deinen Reisegeist...',
    russian: 'Ищем ваш дух путешествий...',
  );

  static String get analyzingResponses => getText(
    english: 'Analyzing your responses',
    spanish: 'Analizando tus respuestas',
    german: 'Analysiere deine Antworten',
    russian: 'Анализируем ваши ответы',
  );

  // ============================================
  // RESULT SCREEN
  // ============================================
  static String get yourTourismPersonalityIs => getText(
    english: 'Your Tourism Personality is...',
    spanish: 'Tu Personalidad Turística es...',
    german: 'Deine Tourismus-Persönlichkeit ist...',
    russian: 'Ваша туристическая личность...',
  );

  static String get yourTravelVibe => getText(
    english: 'Your Travel Vibe',
    spanish: 'Tu Vibra de Viaje',
    german: 'Deine Reise-Stimmung',
    russian: 'Ваша атмосфера путешествия',
  );

  static String get topSpotsForYou => getText(
    english: 'Top Spots for You',
    spanish: 'Mejores Lugares Para Ti',
    german: 'Top-Orte für Dich',
    russian: 'Лучшие места для вас',
  );

  static String get localDish => getText(
    english: 'Local Dish :',
    spanish: 'Plato Local :',
    german: 'Lokales Gericht :',
    russian: 'Местное блюдо :',
  );

  static String get thaiFestival => getText(
    english: 'Thai Festival :',
    spanish: 'Festival Tailandés :',
    german: 'Thai Festival :',
    russian: 'Тайский фестиваль :',
  );

  static String get viewFullResult => getText(
    english: 'View Full Result',
    spanish: 'Ver Resultado Completo',
    german: 'Vollständiges Ergebnis',
    russian: 'Посмотреть полный результат',
  );

  static String get shareResult => getText(
    english: 'Share',
    spanish: 'Compartir',
    german: 'Teilen',
    russian: 'Поделиться',
  );

  // ============================================
  // FULL RESULT SCREEN
  // ============================================
  static String get fullResultTitle => getText(
    english: 'Your Complete Profile',
    spanish: 'Tu Perfil Completo',
    german: 'Dein Vollständiges Profil',
    russian: 'Ваш полный профиль',
  );

  static String get travelStyle => getText(
    english: 'Travel Style',
    spanish: 'Estilo de Viaje',
    german: 'Reisestil',
    russian: 'Стиль путешествия',
  );

  static String get recommendedActivities => getText(
    english: 'Recommended Activities',
    spanish: 'Actividades Recomendadas',
    german: 'Empfohlene Aktivitäten',
    russian: 'Рекомендуемые мероприятия',
  );

  static String get perfectDestinations => getText(
    english: 'Perfect Destinations',
    spanish: 'Destinos Perfectos',
    german: 'Perfekte Reiseziele',
    russian: 'Идеальные направления',
  );

  static String get foodMatch => getText(
    english: 'Food Match',
    spanish: 'Compatibilidad Gastronómica',
    german: 'Essens-Match',
    russian: 'Кулинарное соответствие',
  );

  static String get festivalRecommendations => getText(
    english: 'Festival Recommendations',
    spanish: 'Recomendaciones de Festivales',
    german: 'Festival-Empfehlungen',
    russian: 'Рекомендации фестивалей',
  );

  static String get culturalHighlights => getText(
    english: 'Cultural Highlights',
    spanish: 'Aspectos Culturales Destacados',
    german: 'Kulturelle Höhepunkte',
    russian: 'Культурные особенности',
  );

  static String get backToHome => getText(
    english: 'Back to Home',
    spanish: 'Volver al Inicio',
    german: 'Zurück zur Startseite',
    russian: 'Вернуться на главную',
  );

  static String get retakeQuiz => getText(
    english: 'Retake Quiz',
    spanish: 'Repetir Quiz',
    german: 'Quiz Wiederholen',
    russian: 'Пройти заново',
  );

  static String get downloadResult => getText(
    english: 'Download Result',
    spanish: 'Descargar Resultado',
    german: 'Ergebnis Herunterladen',
    russian: 'Скачать результат',
  );

  static String get yourPerfectTravelActivities => getText(
    english: 'Your Perfect Travel Activities',
    spanish: 'Tus Actividades de Viaje Perfectas',
    german: 'Deine Perfekten Reiseaktivitäten',
    russian: 'Ваши идеальные туристические мероприятия',
  );

  static String foodMatchFor(String characterName) => getText(
    english: 'Food Match for $characterName',
    spanish: 'Compatibilidad Gastronómica para $characterName',
    german: 'Essens-Match für $characterName',
    russian: 'Кулинарное соответствие для $characterName',
  );

  static String thaiEventsFor(String characterName) => getText(
    english: 'Thai Events for $characterName',
    spanish: 'Eventos Tailandeses para $characterName',
    german: 'Thai-Veranstaltungen für $characterName',
    russian: 'Тайские события для $characterName',
  );

  static String get challenge => getText(
    english: 'Challenge',
    spanish: 'Desafío',
    german: 'Herausforderung',
    russian: 'Испытание',
  );

  static String get viewMap => getText(
    english: 'View Map',
    spanish: 'Ver Mapa',
    german: 'Karte Ansehen',
    russian: 'Посмотреть карту',
  );

  static String get noFoodRecommendations => getText(
    english: 'No food recommendations available',
    spanish: 'No hay recomendaciones de comida disponibles',
    german: 'Keine Essensempfehlungen verfügbar',
    russian: 'Нет доступных рекомендаций по еде',
  );

  static String get noFestivalRecommendations => getText(
    english: 'No festival recommendations available',
    spanish: 'No hay recomendaciones de festivales disponibles',
    german: 'Keine Festivalempfehlungen verfügbar',
    russian: 'Нет доступных рекомендаций по фестивалям',
  );

  static String get noLocationRecommendations => getText(
    english: 'No location recommendations available',
    spanish: 'No hay recomendaciones de ubicación disponibles',
    german: 'Keine Standortempfehlungen verfügbar',
    russian: 'Нет доступных рекомендаций по местам',
  );

  static String get discoverBeautyOfThailand => getText(
    english: 'Discover the Beauty of Thailand',
    spanish: 'Descubre la Belleza de Tailandia',
    german: 'Entdecke die Schönheit Thailands',
    russian: 'Откройте красоту Таиланда',
  );

  static String get thailandDescription => getText(
    english:
        'A land of smiles, flavors, and endless inspiration where every journey feels like home.',
    spanish:
        'Una tierra de sonrisas, sabores e inspiración infinita donde cada viaje se siente como en casa.',
    german:
        'Ein Land voller Lächeln, Aromen und endloser Inspiration, wo sich jede Reise wie zu Hause anfühlt.',
    russian:
        'Страна улыбок, вкусов и бесконечного вдохновения, где каждое путешествие ощущается как дома.',
  );

  static String get highlight => getText(
    english: 'Highlight',
    spanish: 'Destacado',
    german: 'Höhepunkt',
    russian: 'Особенности',
  );

  // ============================================
  // ACTIVITY LABELS
  // ============================================
  static String get cafeHopping => getText(
    english: 'Café Hopping',
    spanish: 'Cafeterías',
    german: 'Café-Hopping',
    russian: 'Посещение кафе',
  );

  static String get artWalk => getText(
    english: 'Art Walk',
    spanish: 'Paseo de Arte',
    german: 'Kunstspaziergang',
    russian: 'Прогулка по галереям',
  );

  static String get boutiqueStay => getText(
    english: 'Boutique Stay',
    spanish: 'Estancia Boutique',
    german: 'Boutique-Aufenthalt',
    russian: 'Бутик-отель',
  );

  static String get contemporaryFestivals => getText(
    english: 'Contemporary Festivals',
    spanish: 'Festivales Contemporáneos',
    german: 'Zeitgenössische Festivals',
    russian: 'Современные фестивали',
  );

  static String get rooftopDining => getText(
    english: 'Rooftop Dining',
    spanish: 'Cena en Azotea',
    german: 'Rooftop-Dining',
    russian: 'Ужин на крыше',
  );

  static String get fashionDesignMarket => getText(
    english: 'Fashion/Design Market',
    spanish: 'Mercado de Moda/Diseño',
    german: 'Mode-/Designmarkt',
    russian: 'Рынок моды/дизайна',
  );

  static String get homestay => getText(
    english: 'Homestay',
    spanish: 'Casa Rural',
    german: 'Homestay',
    russian: 'Проживание в семье',
  );

  static String get mindfulness => getText(
    english: 'Mindfulness',
    spanish: 'Atención Plena',
    german: 'Achtsamkeit',
    russian: 'Осознанность',
  );

  static String get farmWalk => getText(
    english: 'Farm Walk',
    spanish: 'Paseo por Granja',
    german: 'Farmspaziergang',
    russian: 'Прогулка по ферме',
  );

  static String get marketBreakfast => getText(
    english: 'Market Breakfast',
    spanish: 'Desayuno en Mercado',
    german: 'Marktfrühstück',
    russian: 'Завтрак на рынке',
  );

  static String get readingByRiver => getText(
    english: 'Reading by River',
    spanish: 'Lectura junto al Río',
    german: 'Lesen am Fluss',
    russian: 'Чтение у реки',
  );

  static String get softAdventure => getText(
    english: 'Soft Adventure',
    spanish: 'Aventura Suave',
    german: 'Sanftes Abenteuer',
    russian: 'Легкое приключение',
  );

  static String get heritageTempleTour => getText(
    english: 'Heritage Temple Tour',
    spanish: 'Tour de Templos Patrimonio',
    german: 'Tempeltour',
    russian: 'Экскурсия по храмам',
  );

  static String get localMarket => getText(
    english: 'Local Market',
    spanish: 'Mercado Local',
    german: 'Lokaler Markt',
    russian: 'Местный рынок',
  );

  static String get craftWorkshop => getText(
    english: 'Craft Workshop',
    spanish: 'Taller de Artesanía',
    german: 'Handwerksworkshop',
    russian: 'Мастер-класс',
  );

  static String get vintageSouvenir => getText(
    english: 'Vintage Souvenir',
    spanish: 'Souvenir Vintage',
    german: 'Vintage-Souvenir',
    russian: 'Винтажный сувенир',
  );

  static String get cookingClass => getText(
    english: 'Cooking Class',
    spanish: 'Clase de Cocina',
    german: 'Kochkurs',
    russian: 'Кулинарный класс',
  );

  static String get traditionalFestival => getText(
    english: 'Traditional Festival',
    spanish: 'Festival Tradicional',
    german: 'Traditionelles Festival',
    russian: 'Традиционный фестиваль',
  );

  static String get snorkeling => getText(
    english: 'Snorkeling',
    spanish: 'Esnórquel',
    german: 'Schnorcheln',
    russian: 'Снорклинг',
  );

  static String get kayaking => getText(
    english: 'Kayaking',
    spanish: 'Kayak',
    german: 'Kajakfahren',
    russian: 'Каякинг',
  );

  static String get beachBonfire => getText(
    english: 'Beach Bonfire',
    spanish: 'Fogata en la Playa',
    german: 'Strandlagerfeuer',
    russian: 'Костер на пляже',
  );

  static String get coastalRide => getText(
    english: 'Coastal Ride',
    spanish: 'Paseo Costero',
    german: 'Küstenfahrt',
    russian: 'Прибрежная поездка',
  );

  static String get divingTrip => getText(
    english: 'Diving Trip',
    spanish: 'Viaje de Buceo',
    german: 'Tauchausflug',
    russian: 'Дайвинг',
  );

  static String get seafoodHunt => getText(
    english: 'Seafood Hunt',
    spanish: 'Búsqueda de Mariscos',
    german: 'Meeresfrüchte-Suche',
    russian: 'Поиск морепродуктов',
  );

  static String get luxurySpa => getText(
    english: 'Luxury Spa/\nWellness Retreat',
    spanish: 'Spa de Lujo/\nRetiro de Bienestar',
    german: 'Luxus-Spa/\nWellness-Retreat',
    russian: 'Роскошный спа/\nВелнес-ретрит',
  );

  static String get fineDining => getText(
    english: 'Fine Dining',
    spanish: 'Alta Cocina',
    german: 'Fine Dining',
    russian: 'Изысканная кухня',
  );

  static String get artGallery => getText(
    english: 'Art Gallery',
    spanish: 'Galería de Arte',
    german: 'Kunstgalerie',
    russian: 'Художественная галерея',
  );

  static String get beachfrontResort => getText(
    english: 'Beachfront Resort',
    spanish: 'Resort Frente al Mar',
    german: 'Strandresort',
    russian: 'Курорт на берегу',
  );

  static String get fashion => getText(
    english: 'Fashion',
    spanish: 'Moda',
    german: 'Mode',
    russian: 'Мода',
  );

  static String get festivals => getText(
    english: 'Festivals',
    spanish: 'Festivales',
    german: 'Festivals',
    russian: 'Фестивали',
  );

  // ============================================
  // TAGS & CHARACTERISTICS
  // ============================================
  static String get aesthetic => getText(
    english: 'Aesthetic',
    spanish: 'Estético',
    german: 'Ästhetisch',
    russian: 'Эстетичный',
  );

  static String get curious => getText(
    english: 'Curious',
    spanish: 'Curioso',
    german: 'Neugierig',
    russian: 'Любопытный',
  );

  static String get social => getText(
    english: 'Social',
    spanish: 'Social',
    german: 'Sozial',
    russian: 'Общительный',
  );

  static String get creative => getText(
    english: 'Creative',
    spanish: 'Creativo',
    german: 'Kreativ',
    russian: 'Творческий',
  );

  static String get cultural => getText(
    english: 'Cultural',
    spanish: 'Cultural',
    german: 'Kulturell',
    russian: 'Культурный',
  );

  static String get traditional => getText(
    english: 'Traditional',
    spanish: 'Tradicional',
    german: 'Traditionell',
    russian: 'Традиционный',
  );

  static String get authentic => getText(
    english: 'Authentic',
    spanish: 'Auténtico',
    german: 'Authentisch',
    russian: 'Подлинный',
  );

  static String get respectful => getText(
    english: 'Respectful',
    spanish: 'Respetuoso',
    german: 'Respektvoll',
    russian: 'Уважительный',
  );

  static String get adventurous => getText(
    english: 'Adventurous',
    spanish: 'Aventurero',
    german: 'Abenteuerlustig',
    russian: 'Авантюрный',
  );

  static String get bold => getText(
    english: 'Bold',
    spanish: 'Audaz',
    german: 'Mutig',
    russian: 'Смелый',
  );

  static String get spontaneous => getText(
    english: 'Spontaneous',
    spanish: 'Espontáneo',
    german: 'Spontan',
    russian: 'Спонтанный',
  );

  static String get active => getText(
    english: 'Active',
    spanish: 'Activo',
    german: 'Aktiv',
    russian: 'Активный',
  );

  static String get mindful => getText(
    english: 'Mindful',
    spanish: 'Consciente',
    german: 'Achtsam',
    russian: 'Внимательный',
  );

  static String get peaceful => getText(
    english: 'Peaceful',
    spanish: 'Pacífico',
    german: 'Friedlich',
    russian: 'Мирный',
  );

  static String get balanced => getText(
    english: 'Balanced',
    spanish: 'Equilibrado',
    german: 'Ausgeglichen',
    russian: 'Сбалансированный',
  );

  static String get serene => getText(
    english: 'Serene',
    spanish: 'Sereno',
    german: 'Gelassen',
    russian: 'Безмятежный',
  );

  static String get luxurious => getText(
    english: 'Luxurious',
    spanish: 'Lujoso',
    german: 'Luxuriös',
    russian: 'Роскошный',
  );

  static String get refined => getText(
    english: 'Refined',
    spanish: 'Refinado',
    german: 'Raffiniert',
    russian: 'Утонченный',
  );

  static String get elegant => getText(
    english: 'Elegant',
    spanish: 'Elegante',
    german: 'Elegant',
    russian: 'Элегантный',
  );

  static String get sophisticated => getText(
    english: 'Sophisticated',
    spanish: 'Sofisticado',
    german: 'Anspruchsvoll',
    russian: 'Изысканный',
  );

  // ============================================
  // CHARACTER SUBTITLES (Keep character names unchanged)
  // ============================================
  static String getCharacterSubtitle(String character) {
    switch (character) {
      case 'Mali':
        return getText(
          english: 'the Chic Cat',
          spanish: 'el Gato Elegante',
          german: 'die Schicke Katze',
          russian: 'шикарная кошка',
        );
      case 'Chang-Noi':
        return getText(
          english: 'the Heritage Guardian',
          spanish: 'el Guardián del Patrimonio',
          german: 'der Erbe-Wächter',
          russian: 'хранитель наследия',
        );
      case 'Ping':
        return getText(
          english: 'the Thrill Chaser',
          spanish: 'el Cazador de Emociones',
          german: 'der Nervenkitzel-Jäger',
          russian: 'охотник за острыми ощущениями',
        );
      case 'Chai':
        return getText(
          english: 'the Peaceful Soul',
          spanish: 'el Alma Pacífica',
          german: 'die Friedliche Seele',
          russian: 'мирная душа',
        );
      case 'Pla-Kad':
        return getText(
          english: 'the Refined Traveler',
          spanish: 'el Viajero Refinado',
          german: 'der Raffinierte Reisende',
          russian: 'изысканный путешественник',
        );
      default:
        return getText(
          english: 'the Chic Cat',
          spanish: 'el Gato Elegante',
          german: 'die Schicke Katze',
          russian: 'шикарная кошка',
        );
    }
  }

  // ============================================
  // CHARACTER PROFILE TITLES
  // ============================================
  static String getCharacterTitle(String character) {
    switch (character) {
      case 'Mali':
        return getText(
          english: 'The Urban Aesthetician',
          spanish: 'La Esteticista Urbana',
          german: 'Die Urbane Ästhetin',
          russian: 'Городской эстет',
        );
      case 'Chang-Noi':
        return getText(
          english: 'The Heritage Guardian',
          spanish: 'El Guardián del Patrimonio',
          german: 'Der Erbe-Wächter',
          russian: 'Хранитель наследия',
        );
      case 'Ping':
        return getText(
          english: 'The Thrill Chaser',
          spanish: 'El Cazador de Emociones',
          german: 'Der Nervenkitzel-Jäger',
          russian: 'Охотник за острыми ощущениями',
        );
      case 'Chai':
        return getText(
          english: 'The Peaceful Soul',
          spanish: 'El Alma Pacífica',
          german: 'Die Friedliche Seele',
          russian: 'Мирная душа',
        );
      case 'Pla-Kad':
        return getText(
          english: 'The Refined Traveler',
          spanish: 'El Viajero Refinado',
          german: 'Der Raffinierte Reisende',
          russian: 'Изысканный путешественник',
        );
      default:
        return getText(
          english: 'The Urban Aesthetician',
          spanish: 'La Esteticista Urbana',
          german: 'Die Urbane Ästhetin',
          russian: 'Городской эстет',
        );
    }
  }

  // ============================================
  // CHARACTER TRAVEL VIBES
  // ============================================
  static String getTravelVibe(String character) {
    switch (character) {
      case 'Mali':
        return getText(
          english:
              '"You love stylish cafés, art corners, and beautiful stays. You travel for stories and aesthetic experiences."',
          spanish:
              '"Te encantan los cafés elegantes, rincones artísticos y alojamientos hermosos. Viajas por historias y experiencias estéticas."',
          german:
              '"Du liebst stilvolle Cafés, Kunstecken und schöne Unterkünfte. Du reist für Geschichten und ästhetische Erlebnisse."',
          russian:
              '"Вы любите стильные кафе, уголки искусства и красивые места для проживания. Вы путешествуете за историями и эстетическими впечатлениями."',
        );
      case 'Chang-Noi':
        return getText(
          english:
              '"You seek authentic cultural experiences, from ancient temples to local traditions. Every journey is a lesson in heritage."',
          spanish:
              '"Buscas experiencias culturales auténticas, desde templos antiguos hasta tradiciones locales. Cada viaje es una lección de patrimonio."',
          german:
              '"Du suchst authentische kulturelle Erlebnisse, von alten Tempeln bis zu lokalen Traditionen. Jede Reise ist eine Lektion in Erbe."',
          russian:
              '"Вы ищете подлинные культурные впечатления, от древних храмов до местных традиций. Каждое путешествие — это урок наследия."',
        );
      case 'Ping':
        return getText(
          english:
              '"You crave excitement and new adventures. From beach sports to mountain hikes, you dive headfirst into every experience."',
          spanish:
              '"Anhelas emoción y nuevas aventuras. Desde deportes de playa hasta caminatas en montañas, te sumerges de cabeza en cada experiencia."',
          german:
              '"Du sehnst dich nach Aufregung und neuen Abenteuern. Von Strandsportarten bis zu Bergwanderungen stürzt du dich kopfüber in jedes Erlebnis."',
          russian:
              '"Вы жаждете волнения и новых приключений. От пляжных видов спорта до горных походов, вы с головой погружаетесь в каждое впечатление."',
        );
      case 'Chai':
        return getText(
          english:
              '"You travel to find peace and balance. Nature walks, quiet moments, and mindful experiences bring you joy."',
          spanish:
              '"Viajas para encontrar paz y equilibrio. Paseos por la naturaleza, momentos tranquilos y experiencias conscientes te traen alegría."',
          german:
              '"Du reist, um Frieden und Gleichgewicht zu finden. Naturspaziergänge, ruhige Momente und achtsame Erlebnisse bringen dir Freude."',
          russian:
              '"Вы путешествуете, чтобы найти покой и баланс. Прогулки на природе, тихие моменты и осознанные впечатления приносят вам радость."',
        );
      case 'Pla-Kad':
        return getText(
          english:
              '"You appreciate the finer things. Luxury hotels, fine dining, and premium experiences define your perfect trip."',
          spanish:
              '"Aprecias las cosas más finas. Hoteles de lujo, gastronomía refinada y experiencias premium definen tu viaje perfecto."',
          german:
              '"Du schätzt die feineren Dinge. Luxushotels, gehobene Küche und Premium-Erlebnisse definieren deine perfekte Reise."',
          russian:
              '"Вы цените лучшие вещи. Роскошные отели, изысканная кухня и премиальные впечатления определяют ваше идеальное путешествие."',
        );
      default:
        return getText(
          english:
              '"You love stylish cafés, art corners, and beautiful stays. You travel for stories and aesthetic experiences."',
          spanish:
              '"Te encantan los cafés elegantes, rincones artísticos y alojamientos hermosos. Viajas por historias y experiencias estéticas."',
          german:
              '"Du liebst stilvolle Cafés, Kunstecken und schöne Unterkünfte. Du reist für Geschichten und ästhetische Erlebnisse."',
          russian:
              '"Вы любите стильные кафе, уголки искусства и красивые места для проживания. Вы путешествуете за историями и эстетическими впечатлениями."',
        );
    }
  }

  // ============================================
  // CHALLENGE SCREENS
  // ============================================
  static String get howWellDoYouKnowThailand => getText(
    english: 'How Well Do You Know Thailand?',
    spanish: '¿Qué tan bien conoces Tailandia?',
    german: 'Wie gut kennst du Thailand?',
    russian: 'Насколько хорошо вы знаете Таиланд?',
  );

  static String get challengeDescription => getText(
    english:
        'Test your Thailand knowledge with fun True - False questions and complete the challenge for a chance to win special gifts.',
    spanish:
        'Pon a prueba tu conocimiento de Tailandia con divertidas preguntas de Verdadero - Falso y completa el desafío para tener la oportunidad de ganar regalos especiales.',
    german:
        'Teste dein Thailand-Wissen mit lustigen Richtig-Falsch-Fragen und schließe die Herausforderung ab, um eine Chance auf besondere Geschenke zu gewinnen.',
    russian:
        'Проверьте свои знания о Таиланде с помощью забавных вопросов Правда-Ложь и пройдите испытание, чтобы получить шанс выиграть особые подарки.',
  );

  static String get startChallenge => getText(
    english: 'Start Challenge',
    spanish: 'Comenzar Desafío',
    german: 'Herausforderung Starten',
    russian: 'Начать Испытание',
  );

  static String questionOfChallenge(int current, int total) => getText(
    english: 'Question $current of $total',
    spanish: 'Pregunta $current de $total',
    german: 'Frage $current von $total',
    russian: 'Вопрос $current из $total',
  );

  static String get trueButton => getText(
    english: 'True',
    spanish: 'Verdadero',
    german: 'Richtig',
    russian: 'Правда',
  );

  static String get falseButton => getText(
    english: 'False',
    spanish: 'Falso',
    german: 'Falsch',
    russian: 'Ложь',
  );

  static String get greatJob => getText(
    english: 'Great job!',
    spanish: '¡Buen trabajo!',
    german: 'Großartige Arbeit!',
    russian: 'Отличная работа!',
  );

  static String get notQuite => getText(
    english: 'Not quite! But keep going!',
    spanish: '¡No del todo! ¡Pero sigue adelante!',
    german: 'Nicht ganz! Aber mach weiter!',
    russian: 'Не совсем! Но продолжайте!',
  );

  static String get nextButton => getText(
    english: 'Next',
    spanish: 'Siguiente',
    german: 'Weiter',
    russian: 'Далее',
  );

  static String get basedOnYourTravelPersonality => getText(
    english: 'Based on your travel personality',
    spanish: 'Basado en tu personalidad viajera',
    german: 'Basierend auf deiner Reisepersönlichkeit',
    russian: 'На основе вашей личности путешественника',
  );

  static String get yourScoreIs => getText(
    english: 'Your score is',
    spanish: 'Tu puntuación es',
    german: 'Deine Punktzahl ist',
    russian: 'Ваш результат',
  );

  static String getScoreMessage(int percentage) {
    if (percentage >= 80) {
      return getText(
        english:
            'Thailand Expert! You really know your stuff! Great job! Your answers show strong knowledge about Thailand\'s culture and travel gems.',
        spanish:
            '¡Experto en Tailandia! ¡Realmente sabes lo tuyo! ¡Buen trabajo! Tus respuestas muestran un sólido conocimiento sobre la cultura y joyas turísticas de Tailandia.',
        german:
            'Thailand-Experte! Du kennst dich wirklich aus! Großartige Arbeit! Deine Antworten zeigen umfangreiches Wissen über Thailands Kultur und Reisejuwelen.',
        russian:
            'Эксперт по Таиланду! Вы действительно знаете свое дело! Отличная работа! Ваши ответы демонстрируют глубокие знания о культуре и туристических жемчужинах Таиланда.',
      );
    } else if (percentage >= 60) {
      return getText(
        english:
            'Well done! You have good knowledge about Thailand. Keep exploring to learn more!',
        spanish:
            '¡Bien hecho! Tienes buenos conocimientos sobre Tailandia. ¡Sigue explorando para aprender más!',
        german:
            'Gut gemacht! Du hast gute Kenntnisse über Thailand. Erkunde weiter, um mehr zu lernen!',
        russian:
            'Молодец! У вас хорошие знания о Таиланде. Продолжайте исследовать, чтобы узнать больше!',
      );
    } else {
      return getText(
        english:
            'Good try! There\'s always more to discover about Thailand. Try again to improve your score!',
        spanish:
            '¡Buen intento! Siempre hay más por descubrir sobre Tailandia. ¡Inténtalo de nuevo para mejorar tu puntuación!',
        german:
            'Guter Versuch! Es gibt immer mehr über Thailand zu entdecken. Versuche es erneut, um deine Punktzahl zu verbessern!',
        russian:
            'Хорошая попытка! О Таиланде всегда есть что открыть. Попробуйте еще раз, чтобы улучшить свой результат!',
      );
    }
  }

  static String get challengeHashtags => getText(
    english:
        'Thailand Challenge — how well do you know Thailand? #AmazingThailand #TravelPersonality',
    spanish:
        'Thailand Challenge — how well do you know Thailand? #AmazingThailand #TravelPersonality',
    german:
        'Thailand Challenge — how well do you know Thailand? #AmazingThailand #TravelPersonality',
    russian:
        'Thailand Challenge — how well do you know Thailand? #AmazingThailand #TravelPersonality',
  );

  static String get backToMyResult => getText(
    english: 'Back to My Result',
    spanish: 'Volver a Mi Resultado',
    german: 'Zurück zu Meinem Ergebnis',
    russian: 'Вернуться к моему результату',
  );

  static String getChallengeCharacterSubtitle(String character) {
    switch (character) {
      case 'Mali':
        return getText(
          english: 'Chic Cat',
          spanish: 'Gato Elegante',
          german: 'Schicke Katze',
          russian: 'Шикарная кошка',
        );
      case 'Chang-Noi':
        return getText(
          english: 'Heritage Guardian',
          spanish: 'Guardián del Patrimonio',
          german: 'Erbe-Wächter',
          russian: 'Хранитель наследия',
        );
      case 'Ping':
        return getText(
          english: 'Thrill Chaser',
          spanish: 'Cazador de Emociones',
          german: 'Nervenkitzel-Jäger',
          russian: 'Охотник за острыми ощущениями',
        );
      case 'Chai':
        return getText(
          english: 'Peaceful Soul',
          spanish: 'Alma Pacífica',
          german: 'Friedliche Seele',
          russian: 'Мирная душа',
        );
      case 'Pla-Kad':
        return getText(
          english: 'Refined Traveler',
          spanish: 'Viajero Refinado',
          german: 'Raffinierter Reisender',
          russian: 'Изысканный путешественник',
        );
      default:
        return getText(
          english: 'Chic Cat',
          spanish: 'Gato Elegante',
          german: 'Schicke Katze',
          russian: 'Шикарная кошка',
        );
    }
  }

  // ============================================
  // HASHTAGS
  // ============================================
  static String get hashtags => '#MyThaiPersonality #AmazingThailand';
}
