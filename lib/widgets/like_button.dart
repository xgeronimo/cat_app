import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget icon;

  const LikeButton({super.key, required this.onPressed, required this.icon});

  @override
  LikeButtonState createState() => LikeButtonState();
}

class LikeButtonState extends State<LikeButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
        widget.onPressed();
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        transform: Matrix4.identity()
          ..translate(0.0, _isPressed ? -20.0 : 0.0)
          ..scale(_isPressed ? 1.2 : 1.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.icon,
        ),
      ),
    );
  }
}
