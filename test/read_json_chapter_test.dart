import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Ler o json', () async {
    String chapters =
        await rootBundle.loadString("assets/chapters_json/pt_andrew.json");
    Map map = jsonDecode(chapters);
    print(map["09"].toString());
    expect(map["09"]["code"], "south");
  });
}
