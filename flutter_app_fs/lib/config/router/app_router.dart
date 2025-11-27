import 'package:flutter_app_fs/configuraciones/presentation/pages/settings_page.dart';
import 'package:flutter_app_fs/home/presentation/pages/welcome_pages.dart';
import 'package:flutter_app_fs/personajes/presentation/pages/personajes_detail_page.dart';
import 'package:flutter_app_fs/personajes/presentation/pages/personaje_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

// ANOTACIÓNES:
// Esta variable 'appRouter' contiene la configuración completa de GoRouter.
// Al separarla, mantenemos el archivo 'main.dart' enfocado solo en la inyección de dependencias.
final GoRouter appRouter = GoRouter(
  initialLocation: '/', // Ruta inicial al arrancar la app
  routes: [
    GoRoute(
      path: '/', // Define la ruta raíz
      name:
          'home', // Asignamos un nombre para navegación futura (opcional, pero útil)
      builder: (context, state) => const PersonajePage(),
      routes: [
        // Ruta anidada para el detalle del personaje
        GoRoute(
          path: 'personaje',
          name: 'personaje',
          builder: (context, state) => const PersonajePage(),
        ),
        GoRoute(
          path: 'detail/:characterId',
          name: 'detail',
          builder: (context, state) {
            // ANOTACIÓN: Accedemos al parámetro 'characterId' de la URL
            final characterId = state.pathParameters['characterId']!;
            return PersonajesDetailPage(characterId: int.parse(characterId));
          },
        ),
        // Ruta anidada para la configuración
        GoRoute(
          path: 'settings',
          name: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
