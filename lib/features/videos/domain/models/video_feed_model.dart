class VideoFeedModel {
  int id;
  Category? category;
  String slug;
  int? parentVideoId;
  int childVideoCount;
  String title;
  String identifier;
  int commentCount;
  int upvoteCount;
  int viewCount;
  int shareCount;
  int tagCount;
  String videoLink;
  bool isLocked;
  int createdAt;
  String firstName;
  String lastName;
  String username;
  bool upvoted;
  bool bookmarked;
  String thumbnailUrl;
  bool following;
  String pictureUrl;
  int votingCount;
  List<dynamic> votings;
  List<dynamic> tags;

  VideoFeedModel({
    required this.id,
    required this.category,
    required this.slug,
    required this.parentVideoId,
    required this.childVideoCount,
    required this.title,
    required this.identifier,
    required this.commentCount,
    required this.upvoteCount,
    required this.viewCount,
    required this.shareCount,
    required this.tagCount,
    required this.videoLink,
    required this.isLocked,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.upvoted,
    required this.bookmarked,
    required this.thumbnailUrl,
    required this.following,
    required this.pictureUrl,
    required this.votingCount,
    required this.votings,
    required this.tags,
  });

  factory VideoFeedModel.fromJson(Map<String, dynamic> json) => VideoFeedModel(
        id: json["id"],
        category: json["category"] is List
            ? null
            : Category.fromJson(json["category"]),
        slug: json["slug"],
        parentVideoId: json["parent_video_id"],
        childVideoCount: json["child_video_count"],
        title: json["title"],
        identifier: json["identifier"],
        commentCount: json["comment_count"],
        upvoteCount: json["upvote_count"],
        viewCount: json["view_count"],
        shareCount: json["share_count"],
        tagCount: json["tag_count"],
        videoLink: json["video_link"],
        isLocked: json["is_locked"],
        createdAt: json["created_at"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        upvoted: json["upvoted"],
        bookmarked: json["bookmarked"],
        thumbnailUrl: json["thumbnail_url"],
        following: json["following"],
        pictureUrl: json["picture_url"],
        votingCount: json["voting_count"],
        votings: List<dynamic>.from(json["votings"].map((x) => x)),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category?.toJson(),
        "slug": slug,
        "parent_video_id": parentVideoId,
        "child_video_count": childVideoCount,
        "title": title,
        "identifier": identifier,
        "comment_count": commentCount,
        "upvote_count": upvoteCount,
        "view_count": viewCount,
        "share_count": shareCount,
        "tag_count": tagCount,
        "video_link": videoLink,
        "is_locked": isLocked,
        "created_at": createdAt,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "upvoted": upvoted,
        "bookmarked": bookmarked,
        "thumbnail_url": thumbnailUrl,
        "following": following,
        "picture_url": pictureUrl,
        "voting_count": votingCount,
        "votings": List<dynamic>.from(votings.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };

  bool get hasMoreVideoFeed => childVideoCount > 0;
}

class Category {
  int id;
  String name;
  int count;
  String description;
  String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.count,
    required this.description,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        count: json["count"],
        description: json["description"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "count": count,
        "description": description,
        "image_url": imageUrl,
      };
}
