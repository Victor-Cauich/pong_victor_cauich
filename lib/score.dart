import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {

  final bool gameHasStarted;
  final enemyScore;
  final playerScore;

  ScoreScreen({required this.gameHasStarted, this.enemyScore, this.playerScore});

  @override
  Widget build(BuildContext context) {
    return gameHasStarted ? Stack (
      children: [
        // pnatalla de la puntuacion
              Container( // linea central de la  pantalla
                alignment: Alignment(0, 0),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width / 3,
                  color: Colors.grey[700],
                ),
              ),
              Container( //pantalla del score superior
                alignment: Alignment(0, -0.3),
                child: Text(
                  enemyScore.toString(), // mostrar el score del enemigo
                  style: TextStyle(color: Colors.grey[700], fontSize: 100),),
                ),

              Container( // pantalla del score inferior
                alignment: Alignment(0, 0.3),
                child: Text(
                  playerScore.toString(), // mostrar el score del jugador
                  style: TextStyle(color: Colors.grey[700], fontSize: 100),),
                ),
      ],
    ) : Container(); 
  }
}