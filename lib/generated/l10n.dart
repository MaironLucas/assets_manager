// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Tractian`
  String get appName {
    return Intl.message(
      'Tractian',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while loading the page.\n Please try again.`
  String get errorMessage {
    return Intl.message(
      'An error occurred while loading the page.\n Please try again.',
      name: 'errorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get errorTryAgainButton {
    return Intl.message(
      'Try Again',
      name: 'errorTryAgainButton',
      desc: '',
      args: [],
    );
  }

  /// `Assets`
  String get assetsPageTitle {
    return Intl.message(
      'Assets',
      name: 'assetsPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Busque ativo ou local`
  String get textFieldHint {
    return Intl.message(
      'Busque ativo ou local',
      name: 'textFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Sensor de Energia`
  String get energyFilter {
    return Intl.message(
      'Sensor de Energia',
      name: 'energyFilter',
      desc: '',
      args: [],
    );
  }

  /// `Crítico`
  String get criticalFilter {
    return Intl.message(
      'Crítico',
      name: 'criticalFilter',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
