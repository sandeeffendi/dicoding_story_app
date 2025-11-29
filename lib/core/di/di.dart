import 'package:get_it/get_it.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';
import 'package:intermediate_first_submission/data/datasource/main_remote_datasource.dart';
import 'package:intermediate_first_submission/data/repositories/auth_repository_impl.dart';
import 'package:intermediate_first_submission/data/repositories/story_repository_impl.dart';
import 'package:intermediate_first_submission/domain/repositories/auth_repository.dart';
import 'package:intermediate_first_submission/domain/repositories/story_repository.dart';
import 'package:intermediate_first_submission/domain/usecases/auth/create_account_usecase.dart';
import 'package:intermediate_first_submission/domain/usecases/auth/login_usecase.dart';
import 'package:intermediate_first_submission/domain/usecases/story/get_all_story_usecase.dart';
import 'package:intermediate_first_submission/domain/usecases/story/get_story_by_id_usecase.dart';
import 'package:intermediate_first_submission/env/env.dart';
import 'package:intermediate_first_submission/presentation/auth/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init(SharedPreferences prefs) async {
  final baseUrl = Env.dicodingApiEndpoint;

  /* --- Shared Preferences Chain --- */
  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerSingleton<SessionServices>(SessionServices(prefs));

  /* --- Data Chain --- */
  // state
  sl.registerFactory(
    () => AuthProvider(createAccountUsecase: sl(), loginUsecase: sl()),
  );

  // datasource
  sl.registerLazySingleton<MainRemoteDatasource>(
    () => MainRemoteDatasource(baseUrl: baseUrl),
  );

  // repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<StoryRepository>(() => StoryRepositoryImpl(sl()));

  /* -- usecases --*/

  /* -- Auth usecases --*/
  // create account config
  sl.registerLazySingleton(() => CreateAccountUsecase(sl()));
  // login config
  sl.registerLazySingleton(() => LoginUsecase(sl()));

  /* -- Story usecases -- */
  sl.registerLazySingleton(() => GetAllStoryUsecase(sl()));
  sl.registerLazySingleton(() => GetStoryByIdUsecase(sl()));
}
