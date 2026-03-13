import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: context.locale.languageCode,
        icon: const Icon(Icons.language),
        onChanged: (String? newValue) {
          if (newValue != null) {
            context.setLocale(Locale(newValue));
          }
        },
        items: const [
          DropdownMenuItem(value: 'fr', child: Text('🇫🇷 Français')),
          DropdownMenuItem(value: 'en', child: Text('🇬🇧 English')),
          DropdownMenuItem(value: 'mg', child: Text('🇲🇬 Malagasy')),
        ],
      ),
    );
  }
}