import 'package:flutter/material.dart';

enum AppPage { login, signup }

extension AppPageExtension on AppPage {
  String get path => '/$name';
}
