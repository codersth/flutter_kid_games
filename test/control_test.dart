import 'package:flutter/cupertino.dart';
import 'package:flutter_kid_games/hitwords/control.dart';
import 'package:flutter_kid_games/hitwords/tank.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  // testWidgets("test control layout", (WidgetTester tester) async {
  //   await tester.pumpWidget(const HitWordControlPane());
  //   const testKey = Key("DirectionPane");
  //   Finder directionPaneFinder = find.byKey(testKey);
  //   expect(directionPaneFinder, findsOneWidget);
  //   print(tester.getRect(directionPaneFinder));
  //   var handlerPointFinder = find.byType(GestureDetector);
  //   expect(handlerPointFinder, findsOneWidget);
  //   var w = tester.widget(handlerPointFinder);
  //   await tester.drag(handlerPointFinder, const Offset(10, 10));
  //   await tester.pump();
  //   print(tester.getRect(handlerPointFinder));
  // });

  testWidgets("test control fire layout", (WidgetTester tester) async {
    Finder fireFinder = find.byKey(HitWordControlPane.fireKey);
    await tester.pumpWidget(HitWordControlPane(
      onFire: () => {
        debugPrint("onFire clicked.")
      },
    ));
    await tester.pumpWidget(tester.widget(fireFinder));
    expect(find.byType(GestureDetector), findsOneWidget);
    // await tester.tap(find.byType(GestureDetector));
    await tester.longPress(find.byType(GestureDetector),);

    await tester.pump();
  });

}