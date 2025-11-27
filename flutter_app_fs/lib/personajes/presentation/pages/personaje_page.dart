// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_app_fs/personajes/presentation/cubit/personaje_cubit.dart';
import 'package:flutter_app_fs/personajes/presentation/cubit/personaje_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PersonajePage extends StatelessWidget {
  const PersonajePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes Marvel (BLoC + Provider)'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Opción A: Navegar por PATH (ruta literal)
              // context.go('/settings');

              // Opción B (RECOMENDADA): Navegar por NOMBRE de la ruta
              context.goNamed('settings');
            },
          ),
        ],
      ),
      // ANOTACIÓN CLAVE: BlocBuilder escucha el Cubit y el Estado
      // Reconstruye solo esta parte del widget cuando un nuevo estado es emitido.
      body: BlocBuilder<PersonajeCubit, PersonajeState>(
        builder: (context, state) {
          // 1. Manejo del estado inicial (opcional)
          if (state is PersonajeInitial) {
            return const Center(child: Text('Presiona el botón para cargar.'));
          }

          // 2. Manejo del estado de carga
          if (state is PersonajeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 3. Manejo del estado de error
          if (state is PersonajeError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}',
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 16)),
                    const SizedBox(height: 20),
                    // ANOTACIÓN: Botón para reintentar la carga
                    ElevatedButton(
                      onPressed: () {
                        // Le pedimos al Cubit que re-ejecute su lógica
                        context.read<PersonajeCubit>().fetchCharacters();
                      },
                      child: const Text('Reintentar Carga'),
                    ),
                  ],
                ),
              ),
            );
          }

          // 4. Manejo del estado de éxito (datos cargados)
          if (state is PersonajeLoaded) {
            return ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                final character = state.characters[index];
                return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      // ANOTACIÓN: Usamos NetworkImage para mostrar la imagen de la URL
                      backgroundImage: NetworkImage(character.thumbnailUrl),
                      // Fallback: si la imagen falla, mostramos un ícono
                      onBackgroundImageError: (exception, stackTrace) {
                        debugPrint('Error cargando imagen: $exception');
                      },
                    ),
                    title: Text(character.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      character.description.isNotEmpty
                          ? character.description
                          : 'Sin descripción.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      final characterId =
                          character.id; // Obtenemos el ID del personaje.

                      // Opción A: Navegar por PATH (ruta literal)
                      // Reemplazamos :characterId en el path por el valor real.
                      // context.go('/detail/$characterId');

                      // Opción B (RECOMENDADA): Navegar por NOMBRE de la ruta
                      context.goNamed('detail', pathParameters: {
                        'characterId': characterId.toString()
                      });
                    },
                  ),
                );
              },
            );
          }

          // Fallback, nunca debería pasar si todos los estados son manejados
          return const Center(child: Text('Estado Desconocido'));
        },
      ),
    );
  }
}
