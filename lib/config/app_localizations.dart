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
    english: 'Others',
    spanish: 'Otros',
    german: 'Andere',
    russian: 'Другие',
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
          english: 'the Jumbo Elephant',
          spanish: 'el Elefante Jumbo',
          german: 'der Jumbo-Elefant',
          russian: 'слон-гигант',
        );
      case 'Ping':
        return getText(
          english: 'the Playful Dugong',
          spanish: 'el Dugongo Juguetón',
          german: 'der Verspielte Dugong',
          russian: 'игривый дюгонь',
        );
      case 'Chai':
        return getText(
          english: 'the Chilled Buffalo',
          spanish: 'el Búfalo Relajado',
          german: 'der Entspannte Büffel',
          russian: 'спокойный буйвол',
        );
      case 'Pla-Kad':
        return getText(
          english: 'the Elegant Betta Fish',
          spanish: 'el Pez Betta Elegante',
          german: 'der Elegante Kampffisch',
          russian: 'элегантная рыбка бетта',
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
  // HASHTAGS
  // ============================================
  static String get hashtags => getText(
    english: '#MyThaiPersonality #AmazingThailand',
    spanish: '#MiPersonalidadTailandesa #TailandiaIncreíble',
    german: '#MeineThaiPersönlichkeit #ErstaunlichesThailand',
    russian: '#МояТайскаяЛичность #УдивительныйТаиланд',
  );

  // ============================================
  // CHALLENGE SCREENS
  // ============================================
  static String get howWellDoYouKnowThailand => getText(
    english: 'How Well Do You Know Thailand?',
    spanish: '¿Qué tan bien conoces Tailandia?',
    german: 'Wie gut kennst du Thailand?',
    russian: 'Насколько хорошо вы знаете Таиланд?',
  );

  static String get testYourThailandKnowledge => getText(
    english:
        'Test your Thailand knowledge with fun True - False questions and complete the challenge for a chance to win special gifts.',
    spanish:
        'Pon a prueba tus conocimientos sobre Tailandia con divertidas preguntas de Verdadero - Falso y completa el desafío para tener la oportunidad de ganar regalos especiales.',
    german:
        'Teste dein Thailand-Wissen mit lustigen Wahr-Falsch-Fragen und schließe die Herausforderung ab, um die Chance auf besondere Geschenke zu erhalten.',
    russian:
        'Проверьте свои знания о Таиланде с помощью веселых вопросов «Правда - Ложь» и выполните задание, чтобы получить шанс выиграть специальные подарки.',
  );

  static String get startChallenge => getText(
    english: 'Start Challenge',
    spanish: 'Iniciar Desafío',
    german: 'Herausforderung Starten',
    russian: 'Начать Задание',
  );

  static String get trueAnswer => getText(
    english: 'True',
    spanish: 'Verdadero',
    german: 'Wahr',
    russian: 'Правда',
  );

  static String get falseAnswer => getText(
    english: 'False',
    spanish: 'Falso',
    german: 'Falsch',
    russian: 'Ложь',
  );

  static String get basedOnYourTravelPersonality => getText(
    english: 'Based on your travel personality',
    spanish: 'Basado en tu personalidad viajera',
    german: 'Basierend auf deiner Reisepersönlichkeit',
    russian: 'Основано на вашей туристической личности',
  );

  static String get yourScoreIs => getText(
    english: 'Your score is',
    spanish: 'Tu puntuación es',
    german: 'Deine Punktzahl ist',
    russian: 'Ваш результат',
  );

  static String get backToMyResult => getText(
    english: 'Back to My Result',
    spanish: 'Volver a Mi Resultado',
    german: 'Zurück zu Meinem Ergebnis',
    russian: 'Вернуться к Моему Результату',
  );

  static String get thailandExpertMessage => getText(
    english:
        'Thailand Expert! You really know your stuff! Great job! Your answers show strong knowledge about Thailand\'s culture and travel gems.',
    spanish:
        '¡Experto en Tailandia! ¡Realmente sabes de lo que hablas! ¡Gran trabajo! Tus respuestas muestran un sólido conocimiento sobre la cultura y las joyas turísticas de Tailandia.',
    german:
        'Thailand-Experte! Du kennst dich wirklich aus! Großartige Arbeit! Deine Antworten zeigen fundiertes Wissen über Thailands Kultur und Reiseschätze.',
    russian:
        'Эксперт по Таиланду! Вы действительно разбираетесь в этом! Отличная работа! Ваши ответы показывают глубокие знания о культуре и туристических жемчужинах Таиланда.',
  );

  static String get goodKnowledgeMessage => getText(
    english:
        'Well done! You have good knowledge about Thailand. Keep exploring to learn more!',
    spanish:
        '¡Bien hecho! Tienes buenos conocimientos sobre Tailandia. ¡Sigue explorando para aprender más!',
    german:
        'Gut gemacht! Du hast gutes Wissen über Thailand. Erkunde weiter, um mehr zu erfahren!',
    russian:
        'Отлично! У вас хорошие знания о Таиланде. Продолжайте изучать, чтобы узнать больше!',
  );

  static String get goodTryMessage => getText(
    english:
        'Good try! There\'s always more to discover about Thailand. Try again to improve your score!',
    spanish:
        '¡Buen intento! Siempre hay más por descubrir sobre Tailandia. ¡Intenta de nuevo para mejorar tu puntuación!',
    german:
        'Guter Versuch! Es gibt immer mehr über Thailand zu entdecken. Versuche es erneut, um deine Punktzahl zu verbessern!',
    russian:
        'Хорошая попытка! О Таиланде всегда есть что узнать. Попробуйте еще раз, чтобы улучшить свой результат!',
  );

  static String get challengeHashtags => getText(
    english:
        'Thailand Challenge — how well do you know Thailand? #AmazingThailand #TravelPersonality',
    spanish:
        'Desafío Tailandia — ¿qué tan bien conoces Tailandia? #TailandiaIncreíble #PersonalidadViajera',
    german:
        'Thailand-Herausforderung — wie gut kennst du Thailand? #ErstaunlichesThailand #Reisepersönlichkeit',
    russian:
        'Тайское Задание — насколько хорошо вы знаете Таиланд? #УдивительныйТаиланд #ТуристическаяЛичность',
  );

  static String get greatJob => getText(
    english: 'Great job!',
    spanish: '¡Gran trabajo!',
    german: 'Großartig!',
    russian: 'Отлично!',
  );

  static String get notQuiteButKeepGoing => getText(
    english: 'Not quite! But keep going!',
    spanish: '¡No del todo! ¡Pero sigue adelante!',
    german: 'Nicht ganz! Aber mach weiter!',
    russian: 'Не совсем! Но продолжай!',
  );

  static String get next => getText(
    english: 'Next',
    spanish: 'Siguiente',
    german: 'Weiter',
    russian: 'Далее',
  );
}
