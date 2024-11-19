import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_victor_cauich/ball.dart';
import 'package:pong_victor_cauich/brick.dart';
import 'package:pong_victor_cauich/coverscreen.dart';
import 'package:pong_victor_cauich/score.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

enum direction {UP, DOWN, LEFT, RIGHT} // direcciones

class _HomepageState extends State<HomePage> {

  // variables de jugador (ladrillo inferior)
  double playerX = -0.2;
  double brickWidth = 0.4; // out of 2
  int playerScore = 0;

  // variables del enemigo (top brick)

  double enemyX = -0.2;
  int enemyScore = 0;

   // variables de la pelota
   double ballX = 0;
   double ballY = 0;
   var ballYDirection = direction.DOWN; // direccion vertical de la pelota
   var ballXDirection = direction.LEFT; // direccion horizontal de la pelota

   //game settings
   bool gameHasStarted = false;

  void startGame(){
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 1), (timer){
      // actualizar direccion 
      updateDirection();

      // mover pelota
      moveBall();

      // mover enemigo
      moveEnemy();

      //revisar si el jugador perdio
      if(isPlayerDead()){
        enemyScore++;
        timer.cancel();
        _showDialog(false);
      }

      if(isEnemyIsDead()){
        playerScore++;
        timer.cancel();
        _showDialog(true);
      }

    });
  }

  bool isEnemyIsDead(){
    if(ballY <= -1){
      return true;
    }
    return false;
  }

  bool isPlayerDead(){
    if(ballY >= 1){
      return true;
    }
    return false;
  }

  void moveEnemy(){
    setState(() {
      enemyX = ballX;
    });
  }


  void _showDialog(bool enemyDied){ // mostrar dialogo cuando el jugador pierde
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              enemyDied ? "BLUE WIN" : "PURPLE WIN",
            style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resettGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: EdgeInsets.all(7),
                  color: enemyDied 
                  ? Colors.blue[700]
                  : Colors.deepPurple[100],
                  child: Text(
                    "PLAY AGAIN",
                    style: TextStyle(color: enemyDied 
                    ?Colors.blue[700]
                    :Colors.deepPurple[800]),
                ),
              ),
            )
          )
          ],
        );
      }
    );
  }

  void resettGame(){
    Navigator.pop(context);
    setState(() {
      gameHasStarted = false;
      ballX = 0; ballY = 0; // resetear la posicion de la pelota
      playerX = -0.2; // resetear la posicion del jugador
      enemyX = -0.2; // resetear la posicion del enemigo
    });
  }

  void updateDirection(){ // actualizar la direccion de la pelota
    setState(() {

      //actualizar direccion vertical
      if(ballY >= 0.9 && playerX + brickWidth >= ballX && playerX <= ballX){
      ballYDirection = direction.UP;
    }else if(ballY <= -0.9){
      ballYDirection = direction.DOWN;
    } 

    // actualizar direccion horizontal
    if(ballX >= 1){
      ballXDirection = direction.LEFT;
    }else if(ballX <= -1){
      ballXDirection = direction.RIGHT;
    }
    });
  }

  void moveBall(){
    setState(() {

      // movimiento vertical
      if(ballYDirection == direction.DOWN){
        ballY += 0.01;
      }else if(ballYDirection == direction.UP){
        ballY -= 0.01;
      }

      // movimiento horizontal
      if(ballXDirection == direction.LEFT){
        ballX -= 0.01;
      }else if(ballXDirection == direction.RIGHT){
        ballX += 0.01;
      }
    });
  }

  void moveLeft(){
    setState(() { // evitar que el jugador se salga de la pantalla del lado izquierdo
      if(!(playerX -0.1 <= -1)){ 
        playerX -= 0.1;
      }
      
    });
  }

  void moveRight(){
    setState(() { // evitar que el jugador se salga de la pantalla del lado derecho
      if(!(playerX + brickWidth >= 1)){
        playerX += 0.1;
      }
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event){
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
          moveLeft();

        }else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)){
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.grey[900], // fondo de la aplicación
          body: Center(
            child: Stack(
              children: [
              // tap to play
              Coverscreen(
                gameHasStarted: gameHasStarted,
              ),

              // pantalla de la puntuacion (score)
              ScoreScreen(
                gameHasStarted: gameHasStarted,
                enemyScore: enemyScore,
                playerScore: playerScore,
              ),
              
              // enemigo top brick
              MyBrick(
                x: enemyX,
                y: -0.9, //posicion de la barra superior
                brickWidth: brickWidth,
                thisIsEnemy: true,
              ),
        
              // jugador buttom brick
              MyBrick(
                x: playerX, y: 0.9, //posicion de la barra inferior
                brickWidth: brickWidth,
                thisIsEnemy: false,
               ),
        
              //pelota
              MyBall(
                x: ballX, y: ballY // posicion de la pelota
              ),
            ],
          ),
        )
        
        ),
      ),
    );
  }
}