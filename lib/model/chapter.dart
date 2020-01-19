import 'package:flutter/material.dart';

class Chapter {
  final int id;
  final IconData icon;
  final String title;
  final String text;
  final String tipQuote;
  final String code;
  final String goodHint;
  final Map<String, dynamic> closeTrys;

  const Chapter(this.id, this.icon, this.title, this.text, this.tipQuote,
      this.code, this.goodHint, this.closeTrys);

  Chapter.fromData({
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
