import 'package:flutter/material.dart'; // Importa el paquete principal de Flutter para construir la interfaz gráfica.
import 'homepage.dart'; // Importa el archivo homepage.dart

void main() { // Punto de entrada principal de la aplicación Flutter.
  runApp(const MyApp()); // Ejecuta la aplicación e inicializa el widget raíz (`MyApp`).
}

class MyApp extends StatelessWidget { // Define un widget sin estado que sirve como raíz de la aplicación.
  const MyApp({super.key}); // Constructor constante para inicializar el widget con una clave opcional.

  @override
  Widget build(BuildContext context) { // Método que construye la interfaz gráfica del widget.
    return const MaterialApp( // Retorna un widget `MaterialApp`, que configura el diseño principal de la aplicación.
      debugShowCheckedModeBanner: false, // Oculta el banner de "Debug" en la esquina superior derecha.
      home: HomePage(), // Establece la pantalla principal como `HomePage`.
    );
  }
}
