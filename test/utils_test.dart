import 'package:flutter/cupertino.dart';
import 'package:flutter_kid_games/common/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("getCheckRange value return", () {
    double expectValue = 0.5;
    double result = Utils.getCheckRange(expectValue, 0.4);
    expect(result, expectValue);
  });
}