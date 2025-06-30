import 'package:flutter/material.dart';
import 'dart:math' as math;

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (_, index) => FourWaySwipeHandler(index: index),
      ),
    );
  }
}

class FourWaySwipeHandler extends StatefulWidget {
  final int index;

  const FourWaySwipeHandler({super.key, required this.index});

  @override
  State<FourWaySwipeHandler> createState() => _FourWaySwipeHandlerState();
}

class _FourWaySwipeHandlerState extends State<FourWaySwipeHandler> {
  Axis _direction = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final dx = details.delta.dx.abs();
        final dy = details.delta.dy.abs();

        if (_direction == Axis.horizontal && dy > dx) {
          setState(() => _direction = Axis.vertical);
        } else if (_direction == Axis.vertical && dx > dy) {
          setState(() => _direction = Axis.horizontal);
        }
      },
      child: _direction == Axis.horizontal
          ? HorizontalCarousel(
              index: widget.index,
              onSwipeUp: () => setState(() => _direction = Axis.vertical),
            )
          : VerticalDetailsView(
              index: widget.index,
              onExit: () => setState(() => _direction = Axis.horizontal),
            ),
    );
  }
}


class HorizontalCarousel extends StatelessWidget {
  final int index;
  final VoidCallback onSwipeUp;

  const HorizontalCarousel({
    super.key,
    required this.index,
    required this.onSwipeUp,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (_, i) {
        return GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.delta.dy < -10) {
              onSwipeUp();
            }
          },
          child: Container(
            color: Colors.primaries[(index + i) % Colors.primaries.length],
            child: ListView.builder(
              itemCount: 20,
              padding: const EdgeInsets.all(32),
              itemBuilder: (_, j) => Text(
                'Feed $index - Page $i - Item $j',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}


class VerticalDetailsView extends StatefulWidget {
  final int index;
  final VoidCallback onExit;

  const VerticalDetailsView({
    super.key,
    required this.index,
    required this.onExit,
  });

  @override
  State<VerticalDetailsView> createState() => _VerticalDetailsViewState();
}

class _VerticalDetailsViewState extends State<VerticalDetailsView> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      scrollDirection: Axis.vertical,
      itemCount: 3,
      itemBuilder: (_, i) {
        if (i == 0) {
          return GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.delta.dy > 10) widget.onExit();
            },
            child: Container(
              color: Colors.grey[900],
              alignment: Alignment.center,
              child: const Text(
                'Intro Page (Swipe up to continue)\nSwipe down to exit',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.primaries[(widget.index + i) % Colors.primaries.length],
            child: ListView.builder(
              itemCount: 20,
              padding: const EdgeInsets.all(32),
              itemBuilder: (_, j) => Text(
                'Detail Page $i - Item $j',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
    );
  }
}
