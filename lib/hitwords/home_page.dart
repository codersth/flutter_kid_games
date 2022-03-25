import 'package:flutter/material.dart';
import 'package:flutter_kid_games/hitwords/scene.dart';
import 'package:flutter_kid_games/hitwords/tank.dart';

import 'control.dart';

class HitWordHomePage extends StatelessWidget {
  const HitWordHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          HitWordScene(),
          Container(
            alignment: Alignment(-1, 1),
            child: HitWordControlPane(),
          ),
          Container(
            alignment: Alignment(0, 1),
            child: HitWordTank(size: 60.0),
          )
        ],
      ),
    );
  }
}
