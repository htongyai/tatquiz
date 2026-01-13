// ============================================
// LANGUAGE CONFIGURATION
// Set debugLanguage to true to show language selector
// ============================================

// Debug flag to show/hide language selector
const bool debugLanguage = false;

enum AppLanguage { english, spanish, german, russian }

class LanguageConfig {
  static AppLanguage _currentLanguage = AppLanguage.spanish;

  static void setLanguage(AppLanguage language) {
    _currentLanguage = language;
  }

  static bool get isEnglish => _currentLanguage == AppLanguage.english;
  static bool get isSpanish => _currentLanguage == AppLanguage.spanish;
  static bool get isGerman => _currentLanguage == AppLanguage.german;
  static bool get isRussian => _currentLanguage == AppLanguage.russian;

  static AppLanguage get currentLanguage => _currentLanguage;

  static String get currentLanguageName {
    switch (_currentLanguage) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.spanish:
        return 'Spanish';
      case AppLanguage.german:
        return 'German';
      case AppLanguage.russian:
        return 'Russian';
    }
  }

  static String get languageCode {
    switch (_currentLanguage) {
      case AppLanguage.english:
        return 'EN';
      case AppLanguage.spanish:
        return 'ES';
      case AppLanguage.german:
        return 'DE';
      case AppLanguage.russian:
        return 'RU';
    }
  }
}
