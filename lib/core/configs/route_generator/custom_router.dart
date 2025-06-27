import 'package:socialverse/export.dart';
import 'package:socialverse/features/videos/presentation/video/video_feed_screen.dart';

// import '../../presentation/welcome_screen.dart';

Route<dynamic> getPlatformPageRoute({
  required WidgetBuilder builder,
  String? routeName,
}) {
  if (Platform.isIOS) {
    return CupertinoPageRoute(
      builder: builder,
      settings: RouteSettings(name: routeName),
    );
  } else {
    return MaterialPageRoute(
      builder: builder,
      settings: RouteSettings(name: routeName),
    );
  }
}

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(
      //     settings: const RouteSettings(name: '/'),
      //     builder: (_) => Scaffold(),
      //   );

      case VideoFeedScreen.routeName:
        return VideoFeedScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => const Scaffold(body: Center(child: Text('Error'))),
      // builder: (_) => const ErrorScreen(),
    );
  }
}
