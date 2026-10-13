// core/localization/app_localizations.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AppLocalizations {
  final Locale locale;
  late Map<String, String> _strings;
  
  AppLocalizations(this.locale);

  Future<bool> load() async {
    String data = await rootBundle.loadString(
      'lib/l10n/intl_${locale.languageCode}.arb'
    );
    Map<String, dynamic> json = Map<String, dynamic>.from(
      jsonDecode(data)
    );
    _strings = json.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String translate(String key) => _strings[key] ?? key;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _Delegate();
}

class _Delegate extends LocalizationsDelegate<AppLocalizations> {
  const _Delegate();

  @override
  bool isSupported(Locale locale) => ['en', 'am', 'om', 'ti'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localization = AppLocalizations(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
