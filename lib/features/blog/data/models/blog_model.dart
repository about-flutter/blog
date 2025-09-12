// data/models/blog_model.dart
import 'dart:convert';
import 'package:blog/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    super.imageUrl,
    required super.topics,
    required super.updatedAt,
    super.posterName,
  });

  /// Create a copy of this BlogModel with specified fields replaced with new values
  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }

  /// Create a BlogModel from a map (typically from database or API)
  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String?,
      topics: List<String>.from(map['topics'] ?? []),
      updatedAt: DateTime.parse(map['updated_at']),
      posterName: map['profiles'] != null
          ? map['profiles']['name'] as String?
          : null,
    );
  }

  /// Convert this BlogModel to a map for database storage or API requests
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
      // posterName is not stored in DB as it's joined from profiles table
    };
  }

  /// Create a BlogModel from a JSON string
  factory BlogModel.fromJson(String source) =>
      BlogModel.fromMap(jsonDecode(source));

  /// Convert this BlogModel to a JSON string for local storage
  String toJson() => jsonEncode(toMap());

  @override
  String toString() => 'BlogModel(id: $id, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BlogModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
