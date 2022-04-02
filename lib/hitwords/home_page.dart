import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kid_games/hitwords/bullet.dart';
import 'package:flutter_kid_games/hitwords/scene.dart';
import 'package:flutter_kid_games/hitwords/tank.dart';
import 'package:flutter_kid_games/common/utils.dart';
import 'control.dart';

class HitWordHomePage extends StatefulWidget {
  const HitWordHomePage({Key? key}) : super(key: key);

  @override
  State<HitWordHomePage> createState() => _HitWordHomePageState();
}

class _HitWordHomePageState extends State<HitWordHomePage>
    with TickerProviderStateMixin {

  /// A factor to control the velocity of movement.
  static const double velocityFactor = 0.03;

  double tankAxisX = 0.0,
      tankAxisY = 1;

  double bulletAxisY = 0.6;

  /// Collection of bullets stored in list.
  var bullets = <Widget>[];

  late AnimationController controller;
  late CurvedAnimation curve;

  // For generate HitWordBullet's unique key while removing from list.
  static int bulletGenerateIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
  }

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
              onFire: tankFire,
            ),
          ),
          Container(
            alignment: Alignment(tankAxisX, tankAxisY),
            child: HitWordTank(size: 60.0),
          ),
          Container(
            child: Stack(
              children: bullets,
            ),
          ),
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
    });
  }

  void tankFire() {
    setState(() {
      // Adjust an offset -0.3 prevent bullet appearing from the body of tank.
      bullets.add(HitWordBullet(key: Key("bullet_idx_${bulletGenerateIndex ++}"),axisX: tankAxisX, axisY: tankAxisY - 0.3,
       dismissingCallback: remoteBullet,));
    });
  }

  void remoteBullet(HitWordBullet widget) {
    setState(() {
      bullets.remove(widget);
    });
  }
}