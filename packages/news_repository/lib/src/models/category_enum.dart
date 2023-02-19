enum CategoryNew<T extends String> {
  General<String>('general'),
  Negocios<String>('business'),
  Entretenimiento<String>('business'),
  Salud<String>('health'),
  Ciencia<String>('science'),
  Deportes<String>('sports'),
  Tecnologia<String>('technology');

  const CategoryNew(this.value);
  final T value;
}
