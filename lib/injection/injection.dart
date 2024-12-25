import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:prodigal/config/global_configuration.dart';
import 'package:prodigal/repositories/user.repo.dart';
import 'package:prodigal/services/cake.service.dart';
import 'package:prodigal/services/dio_client.service.dart';
import 'package:prodigal/services/local_storage.dart';
import 'package:prodigal/services/module.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton(() => DioClientService(Dio(), GlobalConfiguration.instance));
  sl.registerSingletonAsync(() => SharedPreferences.getInstance());
  await sl.isReady<SharedPreferences>();
  sl.registerSingleton(LocalStorage(sl<SharedPreferences>()));
  sl.registerLazySingleton(() => AuthedUserRepository(sl<SharedPreferences>()));
  sl.registerLazySingleton(() => ModuleService());
  sl.registerLazySingleton(() => CakeService());
}
