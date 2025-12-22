import 'package:get_it/get_it.dart';
import 'package:intermediate_first_submission/core/data/datasource/main_remote_datasource.dart';
import 'package:intermediate_first_submission/core/data/repositories/auth_repository_impl.dart';
import 'package:intermediate_first_submission/core/data/repositories/service/image_compression_service.dart';
import 'package:intermediate_first_submission/core/data/repositories/story_repository_impl.dart';
import 'package:intermediate_first_submission/core/domain/repositories/auth_repository.dart';
import 'package:intermediate_first_submission/core/domain/repositories/story_repository.dart';
import 'package:intermediate_first_submission/core/domain/usecases/auth/create_account_usecase.dart';
import 'package:intermediate_first_submission/core/domain/usecases/auth/login_usecase.dart';
import 'package:intermediate_first_submission/core/domain/usecases/story/add_story_withtoken_usecase.dart';
import 'package:intermediate_first_submission/core/domain/usecases/story/get_all_story_usecase.dart';
import 'package:intermediate_first_submission/core/domain/usecases/story/get_story_by_id_usecase.dart';
import 'package:intermediate_first_submission/core/services/session_services.dart';
import 'package:intermediate_first_submission/env/env.dart';
import 'package:intermediate_first_submission/features/auth/provider/auth_provider.dart';
import 'package:intermediate_first_submission/features/detail/provider/detail_maps_provider.dart';
import 'package:intermediate_first_submission/features/detail/provider/detail_provider.dart';
import 'package:intermediate_first_submission/features/feed/provider/feed_provider.dart';
import 'package:intermediate_first_submission/features/post/provider/post_provider.dart';
import 'package:intermediate_first_submission/features/profile/provider/profile_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init(SharedPreferences prefs) async {
  const baseUrl = Env.dicodingApiEndpoint;

  /* --- Shared Preferences Chain --- */
  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerSingleton<SessionServices>(SessionServices(prefs));

  /* --- Image Compression Service =--*/
  sl.registerLazySingleton<ImageCompressionService>(
    () => ImageCompressionService(),
  );

  /* --- Data Chain --- */

  // datasource
  sl.registerLazySingleton<MainRemoteDatasource>(
    () => const MainRemoteDatasource(baseUrl: baseUrl),
  );

  // repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<StoryRepository>(
    () => StoryRepositoryImpl(sl(), sl()),
  );

  /* -- usecases --*/

  /* -- Auth usecases --*/
  // create account config
  sl.registerLazySingleton(() => CreateAccountUsecase(sl()));
  // login config
  sl.registerLazySingleton(() => LoginUsecase(sl()));

  /* -- Story usecases -- */
  sl.registerLazySingleton(() => GetAllStoryUsecase(sl()));
  sl.registerLazySingleton(() => GetStoryByIdUsecase(sl()));
  sl.registerLazySingleton(() => AddStoryWithtokenUsecase(sl()));

  /* -- State -- */
  sl.registerFactory(
    () => AuthProvider(createAccountUsecase: sl(), loginUsecase: sl()),
  );
  sl.registerFactory(() => HomeFeedProvider(getAllStoryUsecase: sl()));
  sl.registerFactory(() => PostProvider(addStoryWithtokenUsecase: sl()));
  sl.registerFactory(() => ProfileProvider());
  sl.registerFactory(() => DetailProvider(getStoryByIdUsecase: sl()));
  sl.registerFactory(() => DetailMapsProvider());
}
