// domain/entities/blog.dart

/// Entity class representing a blog post
///
/// This is the core domain entity that should be used
/// throughout the application's business logic
class Blog {
  /// Unique identifier for the blog post
  final String id;

  /// ID of the user who created this blog post
  final String posterId;

  /// Title of the blog post
  final String title;

  /// Main content of the blog post
  final String content;

  /// URL to the blog post's featured image (optional)
  final String? imageUrl;

  /// List of topics/tags associated with this blog post
  final List<String> topics;

  /// When the blog post was last updated
  final DateTime updatedAt;

  /// Name of the poster (optional, may be populated from a join)
  final String? posterName;

  Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.topics,
    required this.updatedAt,
    this.posterName,
  });

  /// Calculate the reading time in minutes for this blog post
  int get readingTimeMinutes {
    const wordsPerMinute = 200;
    final wordCount = content.split(' ').length;
    return (wordCount / wordsPerMinute).ceil();
  }
}
