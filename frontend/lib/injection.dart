import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/network/dio_client.dart';
import 'core/storage/storage_service.dart';
import 'core/theme/theme_cubit.dart'; 
import 'features/auth/data/repos/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> configureInjection() async {
  // Storage
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  sl.registerLazySingleton<StorageService>(
    () => StorageService(),
  );

  // Network
  sl.registerLazySingleton<DioClient>(
    () => DioClient(storage: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(sl()),
  );

  // Bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl(), sl()),
  );

  //Cubit
  sl.registerFactory<ThemeCubit>(
    () => ThemeCubit(sl()),
  );
}