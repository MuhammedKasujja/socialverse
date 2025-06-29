import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:socialverse/features/home/helper/v_video_scroll_physics.dart';

class FourWaySwipeHandler extends StatefulWidget {
  const FourWaySwipeHandler({super.key});

  @override
  State<FourWaySwipeHandler> createState() => _FourWaySwipeHandlerState();
}

class _FourWaySwipeHandlerState extends State<FourWaySwipeHandler> {
  Axis _lockedAxis = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawGestureDetector(
        gestures: {
          CustomDirectionRecognizer:
              GestureRecognizerFactoryWithHandlers<CustomDirectionRecognizer>(
            () => CustomDirectionRecognizer(),
            (instance) {
              instance.onDirectionLocked = (axis) {
                if (axis != _lockedAxis) {
                  setState(() {
                    _lockedAxis = axis;
                  });
                }
              };
            },
          ),
        },
        behavior: HitTestBehavior.translucent,
        child: _lockedAxis == Axis.vertical
            ? VerticalPageView(onSwitchToHorizontal: () {
                setState(() => _lockedAxis = Axis.horizontal);
              })
            : HorizontalPageView(onSwitchToVertical: () {
                setState(() => _lockedAxis = Axis.vertical);
              }),
      ),
    );
  }
}


class CustomDirectionRecognizer extends OneSequenceGestureRecognizer {
  Offset _startPoint = Offset.zero;
  bool _hasLocked = false;
  void Function(Axis)? onDirectionLocked;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
    _startPoint = event.position;
    _hasLocked = false;
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent && !_hasLocked) {
      final delta = event.position - _startPoint;
      final angle = delta.direction;

      if (delta.distance > 10) {
        final isVertical = angle.abs() > math.pi / 4 && angle.abs() < 3 * math.pi / 4;
        final axis = isVertical ? Axis.vertical : Axis.horizontal;

        _hasLocked = true;
        onDirectionLocked?.call(axis);
      }
    }
  }

  @override
  String get debugDescription => 'CustomDirectionRecognizer';
  @override
  void didStopTrackingLastPointer(int pointer) {}
}


class VerticalPageView extends StatelessWidget {
  final VoidCallback onSwitchToHorizontal;

  const VerticalPageView({super.key, required this.onSwitchToHorizontal});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 3,
      physics: VideoScrollPhysics(),
      itemBuilder: (_, i) => GestureDetector(
        onHorizontalDragStart: (_) => onSwitchToHorizontal(),
        child: Container(
          color: Colors.primaries[i % Colors.primaries.length],
          child: Center(child: Text('Vertical Page $i')),
        ),
      ),
    );
  }
}

class HorizontalPageView extends StatelessWidget {
  final VoidCallback onSwitchToVertical;

  const HorizontalPageView({super.key, required this.onSwitchToVertical});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      physics: VideoScrollPhysics(),
      itemCount: 3,
      itemBuilder: (_, i) => GestureDetector(
        onVerticalDragStart: (_) => onSwitchToVertical(),
        child: Container(
          color: Colors.accents[i % Colors.accents.length],
          child: Center(child: Text('Horizontal Page $i')),
        ),
      ),
    );
  }
}
