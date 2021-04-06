import 'package:get/get.dart';

import '../core/services/prefs_service.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/data/sources/auth_remote_data_source.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/get_logged_in_user_use_case.dart';
import '../features/auth/domain/usecases/sign_out_use_case.dart';
import '../features/notes/data/repositories/notes_repository_impl.dart';
import '../features/notes/data/sources/notes_data_source.dart';
import '../features/notes/domain/repositories/notes_repository.dart';


class AppBindings {
  static Future<void> init() async {
    // pref
    await Get.putAsync<PrefsService>(
      () async => await PrefsService.getInstance(),
      permanent: true,
    );

    // auth
    Get.lazyPut<GetLoggedInUserUseCase>(
        () => GetLoggedInUserUseCase(Get.find()),
        fenix: true);
    Get.lazyPut<SignOutUseCase>(() => SignOutUseCase(Get.find(), Get.find()),
        fenix: true);

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(),
        fenix: true);

    // notes
    Get.lazyPut<NotesRepository>(() => NotesRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut<NotesDataSource>(() => NotesDataSourceImpl(), fenix: true);
  }
}
