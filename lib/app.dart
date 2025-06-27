import 'package:socialverse/features/videos/presentation/video/video_feed_screen.dart';

import 'core/configs/route_generator/custom_router.dart';
import 'export.dart';

class WeMotions extends StatefulWidget {
  const WeMotions({super.key});

  @override
  State<WeMotions> createState() => _WeMotionsState();
}

class _WeMotionsState extends State<WeMotions> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Move the theme provider dependency here
    print(
      'the theme provider data is: ${Provider.of<ThemeProvider>(context).getTheme()}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Consumer<ThemeProvider>(
      builder: (_, __, ___) {
        return MaterialApp(
          themeMode: __.selectedThemeMode,
          theme: theme.getTheme(),
          darkTheme: Constants.darkTheme,
          navigatorKey: navKey,
          scaffoldMessengerKey: rootKey,
          title: 'WeMotions',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          // initialRoute: logged_in! ? BottomNavBar.routeName : WelcomeScreen.routeName,
          initialRoute: VideoFeedScreen.routeName,
        );
      },
    );
  }
}
