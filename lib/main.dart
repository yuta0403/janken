import 'dart:math';
//Random is a generator of bool, int or double values.
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'あっち向いてほいアプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'あっち向いてほいアプリ'),
    );
  }
}

//複数の定数を一つのクラスとしてまとめておく
enum Hand {
  up,
  down,
  right,
  left;

//定数の書き換えで文字を置き換える
  String get text {
    switch (this) {
      case Hand.up:
        return '👆';
      case Hand.down:
        return '👇';
      case Hand.right:
        return '👉';
      case Hand.left:
        return '👈';
    }
  }
}

//あっち向いてほいの結果を定義し、それを文字に置き換える
enum Result {
  lose,
  draw;

  String get text {
    switch (this) {
      case Result.lose:
        return '負け';
      case Result.draw:
        return 'もう１度';
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

//デフォルトで数値が入っていないので、Null許容の?を入れたHand型に
class _HomePageState extends State<HomePage> {
  Hand? myHand;
  Hand? computerHand;
  Result? result;

// computerHandの動き
  void chooseComputerText() {
    final random = Random();
    final randomNumber = random.nextInt(4);
    final hand = Hand.values[randomNumber];
    setState(() {
      computerHand = hand;
    });
    decideResult();
  }

// 三項演算子,resultはmyHandとcomputerHandが同じ方向だった場合loseになる
  void decideResult() => setState(() {
        result = (myHand == computerHand) ? Result.lose : Result.draw;
      });

//Textの部分で、初期値が?になるように記載
//result変数をnull許容にしているため、何も勝敗が出てない時は、nullになる
//result?.text ?? '?'、computerHandに値が入ったら?が表示されなくなる
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '相手️',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              computerHand?.text ?? '?',
              style: const TextStyle(fontSize: 100),
            ),
            const SizedBox(
              height: 80,
            ),
            Text(
              result?.text ?? '?',
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 80,
            ),
            Text(
              myHand?.text ?? '?',
              style: const TextStyle(fontSize: 200),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myHand = Hand.up;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '👆',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myHand = Hand.down;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '👇',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myHand = Hand.right;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '👉',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myHand = Hand.right;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '👈',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
