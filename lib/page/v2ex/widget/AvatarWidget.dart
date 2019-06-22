import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class AvatarWidget extends StatefulWidget {
  final String imageUrl;

  final VoidCallback onPress;

  final double width;
  final double height;

  AvatarWidget(
    this.imageUrl, {
    this.onPress,
    this.width = 40.0,
    this.height = 40.0,
  });

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('widget.imageUrl: ' + widget.imageUrl);
    return ClipOval(
      child: ExtendedImage.network(
          widget.imageUrl,
          fit: BoxFit.cover,
          cache: true,
          retries: 3,
          timeRetry: const Duration(milliseconds: 1000),
          timeLimit: const Duration(milliseconds: 10000),
          shape: BoxShape.circle,
          width: 40, height: 40,
          // borderRadius: BorderRadius.all(Radius.circular(20.0))
      )
    );
  }
}
