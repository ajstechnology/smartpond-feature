import 'package:dio/dio.dart';
import 'package:smartpond/data/repository/auth_repo.dart';
import 'package:smartpond/data/repository/banner_repo.dart';
import 'package:smartpond/data/repository/cart_repo.dart';
import 'package:smartpond/data/repository/category_repo.dart';
import 'package:smartpond/data/repository/chat_repo.dart';
import 'package:smartpond/data/repository/coupon_repo.dart';
import 'package:smartpond/data/repository/location_repo.dart';
import 'package:smartpond/data/repository/notification_repo.dart';
import 'package:smartpond/data/repository/onboarding_repo.dart';
import 'package:smartpond/data/repository/order_repo.dart';
import 'package:smartpond/data/repository/product_details_repo.dart';
import 'package:smartpond/data/repository/product_repo.dart';
import 'package:smartpond/data/repository/profile_repo.dart';
import 'package:smartpond/data/repository/search_repo.dart';
import 'package:smartpond/data/repository/splash_repo.dart';
import 'package:smartpond/provider/auth_provider.dart';
import 'package:smartpond/provider/banner_provider.dart';
import 'package:smartpond/provider/cart_provider.dart';
import 'package:smartpond/provider/category_provider.dart';
import 'package:smartpond/provider/chat_provider.dart';
import 'package:smartpond/provider/coupon_provider.dart';
import 'package:smartpond/provider/localization_provider.dart';
import 'package:smartpond/provider/location_provider.dart';
import 'package:smartpond/provider/notification_provider.dart';
import 'package:smartpond/provider/onboarding_provider.dart';
import 'package:smartpond/provider/order_provider.dart';
import 'package:smartpond/provider/product_provider.dart';
import 'package:smartpond/provider/profile_provider.dart';
import 'package:smartpond/provider/search_provider.dart';
import 'package:smartpond/provider/splash_provider.dart';
import 'package:smartpond/provider/theme_provider.dart';
import 'package:smartpond/utill/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(
      () => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => OnBoardingRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CategoryRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  sl.registerLazySingleton(
      () => SearchRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ChatRepo(dioClient: sl()));
  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => CartRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProductDetailsRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CouponRepo(dioClient: sl()));
  sl.registerLazySingleton(() => OrderRepo(dioClient: sl()));
  sl.registerLazySingleton(
      () => LocationRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => ProfileRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => BannerRepo(dioClient: sl()));
  sl.registerLazySingleton(() => NotificationRepo(dioClient: sl()));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => OnBoardingProvider(onboardingRepo: sl()));
  sl.registerFactory(() => CategoryProvider(categoryRepo: sl()));
  sl.registerFactory(
      () => ProductProvider(productRepo: sl(), searchRepo: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));
  sl.registerFactory(() => ChatProvider(chatRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => CartProvider(cartRepo: sl()));
  sl.registerFactory(() => CouponProvider(couponRepo: sl()));
  sl.registerFactory(
      () => LocationProvider(locationRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => OrderProvider(orderRepo: sl()));
  sl.registerFactory(() => BannerProvider(bannerRepo: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
