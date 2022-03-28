import 'dart:async';
import 'package:flutter/material.dart';
class HitWordControlPane extends StatelessWidget {
  final DirectionCallback? onDirectionChanged;

  const HitWordControlPane({Key? key, this.onDirectionChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // Direction pane.
      child: _DirectionPane(onDirectionChanged: onDirectionChanged),
    );
  }
}

/// A callback for direction changed by handler point, [directionOffsetX] and [directionOffsetY]
/// from 0 to 1 express the movement weight with which the caller can choose to control the target's velocity.
typedef DirectionCallback = void Function(double directionOffsetX, double directionOffsetY);

/// Direction pane to control the tank to move on the scene.
class _DirectionPane extends StatefulWidget {
  final DirectionCallback? onDirectionChanged;
  const _DirectionPane({Key? key, this.onDirectionChanged}) : super(key: key);

  @override
  State<_DirectionPane> createState() => _DirectionPaneState();
}

class _DirectionPaneState extends State<_DirectionPane> {
  static const double size = 80;

  /// The size of handler point in the center of the area to control the direction
  /// by gesture.
  static const double handlerSize = size / 4;
  double directionAxisX = 0;
  double directionAxisY = 0;
  late Timer directionTimer;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(size / 2)),
          color: Colors.green),
      child: GestureDetector(
        child: Container(
          width: handlerSize,
          height: handlerSize,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(handlerSize / 2)),
              color: Colors.yellow),
        ),
        onPanDown: (_) => startSendDirection(),
        onPanUpdate: startDirectionMove,
        onPanEnd: (DragEndDetails details) => restoreDirection(),
        onPanCancel: () => restoreDirection(),
      ),
      alignment: Alignment(directionAxisX, directionAxisY),
    );
  }

  void startSendDirection() {
    // Start a timer to send the direction signal if the event is down.
    Timer timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      widget.onDirectionChanged?.call(directionAxisX, directionAxisY);
    });
    directionTimer = timer;
  }

  void startDirectionMove(DragUpdateDetails details) {
    // Retrieve the new alignment parameters when handler point has been dragged.
    double tempAxisX =
        details.localPosition.dx / handlerSize;
    double tempAxisY =
        details.localPosition.dy / handlerSize;
    setState(() {
      // Update the location of handler point if the handler not move outside of area.
      if(tempAxisX.abs() <= 1.0) {
        directionAxisX = tempAxisX;
      }
      if(tempAxisY.abs() <= 1.0) {
        directionAxisY = tempAxisY;
      }
    });
  }

  void restoreDirection() {
    // debugPrint("startDirectionDown ${details.localPosition}");
    debugPrint("restoreDirection");
    // Cancel to send direction is event is end or cancel.
    directionTimer.cancel();
    setState(() {
      directionAxisX = 0.0;
      directionAxisY = 0.0;
    });
  }

}
