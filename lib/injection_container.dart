import 'package:get_it/get_it.dart';
import 'package:iconic_university/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:iconic_university/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:iconic_university/features/auth/domain/repositories/auth_repository.dart';
import 'package:iconic_university/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:iconic_university/features/auth/domain/usecases/login_usecase.dart';
import 'package:iconic_university/features/auth/domain/usecases/logout_usecase.dart';
import 'package:iconic_university/features/camera/data/datasources/camera_data_source.dart';
import 'package:iconic_university/features/camera/data/repositories/camera_repository_impl.dart';
import 'package:iconic_university/features/camera/domain/repositories/camera_repository.dart';
import 'package:iconic_university/features/camera/domain/usecases/capture_image_usecase.dart';
import 'package:iconic_university/features/camera/domain/usecases/capture_video_usecase.dart';
import 'package:iconic_university/features/camera/domain/usecases/pick_media_usecase.dart';
import 'package:iconic_university/features/camera/presentation/bloc/camera_bloc.dart';
import 'package:iconic_university/features/location/data/datasources/location_data_source.dart';
import 'package:iconic_university/features/location/data/repositories/location_repository_impl.dart';
import 'package:iconic_university/features/location/domain/repositories/location_repository.dart';
import 'package:iconic_university/features/location/domain/usecases/get_current_location_usecase.dart';
import 'package:iconic_university/features/location/domain/usecases/search_address_usecase.dart';
import 'package:iconic_university/features/location/presentation/bloc/location_bloc.dart';
import 'package:iconic_university/features/reports/data/datasources/reports_local_data_source.dart';
import 'package:iconic_university/features/reports/data/repositories/reports_repository_impl.dart';
import 'package:iconic_university/features/reports/domain/repositories/reports_repository.dart';
import 'package:iconic_university/features/reports/domain/usecases/create_report_usecase.dart';
import 'package:iconic_university/features/reports/domain/usecases/get_reports_usecase.dart';
import 'package:iconic_university/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => ImagePicker());

  // Features - Auth
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      checkAuthStatusUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Reports
  sl.registerFactory(
    () => ReportsBloc(createReportUseCase: sl(), getReportsUseCase: sl()),
  );

  sl.registerLazySingleton(() => CreateReportUseCase(sl()));
  sl.registerLazySingleton(() => GetReportsUseCase(sl()));

  sl.registerLazySingleton<ReportsRepository>(
    () => ReportsRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<ReportsLocalDataSource>(
    () => ReportsLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Location
  sl.registerFactory(
    () => LocationBloc(
      getCurrentLocationUseCase: sl(),
      searchAddressUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetCurrentLocationUseCase(sl()));
  sl.registerLazySingleton(() => SearchAddressUseCase(sl()));

  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<LocationDataSource>(
    () => LocationDataSourceImpl(location: sl()),
  );

  // Features - Camera
  sl.registerFactory(
    () => CameraBloc(
      captureImageUseCase: sl(),
      captureVideoUseCase: sl(),
      pickMediaUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => CaptureImageUseCase(sl()));
  sl.registerLazySingleton(() => CaptureVideoUseCase(sl()));
  sl.registerLazySingleton(() => PickMediaUseCase(sl()));

  sl.registerLazySingleton<CameraRepository>(
    () => CameraRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<CameraDataSource>(
    () => CameraDataSourceImpl(imagePicker: sl()),
  );
}
