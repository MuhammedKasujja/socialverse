import 'package:flutter/gestures.dart';
import 'package:socialverse/features/videos/presentation/dynamic_video_screen.dart';
import 'package:socialverse/features/videos/presentation/scroll/scroll_screen.dart';
import 'package:socialverse/features/videos/presentation/scroll_screen.dart';
import 'package:socialverse/features/videos/presentation/video/video_feed_screen.dart';
import 'package:socialverse/features/videos/presentation/video/video_screen.dart';

import 'core/configs/route_generator/custom_router.dart';
import 'export.dart';
import 'features/videos/presentation/scroll_children_screen.dart'
    hide FourWaySwipeHandler;
import 'features/videos/presentation/video/tree_page_view.dart';

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
        return ScreenUtilInit(
          child: MaterialApp(
            themeMode: __.selectedThemeMode,
            theme: theme.getTheme(),
            darkTheme: Constants.darkTheme,
            navigatorKey: navKey,
            scaffoldMessengerKey: rootKey,
            title: 'WeMotions',
            debugShowCheckedModeBanner: false,
            // onGenerateRoute: CustomRouter.onGenerateRoute,
            // initialRoute: logged_in! ? BottomNavBar.routeName : WelcomeScreen.routeName,
            // initialRoute: VideoFeedScreen.routeName,
            // home: Manual2DPageView(),
            // home: DynamicScrollPageView(),
            //  home: VideoFeedScreen(),
            //  home: FourWaySwipeHandler(),
            home: FeedScrollView(),
          ),
        );
      },
    );
  }
}

class FeedScrollView extends StatelessWidget {
  const FeedScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        spacing: 12,
        children: [
          
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FourWaySwipeHandler()),
              );
            },
            child: Text('List Nested'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => VideoScreen()),
              );
            },
            child: Text('Next Feed'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ScrollFeedList()),
              );
            },
            child: Text('List Inner Vertical Feed'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TreeViewExample()),
              );
            },
            child: Text('Tree'),
          ),
        ],
      ),
    );
  }
}
