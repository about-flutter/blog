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

  /// copyWith để update một số field mà không cần tạo mới toàn bộ
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

  /// Map -> BlogModel
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

  /// BlogModel -> Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
      // posterName không cần được lưu vào DB vì nó sẽ được join từ bảng profiles
    };
  }

  /// JSON string -> BlogModel
  factory BlogModel.fromJson(String source) =>
      BlogModel.fromMap(jsonDecode(source));

  /// BlogModel -> JSON string
  String toJson() => jsonEncode(toMap());
}
