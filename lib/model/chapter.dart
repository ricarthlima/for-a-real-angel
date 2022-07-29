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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tipQuote'] = this.tipQuote;
    data['code'] = this.code;
    data['id'] = this.id;
    data['text'] = this.text;
    data['title'] = this.title;
    data['badHint'] = this.badHint;
    data['goodHint'] = this.goodHint;
    data['niceHint'] = this.niceHint;
    if (this.closeTrys != null) {
      data['closeTrys'] = json.encode(data['closeTrys']);
    }
    return data;
  }
}
