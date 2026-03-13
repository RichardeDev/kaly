import 'package:flutter/material.dart';

class LocaleHelper {

  static Locale getMaterialLocale(Locale locale) {
    
    if (locale.languageCode == 'mg') {
      return const Locale('fr');
    }
    return locale;
  }

  static bool isMaterialLocaleSupported(Locale locale) {
    const supportedMaterialLocales = [
      'fr', 'en', 'es', 'de', 'it', 'pt', 'ru', 'zh', 'ja', 'ko', 'ar',
      'nl', 'pl', 'tr', 'sv', 'da', 'fi', 'no', 'cs', 'el', 'he', 'hi',
      'hu', 'id', 'ms', 'ro', 'sk', 'th', 'uk', 'vi', 'bn', 'bg', 'hr',
      'sr', 'sl', 'et', 'lv', 'lt', 'fa', 'gu', 'is', 'ka', 'km', 'kn',
      'ky', 'lo', 'ml', 'mn', 'mr', 'my', 'ne', 'pa', 'si', 'ta', 'te',
      'uz', 'am', 'az', 'be', 'bs', 'ca', 'gl', 'ka', 'kk', 'mk', 'sq',
      'sw', 'tg', 'tk', 'ur', 'zu',
    ];
    
    return supportedMaterialLocales.contains(locale.languageCode);
  }
}