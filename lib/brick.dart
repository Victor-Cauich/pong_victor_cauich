import 'package:flutter/material.dart'; // Importa el paquete principal de Flutter para construir interfaces gráficas.

class MyBrick extends StatelessWidget { // Define un widget sin estado que representa un ladrillo (barra) en el juego.
  
  final x; // Variable final para la posición horizontal del ladrillo.
  final y; // Variable final para la posición vertical del ladrillo.
  final brickWidth; // Ancho del ladrillo, representado como una fracción de 2 (escala entre -1 y 1).
  final thisIsEnemy; // Indica si el ladrillo es del jugador o del enemigo

  const MyBrick({super.key, this.x, this.y, this.brickWidth, this.thisIsEnemy}); 
  // Constructor que inicializa las propiedades `x`, `y`, `brickWidth`, y `thisIsEnemy`.

  @override
  Widget build(BuildContext context) { // Método que construye la representación gráfica del widget.
    return Container( // Contenedor principal para organizar el contenido del ladrillo.
      alignment: Alignment( // Alinea el ladrillo en función de su posición `x` y `y`.
        (2*x + brickWidth) / (2-brickWidth), // Calcula la posición horizontal con respecto al ancho del ladrillo.
        y, // Posición vertical del ladrillo.
      ),
      
      child: ClipRRect( // Redondea las esquinas del contenedor del ladrillo.
        borderRadius: BorderRadius.circular(10), // Aplica un radio de 10 píxeles a las esquinas del ladrillo.
        child: Container( // Contenedor que representa el ladrillo.
          color: thisIsEnemy ? Colors.deepPurple[300] : Colors.blue[700], // Establece el color según si el ladrillo es del enemigo o del jugador.
          height: 20, // Establece la altura del ladrillo en 20 píxeles.
          width: MediaQuery.of(context).size.width * brickWidth / 2, // Calcula el ancho del ladrillo según el tamaño de la pantalla.
        ),
      ),
    );
  }
}
