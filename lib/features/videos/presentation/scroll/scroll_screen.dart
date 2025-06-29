import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/helper/v_video_scroll_physics.dart';

class ScrollFeedList extends StatelessWidget {
  const ScrollFeedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        physics: VideoScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return FourWaySwipeVeritcalHandler(index: index);
        },
      ),
    );
  }
}

class FourWaySwipeVeritcalHandler extends StatefulWidget {
  final int index;

  const FourWaySwipeVeritcalHandler({super.key, required this.index});

  @override
  State<FourWaySwipeVeritcalHandler> createState() => _FourWaySwipeVeritcalHandlerState();
}

class _FourWaySwipeVeritcalHandlerState extends State<FourWaySwipeVeritcalHandler> {
  Axis _lockedAxis = Axis.horizontal;

  void _setAxis(Axis axis) {
    if (_lockedAxis != axis) {
      setState(() => _lockedAxis = axis);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        CustomDirectionRecognizer:
            GestureRecognizerFactoryWithHandlers<CustomDirectionRecognizer>(
          () => CustomDirectionRecognizer(),
          (instance) {
            instance.onDirectionLocked = _setAxis;
          },
        ),
      },
      behavior: HitTestBehavior.translucent,
      child: _lockedAxis == Axis.horizontal
          ? HorizontalCarousel(index: widget.index)
          : VerticalDetailsView(
              index: widget.index,
              onScrollToTop: () => _setAxis(Axis.horizontal),
            ),
    );
  }
}

class VerticalDetailsView extends StatefulWidget {
  final int index;
  final VoidCallback onScrollToTop;

  const VerticalDetailsView({
    super.key,
    required this.index,
    required this.onScrollToTop,
  });

  @override
  State<VerticalDetailsView> createState() => _VerticalDetailsViewState();
}

class _VerticalDetailsViewState extends State<VerticalDetailsView> {
  late PageController _controller;
  bool _hasFired = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  void _handleScroll(ScrollNotification notification) {
    if (notification.metrics.pixels <= 0.0 &&
        notification is ScrollEndNotification &&
        !_hasFired) {
      _hasFired = true;
      widget.onScrollToTop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _handleScroll(notification);
        return false;
      },
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (_, detailIndex) {
          return Container(
            color: Colors.primaries[(widget.index + detailIndex) %
                Colors.primaries.length].withOpacity(0.9),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 64),
              children: [
                Center(
                  child: Text(
                    'Detail View $detailIndex\n(Scroll to top & swipe down)',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                const SizedBox(height: 400), // simulate content
              ],
            ),
          );
        },
      ),
    );
  }
}

class InnerVerticalContent extends StatelessWidget {
  final String label;
  final Color color;

  const InnerVerticalContent({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        children: [
          SizedBox(height: 48),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 24)),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, i) => Text(
                'Comment $i',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalCarousel extends StatelessWidget {
  final int index;

  const HorizontalCarousel({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (_, i) {
        return InnerVerticalContent(
          color: Colors.primaries[(index + i) % Colors.primaries.length],
          label: 'Feed $index - Page $i',
        );
      },
    );
  }
}


class CustomDirectionRecognizer extends OneSequenceGestureRecognizer {
  Offset _start = Offset.zero;
  bool _locked = false;
  void Function(Axis)? onDirectionLocked;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
    _start = event.position;
    _locked = false;
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent && !_locked) {
      final delta = event.position - _start;
      final angle = delta.direction;

      if (delta.distance > 12) {
        _locked = true;
        final axis =
            (angle.abs() > math.pi / 4 && angle.abs() < 3 * math.pi / 4)
                ? Axis.vertical
                : Axis.horizontal;
        onDirectionLocked?.call(axis);
      }
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}
  @override
  String get debugDescription => 'CustomDirectionRecognizer';
}
