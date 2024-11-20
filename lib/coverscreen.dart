import 'package:flutter/material.dart'; // Importa el paquete principal de Flutter para construir interfaces gráficas.

class Coverscreen extends StatelessWidget { // Define un widget sin estado que representa la pantalla inicial del juego.

  final bool gameHasStarted; // Variable final que indica si el juego ha comenzado o no.

  const Coverscreen({super.key, required this.gameHasStarted}); 
  // Constructor que recibe `gameHasStarted` como parámetro requerido para inicializar la pantalla.

  @override
  Widget build(BuildContext context) { // Método que construye la interfaz gráfica del widget.
    return Container( // Contenedor principal para organizar el contenido de la pantalla inicial.
      alignment: const Alignment(0, -0.2), // Alinea el texto en el centro horizontal y hacia arriba en el eje vertical.
      child: Text( // Muestra un texto en la pantalla.
        gameHasStarted ? '' : "T A P  T O  P L A Y",  // texto que aparecera si el juego no a empezado
        // Si el juego ha comenzado (`gameHasStarted` es true), no muestra texto. 
        // Si no ha comenzado, muestra "T A P  T O  P L A Y".
        style: const TextStyle(color: Colors.white), // Estilo del texto con color blanco.
      ),
    );
  }
}
