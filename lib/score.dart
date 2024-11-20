import 'package:flutter/material.dart'; // Importa el paquete principal de Flutter para construir interfaces gráficas.

class ScoreScreen extends StatelessWidget { // Define un widget sin estado que representa la pantalla de puntuación del juego.

  final bool gameHasStarted; // Variable final que indica si el juego ha comenzado o no.
  final enemyScore; // Puntuación del enemigo.
  final playerScore; // Puntuación del jugador.

  const ScoreScreen({super.key, required this.gameHasStarted, this.enemyScore, this.playerScore});
  // Constructor que inicializa `gameHasStarted`, `enemyScore`, y `playerScore`.

  @override
  Widget build(BuildContext context) { // Método que construye la representación gráfica del widget.
    return gameHasStarted ? Stack( // Si el juego ha comenzado, se muestra una pila de elementos.
      children: [
        // Pantalla de la puntuación
        // linea central que divide el jugador del enemigo
        Container( // Contenedor para la línea central de la pantalla.
          alignment: const Alignment(0, 0), // Alinea el contenedor en el centro de la pantalla.
          child: Container(
            height: 1, // La altura de la línea es de 1 píxel.
            width: MediaQuery.of(context).size.width / 3, // El ancho de la línea es 1/3 del ancho de la pantalla.
            color: Colors.grey[700], // Establece el color de la línea.
          ),
        ),

        // 0 superior de la pantalla
        Container( // Contenedor para mostrar la puntuación del enemigo en la parte superior.
          alignment: const Alignment(0, -0.3), // Alinea el contenedor en la parte superior central de la pantalla.
          child: Text(
            enemyScore.toString(), // Convierte la puntuación del enemigo a texto.
            style: TextStyle(color: Colors.grey[700], fontSize: 100), // Estilo del texto 
          ),
        ),
        
        // 0 inferior de la pantalla
        Container( // Contenedor para mostrar la puntuación del jugador en la parte inferior.
          alignment: const Alignment(0, 0.3), // Alinea el contenedor en la parte inferior central de la pantalla.
          child: Text(
            playerScore.toString(), // Convierte la puntuación del jugador a texto.
            style: TextStyle(color: Colors.grey[700], fontSize: 100), // Estilo del texto 
          ),
        ),
      ],
    ) : Container(); // Si el juego no ha comenzado, se muestra un contenedor vacío.
  }
}
