import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_victor_cauich/ball.dart';
import 'package:pong_victor_cauich/brick.dart';
import 'package:pong_victor_cauich/coverscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

enum direction {UP, DOWN} // direcciones

class _HomepageState extends State<HomePage> {

  // variables de jugador (ladrillo inferior)
  double playerX =0;
  double playerY =0;


   // variables de la pelota
   double ballX = 0;
   double ballY = 0;
   var ballDirection = direction.DOWN; // direccion inicial de la pelota

   //game settings
   bool gameHasStarted = false;

  void startGame(){
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 1), (timer){
      // actualizar direccion 
      updateDirection();

      // mover pelota
      moveBall();
    });
  }

  void updateDirection(){
    setState(() {
      if(ballY >= 0.9){
      ballDirection = direction.UP;
    }else if(ballY <= -0.9){
      ballDirection = direction.DOWN;
    } 
    });
  }

  void moveBall(){
    setState(() {
      if(ballDirection == direction.DOWN){
        ballY += 0.01;
      }else if(ballDirection == direction.UP){
        ballY -= 0.01;
      }
    });
  }

  void moveLeft(){
    setState(() {
      playerX -= 0.05;
    });
  }

  void moveRight(){
    setState(() {
      playerX += 0.05;
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
              
              // top brick
              MyBrick(
                x: 0, y: -0.9, //posicion de la barra superior
              ),
        
              // buttom brick
              MyBrick(
                x: playerX, y: 0.9, //posicion de la barra inferior
               ),
        
              //pelota
              MyBall(
                x: ballX, y: ballY // posicion de la pelota
              )
        
            ],
          ),
        )
        
        ),
      ),
    );
  }
}