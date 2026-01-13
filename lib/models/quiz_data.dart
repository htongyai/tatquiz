import '../config/language_config.dart';

class QuizQuestion {
  final int number;
  final String question;
  final Map<String, String> options;

  QuizQuestion({
    required this.number,
    required this.question,
    required this.options,
  });
}

class CharacterProfile {
  final String name;
  final String title;
  final String emoji;
  final String description;
  final List<String> activities;
  final String backgroundColor;

  CharacterProfile({
    required this.name,
    required this.title,
    required this.emoji,
    required this.description,
    required this.activities,
    required this.backgroundColor,
  });
}

// Get quiz questions based on current language
List<QuizQuestion> get quizQuestions {
  if (LanguageConfig.isRussian) return _russianQuestions;
  if (LanguageConfig.isSpanish) return _spanishQuestions;
  if (LanguageConfig.isGerman) return _germanQuestions;
  return _englishQuestions;
}

// Russian Questions
final List<QuizQuestion> _russianQuestions = [
  QuizQuestion(
    number: 1,
    question: '1. Посадка: Выберите атмосферу вашего купе?',
    options: {
      'Chang-Noi': 'Винтажное дерево с местным колоритом',
      'Mali': 'Минималистичное купе с естественным светом',
      'Ping': 'Вагон под открытым небом с ветерком',
      'Chai': 'Тихий уголок с теплым освещением',
      'Pla-Kad': 'Золотые акценты и плюшевые сиденья',
    },
  ),
  QuizQuestion(
    number: 2,
    question: '2. Что вы заказываете в вагоне-ресторане?',
    options: {
      'Chang-Noi': 'Традиционное тайское карри с рисом',
      'Mali': 'Холодная газировка и снеки',
      'Ping': 'Попробую что-нибудь новенькое',
      'Chai': 'Классическое тайское блюдо для уюта',
      'Pla-Kad': 'Фирменное меню от шеф-повара',
    },
  ),
  QuizQuestion(
    number: 3,
    question: '3. Вид за вашим окном?',
    options: {
      'Chang-Noi': 'Туманные горы',
      'Mali': 'Немного всего',
      'Ping': 'Бирюзовое побережье',
      'Chai': 'Бескрайние рисовые поля',
      'Pla-Kad': 'Сверкающий городской пейзаж',
    },
  ),
  QuizQuestion(
    number: 4,
    question: '4. Ваш саундтрек для путешествия?',
    options: {
      'Chang-Noi': 'Традиционные инструменты',
      'Mali': 'Бодрый городской инди',
      'Ping': 'Шум океанских волн',
      'Chai': 'Атмосфера природы',
      'Pla-Kad': 'Джаз и лоу-фай',
    },
  ),
  QuizQuestion(
    number: 5,
    question: '5. Настигла жажда: Какой напиток подойдет?',
    options: {
      'Chang-Noi': 'Тайский чай со льдом',
      'Mali': 'Качественный айс-латте или крафтовый напиток.',
      'Ping': 'Все, что я никогда не пробовал.',
      'Chai': 'Простая вода или теплый чай для баланса.',
      'Pla-Kad': 'Премиальная газировка или игристый напиток.',
    },
  ),
  QuizQuestion(
    number: 6,
    question: '6. Остановка на маленькой станции: Что вы делаете первым делом?',
    options: {
      'Chang-Noi': 'Посетить небольшой храм или святыню.',
      'Mali': 'Сфотографироваться с вывеской станции.',
      'Ping': 'Попробовать местный снек, например Khao Niao Ping.',
      'Chai': 'Сесть в тень и насладиться спокойствием.',
      'Pla-Kad': 'Найти уютное кафе с хорошими напитками.',
    },
  ),
  QuizQuestion(
    number: 7,
    question: '7. Неожиданный объезд — ваша реакция?',
    options: {
      'Chang-Noi': 'Исследовать окрестности',
      'Mali': 'Сделать фотографии платформы.',
      'Ping': 'Отправиться в быстрое мини-приключение.',
      'Chai': 'Сидеть тихо и наслаждаться моментом.',
      'Pla-Kad': 'Устроиться поуютнее в поезде.',
    },
  ),
  QuizQuestion(
    number: 8,
    question: '8. Сувенир: Что вы везете домой?',
    options: {
      'Chang-Noi': 'Самодельное местное ремесленное изделие.',
      'Mali': 'Фотография',
      'Ping': 'Местное спасательное судно',
      'Chai': 'Хорошая история',
      'Pla-Kad': 'Кусок элегантного тайского шелка.',
    },
  ),
  QuizQuestion(
    number: 9,
    question: '9. Наступает ночь — что вы делаете?',
    options: {
      'Chang-Noi': 'Общаться с попутчиками',
      'Mali': 'Сделать кадр со звездами',
      'Ping': 'Искать силуэты гор',
      'Chai': 'Найти тихий уголок',
      'Pla-Kad': 'Заказать вино и наслаждаться ночным небом за окном',
    },
  ),
  QuizQuestion(
    number: 10,
    question: '10. Тихий момент в поезде: Как вы его проводите?',
    options: {
      'Chang-Noi': 'Читать или узнавать о следующей культурной остановке.',
      'Mali': 'Редактировать фото или планировать стильное кафе.',
      'Ping': 'Высматривать реки, скалы или виды побережья.',
      'Chai': 'Закрыть глаза для короткого осознанного отдыха.',
      'Pla-Kad':
          'Насладиться освежающим напитком и привести в порядок свое место.',
    },
  ),
  QuizQuestion(
    number: 11,
    question: '11. Ваш девиз для путешествий?',
    options: {
      'Chang-Noi': 'Культура прежде всего',
      'Mali': 'Путешествовать не спеша',
      'Ping': 'Искать необычное',
      'Chai': 'Плыть по течению',
      'Pla-Kad': 'Комфорт — главное',
    },
  ),
  QuizQuestion(
    number: 12,
    question: '12. План прибытия: Вы приехали. Что вы делаете первым делом?',
    options: {
      'Chang-Noi': 'Посетить культурный объект или музей.',
      'Mali': 'Отправиться в знаменитое кафе или дизайнерское место.',
      'Ping': 'Арендовать мотоцикл и исследовать окрестности.',
      'Chai': 'Совершить неспешную прогулку вдоль реки или по деревне.',
      'Pla-Kad': 'Зарегистрироваться в роскошном спа-отеле.',
    },
  ),
];

// English Questions (placeholder - will be replaced with actual English CSV)
final List<QuizQuestion> _englishQuestions = [
  QuizQuestion(
    number: 1,
    question: 'Boarding: Pick your cabin ambience?',
    options: {
      'Chang-Noi': 'Vintage wood with local vibes',
      'Mali': 'Minimal cabin with natural light',
      'Ping': 'Open-air carriage with a breeze',
      'Chai': 'Quiet corner with warm lighting',
      'Pla-Kad': 'Gold accents and plush seating',
    },
  ),
  QuizQuestion(
    number: 2,
    question: 'What do you order from the dining cabin?',
    options: {
      'Chang-Noi': 'A traditional Thai curry with rice',
      'Mali': 'Cold soda & snacks',
      'Ping': 'I\'ll try whatever\'s new',
      'Chai': 'Classic Thai comfort dish',
      'Pla-Kad': 'Signature chef\'s menu',
    },
  ),
  QuizQuestion(
    number: 3,
    question: 'View outside your window?',
    options: {
      'Chang-Noi': 'Misty mountains',
      'Mali': 'A bit of everything',
      'Ping': 'Turquoise coastline',
      'Chai': 'Endless rice fields',
      'Pla-Kad': 'Glittering cityscape',
    },
  ),
  QuizQuestion(
    number: 4,
    question: 'Your travel soundtrack?',
    options: {
      'Chang-Noi': 'Traditional instruments',
      'Mali': 'Upbeat city indie',
      'Ping': 'Ocean waves',
      'Chai': 'Nature ambience',
      'Pla-Kad': 'Jazz & lo-fi',
    },
  ),
  QuizQuestion(
    number: 5,
    question: 'Thirst Hits: What drink feels right?',
    options: {
      'Chang-Noi': 'Thai ice tea',
      'Mali': 'A quality iced latte or craft drink',
      'Ping': 'Everything I\'ve never tried',
      'Chai': 'Plain water or warm tea for balance',
      'Pla-Kad': 'A premium soda or sparkling drink',
    },
  ),
  QuizQuestion(
    number: 6,
    question: 'Small Station Stop: What do you do first?',
    options: {
      'Chang-Noi': 'Visit a small temple or shrine',
      'Mali': 'Take a photo with the station sign',
      'Ping': 'Try a local snack like Khao Niao Ping',
      'Chai': 'Sit under the shade and enjoy the calm',
      'Pla-Kad': 'Look for a cozy café with good drinks',
    },
  ),
  QuizQuestion(
    number: 7,
    question: 'Unexpected detour — your reaction?',
    options: {
      'Chang-Noi': 'Explore locals nearby',
      'Mali': 'Take photos of the platform',
      'Ping': 'Explore for a quick mini-adventure',
      'Chai': 'Sit quietly and breathe in the moment',
      'Pla-Kad': 'Stay cozy on the train',
    },
  ),
  QuizQuestion(
    number: 8,
    question: 'Souvenir: What do you take home?',
    options: {
      'Chang-Noi': 'A handmade local craft',
      'Mali': 'A photograph',
      'Ping': 'Local ocean rescue craft',
      'Chai': 'A good story',
      'Pla-Kad': 'A piece of elegant Thai silk',
    },
  ),
  QuizQuestion(
    number: 9,
    question: 'Night falls — what do you do?',
    options: {
      'Chang-Noi': 'Chat with travelers',
      'Mali': 'Capture a starry shot',
      'Ping': 'Spot silhouettes of mountains',
      'Chai': 'Find a quiet corner',
      'Pla-Kad': 'Order wine and enjoy the night sky outside',
    },
  ),
  QuizQuestion(
    number: 10,
    question: 'Quiet Moment on the Train: How do you spend it?',
    options: {
      'Chang-Noi': 'Read or learn about the next cultural stop',
      'Mali': 'Edit photos or plan a stylish cafe visit',
      'Ping': 'Watch for rivers, cliffs, or coastline views',
      'Chai': 'Close your eyes for a short, mindful rest',
      'Pla-Kad': 'Enjoy a refreshing drink and tidy your space',
    },
  ),
  QuizQuestion(
    number: 11,
    question: 'Your travel motto?',
    options: {
      'Chang-Noi': 'Culture first',
      'Mali': 'Wander slowly',
      'Ping': 'Seek the extraordinary',
      'Chai': 'Go with the flow',
      'Pla-Kad': 'Comfort is key',
    },
  ),
  QuizQuestion(
    number: 12,
    question: 'Arrival Plan: You arrive. What do you do first?',
    options: {
      'Chang-Noi': 'Visit a cultural site or museum',
      'Mali': 'Head to a famous cafe or design spot',
      'Ping': 'Rent a motorbike and explore',
      'Chai': 'Take a slow riverside or village walk',
      'Pla-Kad': 'Check in at a luxury spa hotel',
    },
  ),
];

// Spanish Questions
final List<QuizQuestion> _spanishQuestions = [
  QuizQuestion(
    number: 1,
    question: 'Embarque: Elige el ambiente de tu vagón.',
    options: {
      'Chang-Noi': 'El vagón de madera vintage con vibra locales.',
      'Mali': 'El vagón minimalista con luz natural.',
      'Ping': 'El vagón abierto al aire libre con brisa.',
      'Chai': 'El rincón tranquilo con luz cálida.',
      'Pla-Kad': 'El vagón con asientos lujosos y toques dorados.',
    },
  ),
  QuizQuestion(
    number: 2,
    question: '¿Qué pides en el vagón comedor?',
    options: {
      'Chang-Noi': 'Un curry tailandés tradicional con arroz.',
      'Mali': 'Un refresco frío y snacks.',
      'Ping': 'Probar algo nuevo.',
      'Chai': 'Un plato tailandés clásico y reconfortante.',
      'Pla-Kad': 'El plato de autor del chef.',
    },
  ),
  QuizQuestion(
    number: 3,
    question: '¿Cómo es la vista a trevés de tu ventana?',
    options: {
      'Chang-Noi': 'Las montañas entre la niebla.',
      'Mali': 'Un poco de todo.',
      'Ping': 'La costa azulada.',
      'Chai': 'Interminables campos de arroz.',
      'Pla-Kad': 'Un brillante paisaje urbano.',
    },
  ),
  QuizQuestion(
    number: 4,
    question: '¿Qué música acompaña tu viaje?',
    options: {
      'Chang-Noi': 'Música de instrumentos tradicionales',
      'Mali': 'Música indie urbana upbeat.',
      'Ping': 'Las olas del mar.',
      'Chai': 'El sonido natural.',
      'Pla-Kad': 'Jazz y lo-fi.',
    },
  ),
  QuizQuestion(
    number: 5,
    question: 'Si tienes sed, ¿qué bebida te apetece?',
    options: {
      'Chang-Noi': 'Un té helado tailandés.',
      'Mali': 'Un buen café con leche o una bebida artesanal.',
      'Ping': 'Algo que nunca he probado.',
      'Chai': 'Agua o un té caliente.',
      'Pla-Kad': 'Un refresco prémium o una bebida con gas.',
    },
  ),
  QuizQuestion(
    number: 6,
    question: 'Si haces una parada corta en una estación, ¿qué haces primero?',
    options: {
      'Chang-Noi': 'Visitar un templo o santuario.',
      'Mali': 'Hacer una foto con el cartel de la estación.',
      'Ping':
          'Probar un snack local como khao niao ping. (arroz glutinoso a la parrilla)',
      'Chai': 'Sentarme a la sombra y disfrutar de la tranquilidad.',
      'Pla-Kad': 'Buscar un café acogedor con buenas bebidas.',
    },
  ),
  QuizQuestion(
    number: 7,
    question: 'Si hay un desvío inesperado, ¿qué haces?',
    options: {
      'Chang-Noi': 'Explorar los lugares cercanos.',
      'Mali': 'Hacer fotos del andén.',
      'Ping': 'Salir rápidamente en busca de una miniaventura.',
      'Chai': 'Sentarme en silencio y disfrutar del momento.',
      'Pla-Kad': 'Acomodarme en el tren.',
    },
  ),
  QuizQuestion(
    number: 8,
    question: '¿Qué souvenir te llevas a casa?',
    options: {
      'Chang-Noi': 'Una artesanía local hecha a mano.',
      'Mali': 'Una foto.',
      'Ping': 'Un souvenir de una embarcación local de rescate marítimo.',
      'Chai': 'Una buena historia.',
      'Pla-Kad': 'Una pieza de elegante seda tailandesa.',
    },
  ),
  QuizQuestion(
    number: 9,
    question: 'Al llegar la noche, ¿qué haces?',
    options: {
      'Chang-Noi': 'Charlar con otros viajeros.',
      'Mali': 'Hacer una foto al cielo estrellado.',
      'Ping': 'Observar las siluetas de lasmontañas.',
      'Chai': 'Buscar un rincón tranquilo.',
      'Pla-Kad': 'Pedir vino y disfrutar del cielo nocturno afuera.',
    },
  ),
  QuizQuestion(
    number: 10,
    question: '¿Cómo pasas el momento de tranquilidad en el tren?',
    options: {
      'Chang-Noi': 'Leeyendo o aprendiendo sobre la próxima parada cultural.',
      'Mali': 'Editando fotos o planeando una visita a un café elegante.',
      'Ping': 'Observando las vistas de ríos, acantilados o costas.',
      'Chai': 'Cerrando los ojos para un mini descanso consciente.',
      'Pla-Kad':
          'Disfrutando de una bebida refrescante y ordenando mi espacio.',
    },
  ),
  QuizQuestion(
    number: 11,
    question: 'Elige tu lema de viaje.',
    options: {
      'Chang-Noi': 'La cultura primero.',
      'Mali': 'Vagar despacio.',
      'Ping': 'Buscar lo extraordinario.',
      'Chai': 'Dejarme llevar.',
      'Pla-Kad': 'La comodidad es clave.',
    },
  ),
  QuizQuestion(
    number: 12,
    question: 'Al llegar, ¿qué haces primero?',
    options: {
      'Chang-Noi': 'Visitar un sitio cultural o un museo.',
      'Mali': 'Dirigirme a un café famoso o un lugar de diseño.',
      'Ping': 'Alquilar una moto y recorrer el lugar.',
      'Chai': 'Pasear tranquilamente por las orillas del río o por el pueblo.',
      'Pla-Kad': 'Hacer el check-in en un hotel de lujo con spa.',
    },
  ),
];

// German Questions (placeholder - add when CSV is provided)
final List<QuizQuestion> _germanQuestions = _englishQuestions;

// Character Profiles (same for all languages)
final Map<String, CharacterProfile> characterProfiles = {
  'Chang-Noi': CharacterProfile(
    name: 'Chang-Noi',
    title: 'The Culture Keeper',
    emoji: '🐘',
    description:
        'You are a thoughtful traveler who seeks authentic cultural experiences. You love exploring temples, learning local traditions, and connecting with the heart of a destination. For you, travel is about understanding and preserving heritage.',
    activities: [
      'Temple Visits',
      'Local Markets',
      'Cultural Workshops',
      'Traditional Cuisine',
      'Historical Sites',
      'Handicraft Tours',
    ],
    backgroundColor: '8B7355',
  ),
  'Mali': CharacterProfile(
    name: 'Mali',
    title: 'The Aesthetic Explorer',
    emoji: '🌸',
    description:
        'You are a creative soul who travels with an eye for beauty and design. You love discovering Instagram-worthy spots, trendy cafes, and artistic neighborhoods. Your trips are curated experiences filled with style and visual inspiration.',
    activities: [
      'Café Hopping',
      'Photography',
      'Design Districts',
      'Street Art',
      'Boutique Shopping',
      'Rooftop Bars',
    ],
    backgroundColor: 'E89BA5',
  ),
  'Ping': CharacterProfile(
    name: 'Ping',
    title: 'The Adventure Seeker',
    emoji: '🏄',
    description:
        'You are a spontaneous adventurer who craves excitement and new experiences. You love trying everything new, from extreme sports to exotic foods. Your travel philosophy is simple: dive in headfirst and embrace the unknown.',
    activities: [
      'Water Sports',
      'Hiking',
      'Street Food',
      'Night Markets',
      'Island Hopping',
      'Local Adventures',
    ],
    backgroundColor: '5BA4CF',
  ),
  'Chai': CharacterProfile(
    name: 'Chai',
    title: 'The Mindful Wanderer',
    emoji: '🍃',
    description:
        'You are a peaceful traveler who values tranquility and meaningful moments. You prefer slow travel, natural settings, and quiet contemplation. For you, the journey is about finding balance and inner peace through gentle exploration.',
    activities: [
      'Nature Walks',
      'Meditation',
      'Yoga Retreats',
      'Riverside Cafes',
      'Sunrise Views',
      'Wellness Spas',
    ],
    backgroundColor: '8CAF88',
  ),
  'Pla-Kad': CharacterProfile(
    name: 'Pla-Kad',
    title: 'The Luxury Connoisseur',
    emoji: '🦋',
    description:
        'You are a refined traveler who appreciates the finer things in life. You seek comfort, elegance, and premium experiences. From luxury hotels to fine dining, you believe that travel should be indulgent and sophisticated.',
    activities: [
      'Fine Dining',
      'Luxury Spas',
      'Wine Tasting',
      'Designer Shopping',
      'Private Tours',
      'Premium Lounges',
    ],
    backgroundColor: 'B8A4D4',
  ),
};
