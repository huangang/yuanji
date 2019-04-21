import 'package:flutter/material.dart';

class RandImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Image.network(
      'https://api.uomg.com/api/rand.img2',
      fit: BoxFit.cover
    );
  }
}