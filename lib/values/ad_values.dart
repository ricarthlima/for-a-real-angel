import 'package:firebase_admob/firebase_admob.dart';
import 'package:for_a_real_angel_demo/helper/is_debug.dart';

class AdValues {
  static const String app = "ca-app-pub-1049717100151954~1139524725";
  static const String _banner = "ca-app-pub-1049717100151954/5071030879";
  static const String _tela = "ca-app-pub-1049717100151954/1422116827";
  static const String _premiado = "ca-app-pub-1049717100151954/5310704023";

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'game',
      'puzzle',
      'mistery',
      'jogo',
      'riddle',
      'misterio',
      'twitch',
      'stream',
      'diversão',
      'policial',
      'investigação',
      'invetigation',
      'detective',
      'police'
    ],
    childDirected: false,
    testDevices: <String>[],
  );

  String getBannerId() {
    if (isInDebugMode()) {
      return BannerAd.testAdUnitId;
    }
    return _banner;
  }

  String getTelaId() {
    if (isInDebugMode()) {
      return InterstitialAd.testAdUnitId;
    }
    return _tela;
  }

  String getPremiadoId() {
    if (isInDebugMode()) {
      return RewardedVideoAd.testAdUnitId;
    }
    return _premiado;
  }
}
