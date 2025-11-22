import 'package:flutter/material.dart';

class CustomLogoBox extends StatelessWidget {
  const CustomLogoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: 200,
      fit: BoxFit.contain,
    );
  }
}
