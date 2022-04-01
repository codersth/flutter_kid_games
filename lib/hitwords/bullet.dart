import 'package:flutter/material.dart';

class HitWordBullet extends StatefulWidget {
  final double size, axisX, axisY;

  /// Duration of the bullet's movement from the start point the destination.
  final Duration duration;
  final bool isHit;
  final LocationChangedCallback? locationChangedCallback;
  final DismissingCallback? dismissingCallback;

  const HitWordBullet({Key? key,
    this.size = 60,
    required this.axisX,
    required this.axisY,
    this.duration = const Duration(milliseconds: 800),
    this.locationChangedCallback,
    this.dismissingCallback,
    this.isHit = false})
      : super(key: key);

  @override
  State<HitWordBullet> createState() => _HitWordBulletState();
}

/// Callback when bullet's location changed.The position is the bullet's latest alignment of y-axis.
typedef LocationChangedCallback = void Function(
    HitWordBullet bullet, double position);

/// Callback when bullet to be dismissed by moving out of the screen.
typedef DismissingCallback = Function(HitWordBullet bullet);

class _HitWordBulletState extends State<HitWordBullet>
    with SingleTickerProviderStateMixin {
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
        // Update bullet's location with the changed animated value. User -1.2 rather than -1.0
        // so that the bullet disappeared when completely out of range.
        _axisY = widget.axisY + (-1.2 - widget.axisY) * _controller.value;
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
          child: Image.asset("lib/images/ic_default_bullet.png")),
    );
  }

  @override
  void didUpdateWidget(covariant HitWordBullet oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
