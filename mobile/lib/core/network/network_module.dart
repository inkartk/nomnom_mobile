import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nomnom_mobile/core/logging/app_talker.dart';
import 'package:nomnom_mobile/core/network/auth_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:nomnom_mobile/features/auth/data/datasources/auth_api.dart';
import 'package:nomnom_mobile/features/auth/data/datasources/user_api.dart';
import 'package:nomnom_mobile/features/favorites/data/datasources/favorites_api.dart';
import 'package:nomnom_mobile/features/ingredients/data/datasources/ingredients_api.dart';
import 'package:nomnom_mobile/features/recipes/data/datasources/recipes_api.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor) {
    final baseUrl = Platform.isAndroid
        ? 'http://10.0.2.2:3000'
        : 'http://localhost:3000';

    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(
      TalkerDioLogger(
        talker: appTalker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: false,
          printResponseData: true,
          printRequestData: true,
        ),
      ),
    );

    return dio;
  }

  @lazySingleton
  AuthApi authApi(Dio dio) => AuthApi(dio);

  @lazySingleton
  UserApi userApi(Dio dio) => UserApi(dio);

  @lazySingleton
  RecipesApi recipesApi(Dio dio) => RecipesApi(dio);

  @lazySingleton
  IngredientsApi ingredientsApi(Dio dio) => IngredientsApi(dio);

  @lazySingleton
  FavoritesApi favoritesApi(Dio dio) => FavoritesApi(dio);
}
