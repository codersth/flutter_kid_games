
import 'package:flutter/material.dart';
class HitWordControlPane extends StatelessWidget {
  final DirectionCallback? onDirectionChanged;

  const HitWordControlPane({Key? key, this.onDirectionChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // Direction pane.
      child: DirectionPane(),
    );
  }
}

typedef DirectionCallback = void Function(Direction direction);

enum Direction {
  left,
  up,
  right,
  down
}

/**
 * Direction pane to control the tank to move on the scene.
 */
class DirectionPane extends StatefulWidget {
  const DirectionPane({Key? key}) : super(key: key);

  @override
  State<DirectionPane> createState() => _DirectionPaneState();
}

class _DirectionPaneState extends State<DirectionPane> {
  static const double size = 80;

  /// The size of handler point in the center of the area to control the direction
  /// by gesture.
  static const double handlerSize = size / 4;
  double directionAxisX = 0;
  double directionAxisY = 0;
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
        onPanDown: restoreDirection,
        onPanUpdate: startDirectionMove,
        onPanEnd: (DragEndDetails details) => restoreDirection(null),
        onPanCancel: () => restoreDirection(null),
      ),
      alignment: Alignment(directionAxisX, directionAxisY),
    );
  }

  void restoreDirection(DragDownDetails? details) {
    // debugPrint("startDirectionDown ${details.localPosition}");
    debugPrint("restoreDirection");
    setState(() {
      directionAxisX = 0.0;
      directionAxisY = 0.0;
    });
  }

  void startDirectionMove(DragUpdateDetails details) {
    debugPrint(
        "startDirectionMove ${details.localPosition.dx} ${details.localPosition.dy}");
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
}
