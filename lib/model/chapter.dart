import 'package:flutter/material.dart';

class Chapter {
  final int id;
  final IconData icon;
  final String title;
  final String text;
  final String tipQuote;
  final String code;

  const Chapter(
      this.id, this.icon, this.title, this.text, this.tipQuote, this.code);

  getMe() {
    return this;
  }
}
