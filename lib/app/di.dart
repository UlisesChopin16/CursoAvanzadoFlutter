import 'package:curso_avanzado_flutter/app/app_preferences.dart';
import 'package:curso_avanzado_flutter/data/data_source/remote_data_source.dart';
import 'package:curso_avanzado_flutter/data/network/apis/app_api.dart';
import 'package:curso_avanzado_flutter/data/network/dio_factory.dart';
import 'package:curso_avanzado_flutter/data/network/network_info/network_info.dart';
import 'package:curso_avanzado_flutter/data/repository_impl/repository_impl.dart';
import 'package:curso_avanzado_flutter/domain/repository/repository.dart';
import 'package:curso_avanzado_flutter/domain/usecase/login_use_case.dart';
import 'package:curso_avanzado_flutter/presentation/Views/login/login_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // Register your dependencies here
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared preferences instance
  instance.registerLazySingleton(() => sharedPrefs);

  // App preferences
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance()),
  );

  // network info
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionChecker()),
  );

  // dio factory
  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(instance()),
  );

  // App service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppApi>(
    () => AppApi(dio),
  );

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(instance()),
  );

  // repository
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      instance(),
      instance(),
    ),
  );
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    // Register your dependencies here
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(instance()),
    );

    // login view model
    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(loginUseCase: instance()),
    );
  }
}
