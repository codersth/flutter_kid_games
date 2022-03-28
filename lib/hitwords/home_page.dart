import 'package:flutter/material.dart';
import 'package:flutter_kid_games/hitwords/scene.dart';
import 'package:flutter_kid_games/hitwords/tank.dart';
import 'package:flutter_kid_games/common/utils.dart';
import 'control.dart';

class HitWordHomePage extends StatefulWidget {
  const HitWordHomePage({Key? key}) : super(key: key);

  @override
  State<HitWordHomePage> createState() => _HitWordHomePageState();
}

class _HitWordHomePageState extends State<HitWordHomePage> {

  /// A factor to control the velocity of movement.
  static const double velocityFactor = 0.03;

  double tankAxisX = 0.0, tankAxisY = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          HitWordScene(),
          Container(
            alignment: Alignment(-1, 1),
            child: HitWordControlPane(
              onDirectionChanged: (x, y) => moveTank(x, y),
            ),
          ),
          Container(
            alignment: Alignment(tankAxisX, tankAxisY),
            child: HitWordTank(size: 60.0),
          )
        ],
      ),
    );
  }

  void moveTank(x, y) {
    setState(() {
      double deltaX = x * velocityFactor;
      double deltaY = y * velocityFactor;
      tankAxisX = Utils.getCheckRange(tankAxisX, tankAxisX + deltaX);
      tankAxisY = Utils.getCheckRange(tankAxisY, tankAxisY + deltaY);
      debugPrint("============= $tankAxisX $tankAxisY");
    });
  }
}
