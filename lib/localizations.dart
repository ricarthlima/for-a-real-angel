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
      "Não se preocupe com acentos, caracteres especiais, espaços ou letras maiúsculas.",
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

  String get loading {
    return Intl.message(
      "Carregando",
      name: "loading",
    );
  }

  String get restore {
    return Intl.message(
      "Restaurar",
      name: "restore",
    );
  }

  String get hint {
    return Intl.message(
      "Dica",
      name: "hint",
    );
  }

  String get memoryRestored {
    return Intl.message(
      "Memória Restaurada",
      name: "memoryRestored",
    );
  }

  String get remebering {
    return Intl.message(
      "Estou me lembrando",
      name: "remebering",
    );
  }

  String get error {
    return Intl.message(
      "Erro",
      name: "error",
    );
  }

  String get incorrectRestaurationCode {
    return Intl.message(
      "Código de Restauração Incorreto!",
      name: "incorrectRestaurationCode",
    );
  }

  String get noDataPoints {
    return Intl.message(
      "Eu não tenho Pontos de Dados suficientes para te ajudar.",
      name: "noDataPoints",
    );
  }

  String get recycleBin {
    return Intl.message(
      "Lixeira\n",
      name: "recycleBin",
    );
  }

  String get dataPoints {
    return Intl.message(
      "Pontos de Dados",
      name: "dataPoints",
    );
  }

  String get youHave {
    return Intl.message(
      "Você tem",
      name: "youHave",
    );
  }

  String get dataPointsExplanation {
    return Intl.message(
      "Data Points são setores recuperados após uma desfragmentação. Você pode usar DPs para facilitar o processo de restauração dos dados. Eles também contam para seu ranking.",
      name: "dataPointsExplanation",
    );
  }

  String get okay {
    return Intl.message(
      "OK",
      name: "okay",
    );
  }

  String get betaDisclaimer {
    return Intl.message(
      "Aviso de versão Beta",
      name: "betaDisclaimer",
    );
  }

  String get betaDisclaimerText {
    return Intl.message(
      "Se você está vendo esse aviso, você está jogando uma versão beta de FARA. Como o jogo está em construção você pode se deparar com erros ou bugs. Esses podem influenciar na sua experiência.\n\nSe achar algo de errado, me avisa: playfaragame@gmail.com.",
      name: "betaDisclaimerText",
    );
  }

  String get documents {
    return Intl.message(
      "Documentos",
      name: "documents",
    );
  }

  String get update {
    return Intl.message(
      "Atualizar",
      name: "update",
    );
  }

  String get notSignUp {
    return Intl.message(
      "Você ainda não se cadastrou.",
      name: "notSignUp",
    );
  }

  String get putUsername {
    return Intl.message(
      "Insira seu nickname",
      name: "putUsername",
    );
  }

  String get usernameDisclaimer {
    return Intl.message(
      "Pense bem, esse nickname não pode ser alterado.",
      name: "usernameDisclaimer",
    );
  }

  String get signUp {
    return Intl.message(
      "Cadastrar",
      name: "signUp",
    );
  }

  String get usernameTaked {
    return Intl.message(
      "Nome de usuário em uso.",
      name: "usernameTaked",
    );
  }

  String get notRecognizedCommand {
    return Intl.message(
      "não foi reconhecido como um comando do terminal.",
      name: "notRecognizedCommand",
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
