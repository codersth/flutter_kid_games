import 'package:flutter/material.dart';

class HitWordTank extends StatelessWidget {

  final size;
  const HitWordTank({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Image.asset("lib/images/ic_default_tank.png"),
    );
  }
}
