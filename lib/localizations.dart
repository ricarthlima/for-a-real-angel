import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title {
    return Intl.message(
      'F(or) A Real Angel',
      name: 'title',
      desc: 'The application title',
    );
  }

  String get starterHints {
    return Intl.message(
      "Dicas sobre F(or) A Real Angel",
      name: "starterHints",
    );
  }

  String get starterHintGiveUp {
    return Intl.message(
      "Se você desiste fácil, FARA não é um jogo para você.",
      name: "starterHintGiveUp",
    );
  }

  String get starterHintSounds {
    return Intl.message(
      "Os sons são importantes em FARA. Se possível, jogue com fones de ouvido.",
      name: "starterHintSounds",
    );
  }

  String get starterHintInfos {
    return Intl.message(
      "Você está lidando com arquivos e informações secretas, sigilosas e criptografadas. Nada é o que parece, use todas as ferramentas para manipular os arquivos investigados.",
      name: "starterHintInfos",
    );
  }

  String get starterHintTools {
    return Intl.message(
      "Use todas as informações possíveis para resolver os enigmas. Não hesite em pesquisar e aprender sobre algum assunto novo.",
      name: "starterHintTools",
    );
  }

  String get starterHintCaps {
    return Intl.message(
      "As respostas devem sempre ser dadas na sua língua. Não se preocupe com acentos, caracteres especiais, espaços ou letras maiúsculas.",
      name: "starterHintCaps",
    );
  }

  String get starterHintCheckbox {
    return Intl.message(
      "Entendi, não mostrar novamente.",
      name: "starterHintCheckbox",
    );
  }

  String get continuar {
    return Intl.message(
      "Continuar.",
      name: "continuar",
    );
  }

  String get episode {
    return Intl.message(
      "Episódio",
      name: "episode",
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pt'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
