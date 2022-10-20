import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  final int squarePerRow = 20;
  final int squarePerCol = 40;
  final random = Random();

  var snake = [
    [0, 1],
    [0, 0]
  ];

  var food = [0, 2];
  var direction = "up";
  var isPlaying = false;

  void startGame(context) {
    const duration = Duration(milliseconds: 200);

    snake = [
      [(squarePerRow / 2).floor(), (squarePerCol / 2).floor()]
    ];

    snake.add([snake.first[0], snake.first[1] + 1]);
    initFood();
    isPlaying = true;
    Timer.periodic(duration, (Timer? timer) {
      moveSnake();
      if (isGameOver()) {
        timer!.cancel();
        endGame(context);
      }
    });
    update();
  }

  void moveSnake() {
    switch (direction) {
      case 'up':
        snake.insert(0, [snake.first[0], snake.first[1] - 1]);
        break;

      case 'down':
        snake.insert(0, [snake.first[0], snake.first[1] + 1]);
        break;

      case 'left':
        snake.insert(0, [snake.first[0] - 1, snake.first[1]]);
        break;

      case 'right':
        snake.insert(0, [snake.first[0] + 1, snake.first[1]]);
        break;
    }

    if (snake.first[0] != food[0] || snake.first[1] != food[1]) {
      snake.removeLast();
    } else {
      initFood();
    }
    update();
  }

  void initFood() {
    food = [random.nextInt(squarePerRow), random.nextInt(squarePerCol)];
    update();
  }

  bool isGameOver() {
    if (!isPlaying ||
        snake.first[1] < 0 ||
        snake.first[1] >= squarePerCol ||
        snake.first[0] < 0 ||
        snake.first[0] > squarePerRow) {
      return true;
    }

    for (var i = 1; i < snake.length; ++i) {
      if (snake[i][0] == snake.first[0] && snake[i][1] == snake.first[1]) {
        return true;
      }
    }
    update();
    return false;
  }

  void endGame(context) {
    isPlaying = false;
    update();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over '),
            content: Text('Score ${snake.length - 2}'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }
}
