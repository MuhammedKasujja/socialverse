import 'package:flutter/material.dart';

class DynamicVideoScreen extends StatefulWidget {
  const DynamicVideoScreen({super.key});

  @override
  State<DynamicVideoScreen> createState() => _DynamicVideoScreenState();
}

class _DynamicVideoScreenState extends State<DynamicVideoScreen> {
  final PageController _pageController = PageController();
  Axis _scrollDirection = Axis.vertical;

  int _currentPage = 0;

  void _switchToHirizontal() {
    setState(() {
      _scrollDirection = Axis.horizontal;
    });
  }

  void _switchToVertical() {
    setState(() {
      _scrollDirection = Axis.vertical;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! < 0) {
              // Swipe left
              _switchToHirizontal();
            } else {
              // Swipe right
              _switchToVertical();
            }
          }
        },
        child: PageView.builder(
          key: ValueKey(_scrollDirection),
          controller: _pageController,
          scrollDirection: _scrollDirection,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.primaries[index % Colors.primaries.length],
              alignment: Alignment.center,
              child: Text(
                'Page $index\n(${_scrollDirection == Axis.vertical ? "Vertical" : "Horizontal"})',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
