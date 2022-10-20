import 'package:flutter/material.dart';
import 'game_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 120.0,
            ),
            Image.network(
              'https://www.pngmart.com/files/19/Vector-Snake-PNG-File.png',
              height: 200.0,
            ),
            const SizedBox(
              height: 50.0,
            ),
            const Text(
              'Snake Game',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.overline,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const GameScreen();
                }));
              },
              child: Container(
                height: 56.0,
                width: 150.0,
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(8.0)),
                child: const Center(
                    child: Text(
                  'Start Game',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                )),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
