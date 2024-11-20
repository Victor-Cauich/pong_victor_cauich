import 'package:flutter/material.dart'; // Importa el paquete principal de Flutter para crear interfaces gráficas.

class MyBall extends StatelessWidget { // Define un widget sin estado para representar la pelota.
  
  final x; // Variable final para la posición horizontal de la pelota.
  final y; // Variable final para la posición vertical de la pelota.

  const MyBall({super.key, this.x, this.y}); // Constructor para inicializar las posiciones de la pelota con valores opcionales.

  @override
  Widget build(BuildContext context) { // Método que construye la representación gráfica del widget.
    return Container( // Widget contenedor que organiza el contenido.
      alignment: Alignment(x, y), // Alinea el contenedor interno según las coordenadas x,y
      child: Container( // Contenedor interno que representa la pelota.
        decoration: const BoxDecoration( // Aplica un estilo visual al contenedor.
          shape: BoxShape.circle, // Define la forma del contenedor como un círculo.
          color: Colors.white // Establece el color del círculo como blanco.
        ),
        width: 20, // Establece el ancho del círculo en 20 píxeles.
        height: 20, // Establece la altura del círculo en 20 píxeles.
      ),
    );
  }
}
