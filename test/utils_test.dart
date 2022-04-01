import 'package:flutter/cupertino.dart';
import 'package:flutter_kid_games/common/utils.dart';
import 'package:flutter_kid_games/hitwords/control.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("getCheckRange value return", () {
    double expectValue = 0.5;
    double result = Utils.getCheckRange(expectValue, 0.4);
    expect(result, expectValue);

    AAA a = AAA(callback:
    () => {

    }
    );
    HitWordControlPane(onFire: () => {

    });
  });
}

class AAA {
  final FireCallback? callback;
  AAA({this.callback}) {}
}
