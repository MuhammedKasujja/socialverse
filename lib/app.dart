import 'package:flutter/gestures.dart';
import 'package:socialverse/features/videos/presentation/dynamic_video_screen.dart';
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
            // home: DynamicVideoScreen(),
            home: DynamicScrollPageView(),
          ),
        );
      },
    );
  }
}


class DynamicScrollPageView extends StatefulWidget {
  @override
  _DynamicScrollPageViewState createState() => _DynamicScrollPageViewState();
}

class _DynamicScrollPageViewState extends State<DynamicScrollPageView> {
  final PageController _pageController = PageController();
  Axis _scrollDirection = Axis.vertical;

  void _switchToHorizontal() {
    if (_scrollDirection != Axis.horizontal) {
      setState(() => _scrollDirection = Axis.horizontal);
    }
  }

  void _switchToVertical() {
    if (_scrollDirection != Axis.vertical) {
      setState(() => _scrollDirection = Axis.vertical);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        // Listen to raw pointer events so we don’t block PageView gestures
        onPointerUp: (event) {
          // Could enhance this with velocity detection using GestureArena if needed
        },
        child: RawGestureDetector(
          gestures: <Type, GestureRecognizerFactory>{
            HorizontalSwipeGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<
                    HorizontalSwipeGestureRecognizer>(
              () => HorizontalSwipeGestureRecognizer(),
              (HorizontalSwipeGestureRecognizer instance) {
                instance.onSwipeLeft = _switchToHorizontal;
                instance.onSwipeRight = _switchToVertical;
              },
            ),
          },
          behavior: HitTestBehavior.translucent,
          child: PageView.builder(
            key: ValueKey(_scrollDirection), // Force rebuild on switch
            controller: _pageController,
            scrollDirection: _scrollDirection,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.primaries[index % Colors.primaries.length],
                child: Text(
                  'Page $index\n($_scrollDirection)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Custom Gesture Recognizer to detect left/right swipes without blocking vertical ones
class HorizontalSwipeGestureRecognizer extends OneSequenceGestureRecognizer {
  VoidCallback? onSwipeLeft;
  VoidCallback? onSwipeRight;

  Offset _startPosition = Offset.zero;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
    _startPosition = event.position;
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      final dx = event.position.dx - _startPosition.dx;
      final dy = event.position.dy - _startPosition.dy;

      // Swipe detection threshold
      if (dx.abs() > 30 && dx.abs() > dy.abs()) {
        if (dx > 0) {
          onSwipeRight?.call();
        } else {
          onSwipeLeft?.call();
        }
        stopTrackingPointer(event.pointer); // prevent multiple triggers
      }
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  String get debugDescription => 'HorizontalSwipeGestureRecognizer';

  @override
  void dispose() {
    super.dispose();
  }
}
