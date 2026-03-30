import 'package:flutter/material.dart';

class NatureScaffold extends StatelessWidget {
  const NatureScaffold({
    super.key,
    required this.imageUrl,
    required this.child,
    required this.overlayColors,
  });

  final String imageUrl;
  final Widget child;
  final List<Color> overlayColors;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: overlayColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}
