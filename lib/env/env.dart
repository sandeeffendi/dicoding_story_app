import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'DICODING_API_ENDPOINT')
  static const String dicodingApiEndpoint = _Env.dicodingApiEndpoint;
}
