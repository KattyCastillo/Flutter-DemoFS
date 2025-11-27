// ANOTACIÓN: Clase de estado que contiene los valores de la configuración guardada.
class SettingsState {
  final String apiKey;
  final bool enableDarkMode;
  final String lastSaved; // Fecha/hora de la última vez que se guardó

  SettingsState({
    required this.apiKey,
    required this.enableDarkMode,
    required this.lastSaved,
  });

  // Constructor inicial para el estado por defecto.
  factory SettingsState.initial() => SettingsState(
        apiKey: 'CLAVE',
        enableDarkMode: false,
        lastSaved: 'Nunca',
      );

  // ANOTACIÓN: Función copyWith para crear un nuevo estado inmutable con cambios.
  SettingsState copyWith({
    String? apiKey,
    bool? enableDarkMode,
    String? lastSaved,
  }) {
    return SettingsState(
      apiKey: apiKey ?? this.apiKey,
      enableDarkMode: enableDarkMode ?? this.enableDarkMode,
      lastSaved: lastSaved ?? this.lastSaved,
    );
  }
}
