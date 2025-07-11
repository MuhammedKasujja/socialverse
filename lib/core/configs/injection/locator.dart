import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:socialverse/core/providers/notification_provider.dart';
import 'package:socialverse/features/videos/providers/post_registry_provider.dart';

// import 'package:socialverse/core/providers/bottom_nav_provider.dart';
// import 'package:socialverse/features/profile/providers/profile/user_profile_provider.dart';
final getIt = GetIt.instance;

void setupDI() {
  // getIt.registerLazySingleton<BottomNavBarProvider>(
  //   () => BottomNavBarProvider(),
  // );

  // getIt.registerLazySingleton<UserProfileProvider>(() => UserProfileProvider());
  getIt.registerLazySingleton<NotificationProvider>(
    () => NotificationProvider(),
  );
  getIt.registerLazySingleton<PostRegistryProvider>(
    () => PostRegistryProvider(),
  );
  getIt.registerLazySingleton(() => Dio());
}
