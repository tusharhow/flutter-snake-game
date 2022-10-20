import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_controller.dart';


class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: GetBuilder<GameController>(
          init: GameController(),
          builder: (controller) {
            return Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (controller.direction != 'up' &&
                          details.delta.dy > 0) {
                        controller.direction = 'down';
                      } else if (controller.direction != 'down' &&
                          details.delta.dy < 0) {
                        controller.direction = 'up';
                      }
                    },
                    onHorizontalDragUpdate: (details) {
                      if (controller.direction != 'left' &&
                          details.delta.dx > 0) {
                        controller.direction = 'right';
                      } else if (controller.direction != 'right' &&
                          details.delta.dx < 0) {
                        controller.direction = 'left';
                      }
                    },
                    child: AspectRatio(
                      aspectRatio: controller.squarePerRow /
                          (controller.squarePerCol - 5),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: controller.squarePerRow,
                          ),
                          itemCount:
                              controller.squarePerRow * controller.squarePerCol,
                          itemBuilder: (BuildContext context, int index) {
                            Color? color;
                            var x = index % controller.squarePerRow;
                            var y = (index / controller.squarePerRow).floor();

                            bool isSnakeBody = false;
                            for (var pos in controller.snake) {
                              if (pos[0] == x && pos[1] == y) {
                                isSnakeBody = true;
                                break;
                              }
                            }

                            if (controller.snake.first[0] == x &&
                                controller.snake.first[1] == y) {
                              color = Colors.green;
                            } else if (isSnakeBody) {
                              color = Colors.green[200];
                            } else if (controller.food[0] == x &&
                                controller.food[1] == y) {
                              color = const Color.fromARGB(255, 252, 20, 3);
                            } else {
                              color = Colors.black45;
                            }

                            return Container(
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.rectangle,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.indigo,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              side: const BorderSide(color: Colors.white54),
                            ),
                            child: Text(
                              controller.isPlaying ? 'End' : 'Start',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            onPressed: () {
                              if (controller.isPlaying) {
                                controller.isPlaying = false;
                              } else {
                                controller.startGame(context);
                              }
                            }),
                        Text(
                          'Score: ${controller.snake.length - 2}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20.0),
                        ),
                      ],
                    )),
              ],
            );
          }),
    );
  }
}
