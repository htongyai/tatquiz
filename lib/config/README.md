# Language Configuration

This app supports 4 languages: **English**, **Spanish**, **German**, and **Russian**.

## Debug Language Selector

A language selector UI is available for testing. To enable/disable it:

### Enable Language Selector (for testing)
In `lib/config/language_config.dart`, set:
```dart
const bool debugLanguage = true;
```

This will show a white language selector button (EN, ES, DE, RU) in the top-right corner of the start and intro screens.

### Disable Language Selector (for production)
Set:
```dart
const bool debugLanguage = false;
```

## Setting Default Language

To set the default language when the app starts, change this line in `lib/config/language_config.dart`:

```dart
static AppLanguage _currentLanguage = AppLanguage.spanish;
```

Available options:
- `AppLanguage.english` - English (EN)
- `AppLanguage.spanish` - Spanish (ES)
- `AppLanguage.german` - German (DE)
- `AppLanguage.russian` - Russian (RU)

## How It Works

The language system dynamically switches all UI text and quiz questions based on the selected language. The selector persists throughout the app session and can be changed at any time when `debugLanguage = true`.

## Adding New Languages

1. Add the new language enum to `language_config.dart`
2. Add translations to `app_localizations.dart`
3. Add quiz questions to `quiz_data.dart`
4. Update the language selector widget to include the new option

## Supported Languages

- 🇬🇧 **English** - Complete
- 🇪🇸 **Spanish** - Complete
- 🇩🇪 **German** - UI complete, quiz pending CSV
- 🇷🇺 **Russian** - Complete
