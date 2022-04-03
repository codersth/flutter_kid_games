import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_kid_games/hitwords/word.dart';

class WordsGenerator extends StatefulWidget {

  // For generate HitWordBullet's unique key while removing from list.
  static int wordGenerateIndex = 1;
  final isStarted;
  final wordGenerationInterval;
  final wordFallDownDuration;

  const WordsGenerator(
      {Key? key, required this.isStarted, this.wordGenerationInterval = const Duration(
          milliseconds: 1000), this.wordFallDownDuration = const Duration(
          milliseconds: 1000)}) : super(key: key);

  @override
  State<WordsGenerator> createState() => _WordsGeneratorState();
}

class _WordsGeneratorState extends State<WordsGenerator> {

  var data = ["中", "国", "加", "油",];
  Random r = Random();
  var words = <Widget>[];
  Timer? generatorTimer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: words,
    );
  }

  @override
  void didUpdateWidget(covariant WordsGenerator oldWidget) {
    if (widget.isStarted) {
      scheduleGenerateWord();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    generatorTimer?.cancel();
    super.dispose();
  }

  void scheduleGenerateWord() {
    if(generatorTimer !=null && generatorTimer!.isActive) {
      generatorTimer!.cancel();
    }
    generatorTimer = Timer.periodic(widget.wordGenerationInterval, (timer) {
      setState(() {
        words.add(generateWord());
      });
    });
  }

  Widget generateWord() {
    String word = data[r.nextInt(data.length)];
    return Word(key: Key("word_idx_${WordsGenerator.wordGenerateIndex ++}"), text: word, axisX: -1 + r.nextDouble() * 2, axisY: -1, duration: widget.wordFallDownDuration,
    dismissingCallback: removeWord,);
  }

  void removeWord(Word word) {
    setState(() {
      words.remove(word);
    });
  }
}
