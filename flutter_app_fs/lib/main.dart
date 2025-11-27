// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_app_fs/config/router/app_router.dart';
import 'package:flutter_app_fs/configuraciones/presentation/cubit/settings_cubit.dart';
import 'package:flutter_app_fs/personajes/presentation/cubit/personaje_cubit.dart';
import 'package:flutter_app_fs/personajes/services/marvel_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: Usamos MultiProvider (que incluye BlocProvider)
    // para inicializar nuestras clases y hacerlas accesibles.

    return MultiProvider(
      // 1. Creamos la instancia del Servicio.
      // Usamos Provider.value() o Provider(create:) para instancias.
      // El .value() es más simple para exponer un objeto ya creado.
      // Aquí usamos Provider.value para el cliente HTTP.
      providers: [
        // Proveemos el cliente HTTP para el servicio
        Provider<http.Client>(
          create: (_) => http.Client(),
        ),

        // Proveemos el Servicio de Marvel, que requiere el http.Client
        Provider<MarvelService>(
          create: (context) => MarvelService(context.read<http.Client>()),
        ),

        // 2. Creamos la instancia del Cubit.
        // BlocProvider es un tipo especial de Provider para Cubits/BLoC.
        BlocProvider(
          create: (context) => PersonajeCubit(
            // Le pasamos la instancia de MarvelService que ya proveímos arriba
            context.read<MarvelService>(),
          )..fetchCharacters(), // ANOTACIÓN: Inmediatamente llamamos a la carga de datos.
        ),

        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'Marvel State Manager',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
