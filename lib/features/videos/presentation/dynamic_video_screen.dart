import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:socialverse/core/utils/logger/logger.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/videos/providers/post_registry_provider.dart';

class DynamicScrollPageView extends StatefulWidget {
  const DynamicScrollPageView({super.key});

  @override
  State<DynamicScrollPageView> createState() => _DynamicScrollPageViewState();
}

class _DynamicScrollPageViewState extends State<DynamicScrollPageView> {
  final PageController _pageController = PageController();
  Axis _scrollDirection = Axis.horizontal;

  void _switchToHorizontal() {
    logger.debug({
      "HorizontalPage": context.read<PostRegistryProvider>().horizontalIndex,
    });
    if (_scrollDirection != Axis.horizontal) {
      setState(() => _scrollDirection = Axis.horizontal);
    }
  }

  void _switchToVertical() {
    logger.debug({
      "VerticalPage": context.read<PostRegistryProvider>().verticalIndex,
    });

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
                  HorizontalSwipeGestureRecognizer
                >(() => HorizontalSwipeGestureRecognizer(), (
                  HorizontalSwipeGestureRecognizer instance,
                ) {
                  instance.onSwipeLeft = _switchToHorizontal;
                  instance.onSwipeRight = _switchToVertical;
                }),
          },
          behavior: HitTestBehavior.translucent,
          child: PageView.builder(
            key: ValueKey(_scrollDirection), // Force rebuild on switch
            controller: _pageController,
            scrollDirection: _scrollDirection,
            itemCount: 5,
            onPageChanged: (page) {
              logger.info({'HoriPage': page});
              context.read<PostRegistryProvider>().onHorizontalScroll(page);
            },
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
