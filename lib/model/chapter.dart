import 'dart:convert';

class AndrewChapter {
  String? tipQuote;
  String? code;
  int? id;
  String? text;
  String? title;
  String? badHint;
  String? goodHint;
  String? niceHint;
  Map<String, dynamic>? closeTrys;

  AndrewChapter(
      {this.tipQuote,
      this.code,
      this.id,
      this.text,
      this.title,
      this.badHint,
      this.goodHint,
      this.niceHint,
      this.closeTrys});

  AndrewChapter.fromJson(Map<String, dynamic> data) {
    tipQuote = data['tipQuote'];
    code = data['code'];
    id = data['id'];
    text = data['text'];
    title = data['title'];
    badHint = data['badHint'];
    goodHint = data['goodHint'];
    niceHint = data['niceHint'];
    closeTrys = data['closeTrys'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['tipQuote'] = tipQuote;
    data['code'] = code;
    data['id'] = id;
    data['text'] = text;
    data['title'] = title;
    data['badHint'] = badHint;
    data['goodHint'] = goodHint;
    data['niceHint'] = niceHint;
    if (closeTrys != null) {
      data['closeTrys'] = json.encode(data['closeTrys']);
    }
    return data;
  }
}
