import 'package:intermediate_first_submission/core/config/flavor_config.dart';
import 'package:intermediate_first_submission/main.dart' as app;

void main() {
  FlavorConfig.initialize(flavor: FlavorType.paid);
  app.mainApp();
}
