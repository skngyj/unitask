import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: .min,
        children: [
          Icon(LucideIcons.graduationCap, size: 50),
          Container(width: 100, height: 100, color: Colors.red),
        ],
      ),
    );
  }
}
