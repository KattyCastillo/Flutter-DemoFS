import 'dart:convert';
import 'package:flutter_app_fs/personajes/data/models/personaje.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

// ANOTACIÓN: Define tus claves aquí. ¡No compartas tu Private Key!
const String _publicKey = 'TU_PUBLIC_KEY'; // Reemplaza con tu clave pública
const String _privateKey = 'TU_PRIVATE_KEY'; // Reemplaza con tu clave privada

class MarvelService {
  final http.Client _client; // Usamos http.Client para facilitar las pruebas

  MarvelService(this._client);

  // Función interna para generar el hash de seguridad requerido por Marvel
  String _generateHash(int timestamp) {
    // Concatenamos el timestamp + private key + public key
    final input = '$timestamp$_privateKey$_publicKey';
    // Generamos el hash MD5
    final digest = md5.convert(utf8.encode(input));
    return digest.toString();
  }

  // ANOTACIÓN: Esta función obtiene la lista de personajes.
  // Lanza una excepción si la petición falla.
  Future<List<Personaje>> fetchCharacters() async {
    // final timestamp = DateTime.now().millisecondsSinceEpoch;
    // final hash = _generateHash(timestamp);

    // Construimos la URL con los parámetros requeridos
    final url = Uri.parse('https://gateway.marvel.com/v1/public/characters'
        // '?ts=$timestamp'
        // '&apikey=$_publicKey'
        // '&hash=$hash'
        // '&limit=20' // Solo 20 personajes para empezar
        );

    try {
      return _createMockPersonajes();

      // final response = await _client.get(url);

      // if (response.statusCode == 200) {
      //   // La petición fue exitosa (código 200)
      //   final Map<String, dynamic> data = jsonDecode(response.body);

      //   // ANOTACIÓN: Navegamos a la parte de la respuesta que contiene los datos
      //   final List results = data['data']['results'];

      //   // Mapeamos la lista de JSON a una lista de objetos Character
      //   return results.map((json) => Personaje.fromJson(json)).toList();
      // } else {
      //   // La API retornó un error (ej. 404, 500)
      //   throw Exception(
      //       'Fallo al cargar personajes. Código: ${response.statusCode}');
      // }
    } catch (e) {
      // Error de red o cualquier otra excepción
      throw Exception('Error de conexión o datos: $e');
    }
  }

  List<Personaje> _createMockPersonajes() {
    return [
      Personaje(
        id: 10001,
        name: 'Spider-Man (Simulado)',
        description:
            'El amistoso vecino Spider-Man. Datos de prueba para Cubit.',
        thumbnailUrl: 'https://placehold.co/100x100/A00000/ffffff?text=SP',
      ),
      Personaje(
        id: 10002,
        name: 'Iron Man (Simulado)',
        description: 'Tony Stark, genio, playboy, filántropo. Datos simulados.',
        thumbnailUrl: 'https://placehold.co/100x100/0000A0/ffffff?text=IM',
      ),
      Personaje(
        id: 10003,
        name: 'Black Widow (Simulado)',
        description: 'Natasha Romanoff, espía de élite. Probando BLoC.',
        thumbnailUrl: 'https://placehold.co/100x100/333333/ffffff?text=BW',
      ),
      Personaje(
        id: 10004,
        name: 'Captain America (Simulado)',
        description:
            'Steve Rogers, el primer Vengador. Funcionamiento sin API.',
        thumbnailUrl: 'https://placehold.co/100x100/00A000/ffffff?text=CA',
      ),
    ];
  }
}
