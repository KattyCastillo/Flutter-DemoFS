import 'package:flutter_app_fs/configuraciones/presentation/cubit/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; //Necesitas agregar intl a pubspec.yaml para formatear fechas (opcional, pero útil)

// ANOTACIÓN: Este Cubit maneja la lógica de guardar la configuración del formulario.
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  // ANOTACIÓN: Función para simular el guardado de la configuración
  Future<void> saveSettings({
    required String newApiKey,
    required bool newDarkMode,
  }) async {
    // 1. Simular un proceso de guardado (ej. a una DB local)
    // Mostraremos un pequeño retraso
    await Future.delayed(const Duration(milliseconds: 500));

    // 2. Crear el nuevo estado con los datos actualizados
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm:ss');

    final newState = state.copyWith(
      apiKey: newApiKey,
      enableDarkMode: newDarkMode,
      lastSaved: formatter.format(now),
    );

    // 3. Emitir el nuevo estado
    emit(newState);

    // NOTA: Para un manejo de estado más complejo (Cargando/Error),
    // se deberían definir más estados en SettingsState.
  }
}
