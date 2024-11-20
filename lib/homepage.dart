import 'dart:async'; // librería para trabajar con temporizadores 
import 'package:flutter/material.dart'; // librería Flutter para diseño de interfaces.
import 'package:pong_victor_cauich/ball.dart'; // Importa el archivo ball.dart
import 'package:pong_victor_cauich/brick.dart'; // Importa el archivo brick.dart
import 'package:pong_victor_cauich/coverscreen.dart'; // Importa el archivo coverscreen.dart
import 'package:pong_victor_cauich/score.dart'; // Importa el archivo score.dart

class HomePage extends StatefulWidget { // clase Home que extiende un widget estatico
  const HomePage({super.key}); // Constructor de la clase `HomePage`.

  @override
  State<HomePage> createState() => _HomepageState(); // Crea el estado asociado a esta página.
}

enum direction { UP, DOWN, LEFT, RIGHT } // Enum para representar direcciones de movimiento.

class _HomepageState extends State<HomePage> {
  // Variables para el ladrillo del jugador (inferior).
  double playerX = -0.2; // Posición inicial del jugador.
  double brickWidth = 0.4; // Ancho del ladrillo
  int playerScore = 0; // Puntuación del jugador.

  // Variables para el ladrillo enemigo (superior).
  double enemyX = -0.2; // Posición inicial del enemigo.
  int enemyScore = 0; // Puntuación del enemigo.

  // Variables de la pelota.
  double ballX = 0; // Posición horizontal inicial de la pelota.
  double ballY = 0; // Posición vertical inicial de la pelota.
  var ballYDirection = direction.DOWN; // Dirección vertical inicial de la pelota.
  var ballXDirection = direction.LEFT; // Dirección horizontal inicial de la pelota.

  // Configuración del juego.
  bool gameHasStarted = false; // Indica si el juego ha comenzado.

  // Método para iniciar el juego.
  void startGame() {
    gameHasStarted = true; // Cambia el estado del juego a iniciado.
    Timer.periodic(Duration(milliseconds: 1), (timer) { // Ejecuta un bucle cada milisegundo.
      updateDirection(); // Actualiza la dirección de la pelota.
      moveBall(); // Mueve la pelota.
      moveEnemy(); // Mueve el ladrillo enemigo.

      if (isPlayerDead()) { // Verifica si el jugador perdió.
        enemyScore++; // Incrementa el puntaje del enemigo.
        timer.cancel(); // Detiene el temporizador.
        _showDialog(false); // Muestra el diálogo de derrota.
      }

      if (isEnemyIsDead()) { // Verifica si el enemigo perdió.
        playerScore++; // Incrementa el puntaje del jugador.
        timer.cancel(); // Detiene el temporizador.
        _showDialog(true); // Muestra el diálogo de victoria.
      }
    });
  }

  // Verifica si el enemigo perdió.
  bool isEnemyIsDead() { // el enemigo pierde si:
    return ballY <= -1; // La pelota salió por la parte superior.
  }

  // Verifica si el jugador perdió.
  bool isPlayerDead() { // el jugador muere si:
    return ballY >= 1; // La pelota salió por la parte inferior.
  }

  // Mueve el ladrillo enemigo 
  void moveEnemy() { 
    setState(() {
      enemyX = ballX; // El ladrillo enemigo sigue la posición de la pelota.
    });
  }

  // Muestra un cuadro de diálogo cuando alguien pierde.
  void _showDialog(bool enemyDied) { 
    showDialog( 
      context: context,
      barrierDismissible: false, // Evita cerrar el cuadro tocando fuera de él.
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple, // Fondo morado.
          title: Center( // Centra el mensaje
            child: Text( // texto
              enemyDied ? "BLUE WIN" : "PURPLE WIN", // Mensaje de victoria o derrota dependiendo de quien perdio
              style: TextStyle(color: Colors.white), // color blanco para el texto
            ),
          ),
          actions: [
            GestureDetector( // Widget para detectar gestos
              onTap: resettGame, // Reinicia el juego al tocar el botón.
              child: ClipRRect( // Recortar widgets con esquinas redondeadas,
                borderRadius: BorderRadius.circular(5), // Bordes redondeados.
                child: Container( //Contenedor
                  padding: EdgeInsets.all(7), // Margenes  a todos los lados
                  color: enemyDied ? Colors.blue[700] : Colors.deepPurple[100], // Color del botón.
                  child: Text( //texto
                    "PLAY AGAIN", // Texto del botón.
                    style: TextStyle( // dar estilo al texto
                      color: enemyDied ? Colors.blue[700] : Colors.deepPurple[800], //darle color al texto dependiendo de quien gano
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Reinicia el juego.
  void resettGame() {
    Navigator.pop(context); // Cierra el cuadro de diálogo.
    setState(() { // establecer estado
      gameHasStarted = false; // Restablece el estado del juego.
      ballX = 0; ballY = 0; // Posición inicial de la pelota.
      playerX = -0.2; // Restablece la osición inicial del jugador.
      enemyX = -0.2; // Restablece la posición inicial del enemigo.
    });
  }

  // Actualiza la dirección de la pelota dependiendo de su posición.
  void updateDirection() {
    setState(() { // establecer estado
    //cuando la pelota toca un ladrillo
      if (ballY >= 0.9 && playerX + brickWidth >= ballX && playerX <= ballX) { // si la pelota toca el ladrillo del jugador (superior)
        ballYDirection = direction.UP; // Rebota hacia arriba.
      } else if (ballY <= -0.9) { // si la pelota toca el ladrillo del enemigo (superior)
        ballYDirection = direction.DOWN; // Rebota hacia abajo.
      }

      // cuando la pelota toca un borde
      if (ballX >= 1) { //si la peliota toca el borde de la derecha
        ballXDirection = direction.LEFT; // Rebota hacia la izquierda.
      } else if (ballX <= -1) { // si la pelota toca el borde de la izquierda
        ballXDirection = direction.RIGHT; // Rebota hacia la derecha.
      }
    });
  }

  // Mueve la pelota en la dirección actual.
  void moveBall() {
    setState(() { // establecer estado
      ballY += (ballYDirection == direction.DOWN) ? 0.01 : -0.01; // Movimiento vertical.
      ballX += (ballXDirection == direction.LEFT) ? -0.01 : 0.01; // Movimiento horizontal.
    });
  }

  // evitar que el jugador se salga de los bordes
  // Mueve el ladrillo del jugador hacia la izquierda.
  void moveLeft() {
    setState(() {
      if (!(playerX - 0.1 <= -1)) { // si el jugador se sale del borde derecho
        playerX -= 0.1; // posicionarlo antes del borde
      }
    });
  }

  // Mueve el ladrillo del jugador hacia la derecha.
  void moveRight() {
    setState(() {
      if (!(playerX + brickWidth >= 1)) { // si el jugador se sale del borde izquierdo
        playerX += 0.1; // posicionarlo antes del borde
      }
    });
  }

  @override
  Widget build(BuildContext context) { // // Sobrescribe el método build para construir la interfaz grafica del widget
    return GestureDetector( // // Detecta gestos realizados por el jugador
      onTap: startGame, // Inicia el juego al tocar la pantalla.
      onHorizontalDragUpdate: (details) { // Detecta deslizamientos horizontales.
        if (details.delta.dx > 0) { // Si el deslizamiento es hacia la derecha
          moveRight(); // Se mueve el jugador a la derecha
        } else if (details.delta.dx < 0) {// Si el deslizamiento es hacia la izquierda
          moveLeft(); // Se mueve el ljugador a la izquierda
        }
      },
      child: Scaffold( // Estructura del diseño de la aplicación
        backgroundColor: Colors.grey[900], // Fondo gris oscuro.
        body: Center( //centrar el contenido
          child: Stack( // Superpone widgets en capas
            children: [
              Coverscreen(gameHasStarted: gameHasStarted), // Pantalla inicial.
              ScoreScreen(
                gameHasStarted: gameHasStarted, // Indica si el marcador debe estar visible.
                enemyScore: enemyScore, // score del enemigo
                playerScore: playerScore, // score del jugador
              ),
              MyBrick(x: enemyX, y: -0.9, brickWidth: brickWidth, thisIsEnemy: true), // Posicion del ladrillo enemigo.
              MyBrick(x: playerX, y: 0.9, brickWidth: brickWidth, thisIsEnemy: false), // Posicion del ladrillo del jugador.
              MyBall(x: ballX, y: ballY), // Posicion de la elota.
            ],
          ),
        ),
      ),
    );
  }
}
