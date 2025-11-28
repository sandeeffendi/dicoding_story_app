import 'package:get_it/get_it.dart';
import 'package:intermediate_first_submission/data/datasource/main_remote_datasource.dart';
import 'package:intermediate_first_submission/data/repositories/auth_repository_impl.dart';
import 'package:intermediate_first_submission/domain/repositories/auth_repository.dart';
import 'package:intermediate_first_submission/domain/usecases/create_account_usecase.dart';
import 'package:intermediate_first_submission/domain/usecases/login_usecase.dart';
import 'package:intermediate_first_submission/env/env.dart';
import 'package:intermediate_first_submission/presentation/pages/auth/provider/auth_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final baseUrl = Env.dicodingApiEndpoint;

  sl.registerFactory(
    () => AuthProvider(createAccountUsecase: sl(), loginUsecase: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<MainRemoteDatasource>(
    () => MainRemoteDatasource(baseUrl: baseUrl),
  );

  // create account config
  sl.registerLazySingleton(() => CreateAccountUsecase(sl()));

  // login config
  sl.registerLazySingleton(() => LoginUsecase(sl()));
}
