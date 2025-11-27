import 'package:flutter_app_fs/personajes/data/models/personaje.dart';

// ANOTACIÓN: Clase base abstracta para todos los estados
abstract class PersonajeState {}

// 1. Estado Inicial: Cuando la app recién arranca y no ha hecho nada.
class PersonajeInitial extends PersonajeState {}

// 2. Estado de Carga: Cuando la app está esperando la respuesta de la API.
class PersonajeLoading extends PersonajeState {}

// 3. Estado Cargado: Cuando la app recibió los datos correctamente.
class PersonajeLoaded extends PersonajeState {
  final List<Personaje> characters;

  PersonajeLoaded(this.characters);
}

// 4. Estado de Error: Cuando algo salió mal (red, API, etc.).
class PersonajeError extends PersonajeState {
  final String message;

  PersonajeError(this.message);
}
