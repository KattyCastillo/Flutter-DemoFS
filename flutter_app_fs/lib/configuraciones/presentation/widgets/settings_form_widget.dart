// lib/presentation/widgets/settings_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

class SettingsFormWidget extends StatefulWidget {
  const SettingsFormWidget({super.key});

  @override
  State<SettingsFormWidget> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsFormWidget> {
  // ANOTACIÓN CLAVE: GlobalKey para el Form. Permite validar y guardar los campos.
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _apiKeyController;
  late bool _darkModeEnabled;

  @override
  void initState() {
    super.initState();
    // Inicializamos los controladores con los valores actuales del Cubit.
    final currentState = context.read<SettingsCubit>().state;
    _apiKeyController = TextEditingController(text: currentState.apiKey);
    _darkModeEnabled = currentState.enableDarkMode;
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // ANOTACIÓN: _formKey.currentState!.validate() ejecuta la validación de todos los TextFormField.
    if (_formKey.currentState!.validate()) {
      // Si la validación es exitosa, pedimos al Cubit que guarde los nuevos valores.
      context.read<SettingsCubit>().saveSettings(
            newApiKey: _apiKeyController.text,
            newDarkMode: _darkModeEnabled,
          );

      // Muestra un mensaje de éxito.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Configuración guardada exitosamente!')),
      );
    }
  }

  // ANOTACIÓN: Widget con Form y TextFormField para manejo de entrada.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. TextFormField para la API Key
            TextFormField(
              controller: _apiKeyController,
              decoration: const InputDecoration(
                labelText: 'Clave Pública de API Marvel',
                prefixIcon: Icon(Icons.vpn_key),
              ),
              // ANOTACIÓN: Validación del formulario (Manejo de Widgets Relacionados)
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese la clave de API.';
                }
                if (value.length < 5) {
                  return 'La clave es demasiado corta.';
                }
                return null; // Retorna null si es válido
              },
            ),

            const SizedBox(height: 20),

            // 2. Widget Switch para el Modo Oscuro
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Habilitar Modo Oscuro (Simulado)',
                    style: TextStyle(fontSize: 16)),
                Switch(
                  value: _darkModeEnabled,
                  onChanged: (bool newValue) {
                    setState(() {
                      _darkModeEnabled = newValue;
                    });
                  },
                  activeColor: Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 3. Botón para guardar (Widget relacionado)
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.save),
              label: const Text('GUARDAR CONFIGURACIÓN'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 20),

            // 4. Muestra el estado actual del Cubit (Para demostrar la reactividad del estado)
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Estado Guardado (Desde Cubit):',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('API Key: ${state.apiKey}'),
                        Text(
                            'Modo Oscuro: ${state.enableDarkMode ? 'Activado' : 'Desactivado'}'),
                        Text('Último Guardado: ${state.lastSaved}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
