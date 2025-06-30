
import 'dart:math';

import 'package:flutter/material.dart';

class PageNode {
  String value;
  final List<PageNode> children;

  PageNode({required this.value,this.children = const []});
}


class RecursivePageView extends StatelessWidget {
  final PageNode node;
  final Axis axis;

  const RecursivePageView({
    super.key,
    required this.node,
    this.axis = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    if (node.children.isEmpty) {
      // Leaf node – just a colored container
      return Container(
        color: Colors.primaries[node.hashCode % Colors.primaries.length],
        alignment: Alignment.center,
        child: Text(
          'Leaf ${node.hashCode}',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      );
    }

    return PageView(
      scrollDirection: axis,
      children: node.children.map((child) {
        // Alternate axis on each level
        return RecursivePageView(
          node: child,
          axis: axis == Axis.vertical ? Axis.horizontal : Axis.vertical,
        );
      }).toList(),
    );
  }
}


class TreeViewExample extends StatelessWidget {
  const TreeViewExample({super.key});

  PageNode buildTree(int depth, int breadth) {
    if (depth == 0) return PageNode(value: 'Last');

    return PageNode(
      value: String.fromCharCode(Random().nextInt(40000)),
      children: List.generate(
        breadth,
        (_) => buildTree(depth - 1, breadth),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tree = buildTree(3, 2); // 3 levels deep, 2 children each

    return Scaffold(body: RecursivePageView(node: tree));
  }
}

