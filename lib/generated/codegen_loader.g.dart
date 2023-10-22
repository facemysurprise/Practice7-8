// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "Registration": "Registration",
    "choosename": "Choose a unique username",
    "chooseemail": "Enter your email address",
    "choosenumber": "Enter your phone",
    "choosecountry": "Select your country",
    "chooseparol": "Create password",
    "povtorenie": "Select your password",
    "choosebio": "Tell us about yourself",
  };
  static const Map<String, dynamic> kk = {
    "Registration": "Тіркелу",
    "choosename": "Бірегей пайдаланушы атын таңдаңыз",
    "chooseemail": "Электрондық пошта мекенжайын таңдаңыз",
    "choosenumber": "Телефонды енгізіңіз",
    "choosecountry": "Өз еліңізді таңдаңыз",
    "chooseparol": "Құпия сөз жасаңыз",
    "povtorenie": "Құпия сөз қайталаңыз",
    "choosebio": "Өзіңіз туралы айтыңыз",
  };
  static const Map<String, dynamic> ru = {
    "Registration": "Регистрация",
    "choosename": "Придумайте уникальное имя",
    "chooseemail": "Введите вашу почту",
    "choosenumber": "Напишите свой номер",
    "choosecountry": "Выберите свою страну",
    "chooseparol": "Придумайте пароль",
    "povtorenie": "Повторите пароль",
    "choosebio": "Расскажите немного о себе",
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "en": en,
    "kk": kk,
    "ru": ru
  };
}
