enum FrameMaterial {
  aluminum ('Alumínio'),
  wood ('Madeira');

  final String label;
  const FrameMaterial(this.label);

  factory FrameMaterial.fromString(String value) {
    return FrameMaterial.values.firstWhere(
      (e) => e.label.toLowerCase() == value.toLowerCase(),
      orElse: () => FrameMaterial.wood,
    );
  }

}
