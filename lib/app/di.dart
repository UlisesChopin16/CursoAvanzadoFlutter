import 'package:curso_avanzado_flutter/app/app_preferences.dart';
import 'package:curso_avanzado_flutter/data/data_source/remote_data_source.dart';
import 'package:curso_avanzado_flutter/data/network/apis/customer_apis/customer_app_api.dart';
import 'package:curso_avanzado_flutter/data/network/dio_factory.dart';
import 'package:curso_avanzado_flutter/data/network/network_info/network_info.dart';
import 'package:curso_avanzado_flutter/data/repository/repository.dart';
import 'package:curso_avanzado_flutter/data/repository/repository_impl.dart';
import 'package:curso_avanzado_flutter/domain/usecase/forgot_password_use_case.dart';
import 'package:curso_avanzado_flutter/domain/usecase/home_use_case.dart';
import 'package:curso_avanzado_flutter/domain/usecase/login_use_case.dart';
import 'package:curso_avanzado_flutter/domain/usecase/register_use_case.dart';
import 'package:curso_avanzado_flutter/domain/usecase/store_details_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
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
  instance.registerLazySingleton<CustomerAppApi>(
    () => CustomerAppApi(dio),
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

  // login use case
  instance.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(instance()),
  );
}

void initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    // Register your dependencies here
    instance.registerFactory<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(instance()),
    );
  }
}

void initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    // Register your dependencies here
    instance.registerFactory<RegisterUseCase>(
      () => RegisterUseCase(instance()),
    );
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

void initHomeModule() {
  // Register your dependencies here
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(
      () => HomeUseCase(instance()),
    );
  }
}

void initStoreDetailsModule() {
  // Register your dependencies here
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
      () => StoreDetailsUseCase(instance()),
    );
  }
}

Future<void> resetAllModules() async {
  instance.reset(dispose: false);
  await initAppModule();
  initForgotPasswordModule();
  initRegisterModule();
  initHomeModule();
  initStoreDetailsModule();
}
