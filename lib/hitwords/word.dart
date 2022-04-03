import 'dart:math';

import 'package:flutter/material.dart';

class Word extends StatefulWidget {
  final double size, axisX, axisY;
  final String text;
  final Duration duration;
  final bool isHit;
  final LocationChangedCallback? locationChangedCallback;
  final DismissingCallback? dismissingCallback;

  const Word(
      {Key? key,
      this.size = 60,
      required this.text,
      required this.axisX,
      required this.axisY,
      required this.duration,
      this.locationChangedCallback,
      this.dismissingCallback,
      this.isHit = false})
      : super(key: key);

  @override
  State<Word> createState() => _WordState();
}

/// Callback when bullet's location changed.The position is the bullet's latest alignment of y-axis.
typedef LocationChangedCallback = void Function(Word bullet, double position);

/// Callback when bullet to be dismissed by moving out of the screen.
typedef DismissingCallback = Function(Word word);

class _WordState extends State<Word> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _axisY = 0.0;

  @override
  void initState() {
    super.initState();
    _axisY = widget.axisY;
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ).addListener(() {
      setState(() {
        // Update bullet's location with the changed animated value. The -2 just a value to ensure
        // bullet could emit out of the screen.
        _axisY = widget.axisY + 2 * _controller.value;
        // Detect if bullet out of range.
        if (1.0 == _controller.value.abs()) {
          widget.dismissingCallback?.call(widget);
        }
        widget.locationChangedCallback?.call(widget, _axisY);
      });
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(widget.axisX, _axisY),
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: Text(widget.text),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
