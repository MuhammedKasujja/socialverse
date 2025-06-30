import 'package:flutter/material.dart';

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
            color: Colors
                .primaries[(widget.index + detailIndex) %
                    Colors.primaries.length]
                .withOpacity(0.9),
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
