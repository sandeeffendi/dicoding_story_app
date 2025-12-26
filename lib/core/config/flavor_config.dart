enum FlavorType { free, paid }

class FlavorConfig {
  final FlavorType flavor;
  final bool enableMaps;

  FlavorConfig._internal({required this.flavor, required this.enableMaps});

  static FlavorConfig? _instance;

  static void initialize({required FlavorType flavor}) {
    _instance = FlavorConfig._internal(
      flavor: flavor,
      enableMaps: flavor == FlavorType.paid,
    );
  }

  static FlavorConfig get instance => _instance!;
  static bool get isMapsEnabled => _instance?.enableMaps ?? false;
  static FlavorType get currentFlavor => _instance?.flavor ?? FlavorType.free;
}
