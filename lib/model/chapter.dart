import 'package:flutter/material.dart';

class AndrewChapter {
  final int id;
  final IconData icon;
  final String title;
  final String text;
  final String tipQuote;
  final String code;
  final String goodHint;
  final Map<String, dynamic> closeTrys;

  const AndrewChapter(this.id, this.icon, this.title, this.text, this.tipQuote,
      this.code, this.goodHint, this.closeTrys);

  AndrewChapter.fromData({
    this.id,
    this.icon,
    this.title,
    this.text,
    this.tipQuote,
    this.code,
    this.goodHint,
    this.closeTrys,
  });

  getMe() {
    return this;
  }
}
