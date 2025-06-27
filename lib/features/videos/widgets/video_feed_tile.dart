import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialverse/features/videos/domain/models/video_feed_model.dart';

class VideoFeedTile extends StatefulWidget {
  final VideoFeedModel video;
  final VoidCallback onTap;
  final bool isSuperLiked;
  final int horizontalOffset;
  final bool isFromSwipeMagic;
  const VideoFeedTile({
    super.key,
    required this.video,
    required this.onTap,
    required this.horizontalOffset,
    this.isSuperLiked = false,
    this.isFromSwipeMagic = false,
  });

  @override
  State<VideoFeedTile> createState() => _VideoFeedTileState();
}

class _VideoFeedTileState extends State<VideoFeedTile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            height: 650.h,
            child: CachedNetworkImage(
              imageUrl: widget.video.thumbnailUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          if (widget.horizontalOffset > 0)
            Positioned(
              top: 25,
              left: 25,
              child: Opacity(
                opacity: min(((widget.horizontalOffset) / 100), 1),
                child: Container(
                  height: 40,
                  width: 90,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Right',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          if (widget.horizontalOffset < 0)
            Positioned(
              top: 25,
              right: 25,
              child: Opacity(
                opacity: min((widget.horizontalOffset * -1) / 100, 1),
                child: Container(
                  height: 40,
                  width: 100,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Left',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
