import 'package:firebase_admob/firebase_admob.dart';

class AdValues {
  static const String app = "ca-app-pub-1049717100151954~1139524725";
  static const String banner = "ca-app-pub-1049717100151954/5071030879";
  static const String tela = "ca-app-pub-1049717100151954/1422116827";
  static const String premiado = "ca-app-pub-1049717100151954/5310704023";

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['game', 'puzzle', 'mistery', 'jogo', 'riddle'],
    childDirected: false,
    testDevices: <String>[],
  );
}
