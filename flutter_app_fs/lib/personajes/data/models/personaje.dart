class Personaje {
  final int id;
  final String name;
  final String description;
  final String thumbnailUrl;

  Personaje({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
  });

  // Anotación
  // Este es el constructor de fábrica que toma el JSON (un Map<String, dynamic>)
  // y lo convierte en una instancia de nuestra clase Character.
  factory Personaje.fromJson(Map<String, dynamic> json) {
    // La API de Marvel tiene la estructura: data -> results -> [lista de personajes]
    final imagePath = json['thumbnail']['path'];
    final imageExtension = json['thumbnail']['extension'];

    return Personaje(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? 'No hay descripción disponible.',
      // Creamos la URL completa de la imagen.
      thumbnailUrl: '$imagePath.$imageExtension',
    );
  }
}
