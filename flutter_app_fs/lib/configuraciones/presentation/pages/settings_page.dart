// lib/presentation/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_app_fs/configuraciones/presentation/widgets/settings_form_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración y Formulario'),
        backgroundColor: Colors.red,
      ),
      // ANOTACIÓN: Usamos un SingleChildScrollView para evitar desbordamiento en teclados.
      body: const SingleChildScrollView(
        child:
            SettingsFormWidget(), // Contiene el widget Form con toda la lógica.
      ),
    );
  }
}
