import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      icon: const Icon(
        Icons.arrow_back,
        size: 25,
        color: Colors.black,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}
