import 'package:flutter/material.dart';
import '../config/language_config.dart';

class LanguageSelector extends StatefulWidget {
  final VoidCallback onLanguageChanged;

  const LanguageSelector({super.key, required this.onLanguageChanged});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLanguageButton(AppLanguage.english, 'EN'),
          const SizedBox(width: 6),
          _buildLanguageButton(AppLanguage.spanish, 'ES'),
          const SizedBox(width: 6),
          _buildLanguageButton(AppLanguage.german, 'DE'),
          const SizedBox(width: 6),
          _buildLanguageButton(AppLanguage.russian, 'RU'),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(AppLanguage language, String code) {
    final isSelected = LanguageConfig.currentLanguage == language;

    return GestureDetector(
      onTap: () {
        setState(() {
          LanguageConfig.setLanguage(language);
        });
        widget.onLanguageChanged();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E4A7A) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E4A7A) : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          code,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey.shade600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
