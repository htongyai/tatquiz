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
// ============================================
final Map<String, List<ChallengeQuestion>> _spanishChallengeQuestions = {
  'Chang-Noi': [
    ChallengeQuestion(
      number: 1,
      question: 'Los elefantes están profundamente conectados con la historia tailandesa y solían aparecer en ceremonias reales antiguas.',
      correctAnswer: true,
      explanation: 'Los elefantes simbolizan sabiduría, fuerza y herencia real en Tailandia.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Los visitantes deben vestirse con hombros y rodillas cubiertas al entrar a los templos tailandeses.',
      correctAnswer: true,
      explanation: 'La ropa modesta muestra respeto en espacios sagrados.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Las guirnaldas de flores tailandesas (phuang malai) se utilizan comúnmente como ofrendas en los santuarios.',
      correctAnswer: true,
      explanation: 'Las guirnaldas representan respeto, bendiciones y buenas intenciones.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'La mayoría de los templos tailandeses animan a los visitantes a cantar en voz alta al entrar.',
      correctAnswer: false,
      explanation: 'Los templos son espacios tranquilos; el silencio se considera respetuoso.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'El festival Songkran originalmente comenzó como una celebración real que se realizaba solo en palacios.',
      correctAnswer: false,
      explanation: 'Comenzó como una tradición comunitaria para limpiar, renovar y dar bendiciones.',
    ),
  ],
  'Mali': [
    ChallengeQuestion(
      number: 1,
      question: 'Se cree que los gatos siameses traen buena suerte en el folclore tailandés.',
      correctAnswer: true,
      explanation: 'El "Wichian Mat" es una de las razas de gatos patrimoniales de Tailandia.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'El té de guisante de mariposa obtiene su color azul-púrpura de forma natural.',
      correctAnswer: true,
      explanation: 'Está hecho de la flor dok anchan.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Ari es un barrio de Bangkok famoso por sus cafés y lugares de estilo de vida.',
      correctAnswer: true,
      explanation: 'Es conocido por calles tranquilas y cafés creativos con estilo.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'La mayoría de los cafés boutique tailandeses están decorados completamente con luces de neón.',
      correctAnswer: false,
      explanation: 'La cultura de café tailandesa se inclina hacia el diseño artesanal, acogedor y estético.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Las antiguas casas comerciales tailandesas se construyeron originalmente con una decoración mínima para la planificación urbana moderna.',
      correctAnswer: false,
      explanation: 'Se construyeron hace mucho tiempo con texturas de madera y encanto sino-tailandés.',
    ),
  ],
  'Ping': [
    ChallengeQuestion(
      number: 1,
      question: 'Los dugongos son mamíferos marinos gentiles que se encuentran en las aguas del sur de Tailandia.',
      correctAnswer: true,
      explanation: 'Especialmente cerca de Trang y la costa de Andamán.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Una buena práctica de snorkel es evitar tocar corales y animales marinos.',
      correctAnswer: true,
      explanation: 'Incluso un ligero contacto puede dañar ecosistemas frágiles.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'El Mar de Andamán es famoso por sus aguas turquesas y acantilados de piedra caliza.',
      correctAnswer: true,
      explanation: 'Esto es lo que hace icónicos a Krabi y Phuket.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Es seguro acercarse a las tortugas marinas de cerca mientras se hace snorkel.',
      correctAnswer: false,
      explanation: 'Las tortugas necesitan espacio para respirar y comportarse naturalmente.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Koh Tao es conocida principalmente por su vida nocturna y tiene pocos sitios de buceo.',
      correctAnswer: false,
      explanation: 'Es una de las principales capitales de buceo del mundo.',
    ),
  ],
  'Chai': [
    ChallengeQuestion(
      number: 1,
      question: 'Los búfalos de agua son símbolos de la vida campestre tailandesa y las tradiciones agrícolas.',
      correctAnswer: true,
      explanation: 'Son compañeros queridos en la cultura rural.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'El norte de Tailandia es conocido por sus terrazas de arroz pacíficas.',
      correctAnswer: true,
      explanation: 'Lugares como Mae Chaem y Chiang Mai son famosos por ellas.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Una compresa de hierbas en el bienestar tailandés se usa para relajar los músculos.',
      correctAnswer: true,
      explanation: 'Está llena de hierba de limón, lima kaffir, cúrcuma y hierbas.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Moo Krata es un postre tradicional tailandés.',
      correctAnswer: false,
      explanation: 'Es la icónica combinación tailandesa de BBQ y hotpot.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'El gesto wai tailandés se usa principalmente durante eventos deportivos.',
      correctAnswer: false,
      explanation: 'Su propósito es saludar, respetar y agradecer.',
    ),
  ],
  'Pla-Kad': [
    ChallengeQuestion(
      number: 1,
      question: 'Los peces betta son admirados en Tailandia por sus colores vibrantes y aletas elegantes.',
      correctAnswer: true,
      explanation: 'Se consideran arte viviente y un símbolo cultural tailandés.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Muchos restaurantes reconocidos por Michelin en Tailandia sirven interpretaciones modernas de platos tailandeses.',
      correctAnswer: true,
      explanation: 'La alta cocina tailandesa es respetada a nivel mundial.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'La seda tailandesa es famosa por su textura y acabado brillante tejido a mano.',
      correctAnswer: true,
      explanation: 'Especialmente Jim Thompson y los tejedores de Isaan.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Las cerámicas Benjarong generalmente vienen en un solo color sólido.',
      correctAnswer: false,
      explanation: 'Benjarong es conocida por sus elaborados patrones multicolores.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'El masaje tradicional tailandés utiliza principalmente aceites en lugar de técnicas de presión.',
      correctAnswer: false,
      explanation: 'El masaje tailandés se centra en estiramientos y presión profunda.',
    ),
  ],
};

// ============================================
// GERMAN CHALLENGE QUESTIONS
// ============================================
final Map<String, List<ChallengeQuestion>> _germanChallengeQuestions = {
  'Chang-Noi': [
    ChallengeQuestion(
      number: 1,
      question: 'Elefanten sind tief mit der thailändischen Geschichte verbunden und wurden in alten königlichen Zeremonien eingesetzt.',
      correctAnswer: true,
      explanation: 'Elefanten symbolisieren Weisheit, Stärke und königliches Erbe in Thailand.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Besucher sollten beim Betreten thailändischer Tempel Kleidung mit bedeckten Schultern und Knien tragen.',
      correctAnswer: true,
      explanation: 'Bescheidene Kleidung zeigt Respekt in heiligen Räumen.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Thailändische Blumengirlanden (phuang malai) werden häufig als Opfergaben an Schreinen verwendet.',
      correctAnswer: true,
      explanation: 'Girlanden repräsentieren Respekt, Segen und gute Absichten.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Die meisten thailändischen Tempel ermutigen Besucher, beim Betreten laut zu singen.',
      correctAnswer: false,
      explanation: 'Tempel sind ruhige Räume; Stille wird als respektvoll angesehen.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Das Songkran-Festival begann ursprünglich als königliche Feier, die nur in Palästen stattfand.',
      correctAnswer: false,
      explanation: 'Es begann als Gemeinschaftstradition zum Reinigen, Erneuern und Segnen.',
    ),
  ],
  'Mali': [
    ChallengeQuestion(
      number: 1,
      question: 'Siamkatzen sollen in der thailändischen Folklore Glück bringen.',
      correctAnswer: true,
      explanation: 'Die "Wichian Mat" ist eine der traditionellen Katzenrassen Thailands.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Schmetterlingserbsen-Tee erhält seine blau-violette Farbe auf natürliche Weise.',
      correctAnswer: true,
      explanation: 'Er wird aus der Dok Anchan Blume hergestellt.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Ari ist ein Bangkoker Viertel, das für Cafés und Lifestyle-Spots berühmt ist.',
      correctAnswer: true,
      explanation: 'Es ist bekannt für ruhige Straßen und stilvolle kreative Cafés.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Die meisten thailändischen Boutique-Cafés sind komplett mit Neonlichtern dekoriert.',
      correctAnswer: false,
      explanation: 'Die thailändische Café-Kultur tendiert zu handgefertigtem, gemütlichem und ästhetischem Design.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Alte thailändische Shophouses wurden ursprünglich mit minimaler Dekoration für moderne Stadtplanung gebaut.',
      correctAnswer: false,
      explanation: 'Sie wurden vor langer Zeit mit Holztexturen und sino-thailändischem Charme gebaut.',
    ),
  ],
  'Ping': [
    ChallengeQuestion(
      number: 1,
      question: 'Dugongs sind sanfte Meeressäugetiere, die in Thailands südlichen Gewässern zu finden sind.',
      correctAnswer: true,
      explanation: 'Besonders in der Nähe von Trang und der Andamanenküste.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Eine gute Schnorchel-Praxis ist es, Korallen und Meerestiere nicht zu berühren.',
      correctAnswer: true,
      explanation: 'Selbst leichter Kontakt kann empfindliche Ökosysteme schädigen.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Die Andamanensee ist berühmt für türkisfarbenes Wasser und Kalksteinfelsen.',
      correctAnswer: true,
      explanation: 'Das macht Krabi und Phuket ikonisch.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Es ist sicher, Meeresschildkröten beim Schnorcheln nahe zu kommen.',
      correctAnswer: false,
      explanation: 'Schildkröten brauchen Raum zum Atmen und für natürliches Verhalten.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Koh Tao ist hauptsächlich für sein Nachtleben bekannt und hat nur wenige Tauchplätze.',
      correctAnswer: false,
      explanation: 'Es ist eine der wichtigsten Tauchhauptstädte der Welt.',
    ),
  ],
  'Chai': [
    ChallengeQuestion(
      number: 1,
      question: 'Wasserbüffel sind Symbole des thailändischen Landlebens und der Agrartradition.',
      correctAnswer: true,
      explanation: 'Sie sind geliebte Begleiter in der ländlichen Kultur.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Nordthailand ist bekannt für friedliche Reisterrassen.',
      correctAnswer: true,
      explanation: 'Orte wie Mae Chaem und Chiang Mai sind dafür berühmt.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Eine Kräuterkompresse im thailändischen Wellness wird verwendet, um Muskeln zu entspannen.',
      correctAnswer: true,
      explanation: 'Sie ist gefüllt mit Zitronengras, Kaffir-Limette, Kurkuma und Kräutern.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Moo Krata ist ein traditionelles thailändisches Dessert.',
      correctAnswer: false,
      explanation: 'Es ist die ikonische thailändische BBQ-Hotpot-Kombination.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Die thailändische Wai-Geste wird hauptsächlich bei Sportveranstaltungen verwendet.',
      correctAnswer: false,
      explanation: 'Ihr Zweck ist Begrüßung, Respekt und Dankbarkeit.',
    ),
  ],
  'Pla-Kad': [
    ChallengeQuestion(
      number: 1,
      question: 'Kampffische werden in Thailand für ihre lebendigen Farben und eleganten Flossen bewundert.',
      correctAnswer: true,
      explanation: 'Sie gelten als lebende Kunst und thailändisches Kultursymbol.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Viele von Michelin anerkannte Restaurants in Thailand servieren moderne Interpretationen thailändischer Gerichte.',
      correctAnswer: true,
      explanation: 'Thailändische gehobene Küche ist weltweit respektiert.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Thailändische Seide ist berühmt für ihre Textur und ihr schimmerndes handgewebtes Finish.',
      correctAnswer: true,
      explanation: 'Besonders Jim Thompson und Isaan-Weber.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Benjarong-Keramik kommt normalerweise in einer einzigen Volltonfarbe.',
      correctAnswer: false,
      explanation: 'Benjarong ist bekannt für aufwendige mehrfarbige Muster.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Traditionelle thailändische Massage verwendet hauptsächlich Öle anstelle von Drucktechniken.',
      correctAnswer: false,
      explanation: 'Thailändische Massage konzentriert sich auf Dehnung und tiefen Druck.',
    ),
  ],
};

// ============================================
// RUSSIAN CHALLENGE QUESTIONS
// ============================================
final Map<String, List<ChallengeQuestion>> _russianChallengeQuestions = {
  'Chang-Noi': [
    ChallengeQuestion(
      number: 1,
      question: 'Слоны глубоко связаны с тайской историей и участвовали в древних королевских церемониях.',
      correctAnswer: true,
      explanation: 'Слоны символизируют мудрость, силу и королевское наследие в Таиланде.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Посетители должны одеваться с покрытыми плечами и коленями при входе в тайские храмы.',
      correctAnswer: true,
      explanation: 'Скромная одежда проявляет уважение в священных местах.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Тайские цветочные гирлянды (пуанг малай) обычно используются в качестве подношений в святилищах.',
      correctAnswer: true,
      explanation: 'Гирлянды представляют уважение, благословения и добрые намерения.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Большинство тайских храмов поощряют посетителей петь вслух при входе.',
      correctAnswer: false,
      explanation: 'Храмы — это тихие места; молчание считается уважительным.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Фестиваль Сонгкран первоначально начался как королевское празднование, проводимое только во дворцах.',
      correctAnswer: false,
      explanation: 'Он начался как общинная традиция для очищения, обновления и благословений.',
    ),
  ],
  'Mali': [
    ChallengeQuestion(
      number: 1,
      question: 'Считается, что сиамские кошки приносят удачу в тайском фольклоре.',
      correctAnswer: true,
      explanation: '«Вичиан Мат» — одна из наследственных пород кошек Таиланда.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Чай из мотылькового гороха получает свой сине-фиолетовый цвет естественным образом.',
      correctAnswer: true,
      explanation: 'Он сделан из цветка док анчан.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Ари — это район Бангкока, известный кафе и местами для стильной жизни.',
      correctAnswer: true,
      explanation: 'Он известен спокойными улицами и стильными творческими кафе.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Большинство тайских бутик-кафе полностью украшены неоновыми огнями.',
      correctAnswer: false,
      explanation: 'Тайская культура кафе склоняется к ручной работе, уютному и эстетическому дизайну.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Старые тайские магазины-дома изначально были построены с минимальной отделкой для современного городского планирования.',
      correctAnswer: false,
      explanation: 'Они были построены давно с деревянными текстурами и сино-тайским шармом.',
    ),
  ],
  'Ping': [
    ChallengeQuestion(
      number: 1,
      question: 'Дюгони — это нежные морские млекопитающие, обитающие в южных водах Таиланда.',
      correctAnswer: true,
      explanation: 'Особенно возле Транга и Андаманского побережья.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Хорошая практика снорклинга — избегать прикосновения к кораллам и морским животным.',
      correctAnswer: true,
      explanation: 'Даже легкий контакт может повредить хрупкие экосистемы.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Андаманское море знаменито бирюзовыми водами и известняковыми скалами.',
      correctAnswer: true,
      explanation: 'Это делает Краби и Пхукет знаковыми.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Безопасно подходить близко к морским черепахам во время снорклинга.',
      correctAnswer: false,
      explanation: 'Черепахам нужно пространство, чтобы дышать и вести себя естественно.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Ко Тао известен в основном ночной жизнью и имеет мало мест для дайвинга.',
      correctAnswer: false,
      explanation: 'Это одна из главных дайвинг-столиц мира.',
    ),
  ],
  'Chai': [
    ChallengeQuestion(
      number: 1,
      question: 'Водяные буйволы — символы тайской сельской жизни и сельскохозяйственных традиций.',
      correctAnswer: true,
      explanation: 'Они любимые спутники в сельской культуре.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Северный Таиланд известен мирными рисовыми террасами.',
      correctAnswer: true,
      explanation: 'Места, такие как Мае Чем и Чиангмай, знамениты ими.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Травяной компресс в тайском велнесе используется для расслабления мышц.',
      correctAnswer: true,
      explanation: 'Он наполнен лемонграссом, кафрским лаймом, куркумой и травами.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Му Крата — это традиционный тайский десерт.',
      correctAnswer: false,
      explanation: 'Это знаковая тайская комбинация BBQ и горячего горшка.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Тайский жест вай в основном используется на спортивных мероприятиях.',
      correctAnswer: false,
      explanation: 'Его цель — приветствие, уважение и благодарность.',
    ),
  ],
  'Pla-Kad': [
    ChallengeQuestion(
      number: 1,
      question: 'Рыбки бетта восхищают в Таиланде своими яркими цветами и элегантными плавниками.',
      correctAnswer: true,
      explanation: 'Они считаются живым искусством и тайским культурным символом.',
    ),
    ChallengeQuestion(
      number: 2,
      question: 'Многие рестораны, признанные Мишлен в Таиланде, подают современные интерпретации тайских блюд.',
      correctAnswer: true,
      explanation: 'Тайская высокая кухня уважается во всем мире.',
    ),
    ChallengeQuestion(
      number: 3,
      question: 'Тайский шелк славится своей текстурой и мерцающей ручной отделкой.',
      correctAnswer: true,
      explanation: 'Особенно Джим Томпсон и ткачи Исаана.',
    ),
    ChallengeQuestion(
      number: 4,
      question: 'Керамика Бенджаронг обычно имеет один сплошной цвет.',
      correctAnswer: false,
      explanation: 'Бенджаронг известен сложными многоцветными узорами.',
    ),
    ChallengeQuestion(
      number: 5,
      question: 'Традиционный тайский массаж в основном использует масла вместо техник давления.',
      correctAnswer: false,
      explanation: 'Тайский массаж фокусируется на растяжке и глубоком давлении.',
    ),
  ],
};
