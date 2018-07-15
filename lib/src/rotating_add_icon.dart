import 'package:flutter/material.dart';

class RotatingAddIcon extends AnimatedWidget {
  final IconThemeData theme;

  RotatingAddIcon({
    Key key,
    Animation<double> animation,
    this.theme,
  }) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return RotationTransition(
      turns: AlwaysStoppedAnimation((animation.value * 135.0) / 360),
      child: Icon(
        Icons.add,
        color: theme?.color,
        size: theme?.size,
      ),
    );
  }
}
