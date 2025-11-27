import 'package:flutter/material.dart';

// ANOTACIÓN: Esta página es el destino de la ruta /detail/:characterId
class PersonajesDetailWidget extends StatelessWidget {
  final int characterId;

  const PersonajesDetailWidget({
    super.key,
    required this.characterId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Personaje ID: $characterId'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.info_outline, size: 80, color: Colors.red),
              const SizedBox(height: 20),
              Text(
                'Esta es la página de detalles para el personaje con ID: $characterId.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Usamos GoRouter para navegar a esta ruta y leer el ID directamente.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
