import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ANOTACIÓN: Este es el widget del menú lateral (Drawer)
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener la altura de la barra de estado y AppBar para el encabezado.
    final double appBarHeight =
        Scaffold.of(context).appBarMaxHeight ?? kToolbarHeight;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // 1. Encabezado del Drawer (Información de usuario)
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            padding: EdgeInsets.only(top: appBarHeight + 10, left: 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.red),
                ),
                SizedBox(height: 8),
                Text(
                  'Usuario Marvel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 2. Opción para ir a la Home Page (Lista de Personajes)
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Personajes Principales'),
            onTap: () {
              context.go('/');
              Navigator.pop(context); // Cierra el Drawer después de navegar
            },
          ),
          // 3. Opción para ir a la Welcome Page
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Página de Inicio'),
            onTap: () {
              context.go('/welcome');
              Navigator.pop(context); // Cierra el Drawer
            },
          ),
          // 4. Opción para ir a la Settings Page
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Ajustes de la App'),
            onTap: () {
              context.go('/settings');
              Navigator.pop(context); // Cierra el Drawer
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión (Simulado)'),
            onTap: () {
              // Lógica de logout simulada
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sesión cerrada.')),
              );
            },
          ),
        ],
      ),
    );
  }
}
