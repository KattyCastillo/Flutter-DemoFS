import 'package:flutter_app_fs/personajes/presentation/cubit/personaje_state.dart';
import 'package:flutter_app_fs/personajes/services/marvel_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ANOTACIÓN: El Cubit extiende Cubit<CharacterState> e inicia con CharacterInitial()
class PersonajeCubit extends Cubit<PersonajeState> {
  // ANOTACIÓN: Recibe el servicio como dependencia (Inyección de Dependencias).
  // Es mejor que el Cubit no sepa cómo se obtienen los datos.
  final MarvelService _marvelService;

  PersonajeCubit(this._marvelService) : super(PersonajeInitial());

  // ANOTACIÓN: Función para cargar los personajes (la 'llamada' desde la UI).
  Future<void> fetchCharacters() async {
    // 1. Emitir el estado de carga
    emit(PersonajeLoading());

    try {
      // 2. Llamar al servicio
      final characters = await _marvelService.fetchCharacters();

      // 3. Emitir el estado de éxito (datos cargados)
      // La UI que esté escuchando recibirá este estado con la lista de personajes.
      emit(PersonajeLoaded(characters));
    } catch (e) {
      // 4. Emitir el estado de error si algo falla
      emit(PersonajeError(e.toString()));
    }
  }
}
