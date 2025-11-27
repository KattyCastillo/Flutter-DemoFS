import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.rocket_launch, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              '¡Bienvenido al Universo Marvel!',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Explora tus héroes favoritos, gestiona tu estado con BLoC, '
              'y navega con GoRouter. ¡Tu aventura comienza aquí!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Botón que usa Navigator, en lugar de GoRouter, para un ejemplo
            ElevatedButton.icon(
              icon: const Icon(Icons.group),
              label: const Text('Ver Personajes'),
              onPressed: () {
                // ANOTACIÓN: Ejemplo de uso de GoRouter para navegación
                context.go('/');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
