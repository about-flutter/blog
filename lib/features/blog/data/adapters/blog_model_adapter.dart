import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

/// Hive adapter to serialize and deserialize BlogModel objects
///
/// This adapter handles the conversion between Hive binary format and BlogModel
class BlogModelAdapter extends TypeAdapter<BlogModel> {
  @override
  final typeId = 0; // Unique ID for this adapter

  @override
  BlogModel read(BinaryReader reader) {
    // Read data from binary format and construct a BlogModel
    final map = reader.readMap().cast<String, dynamic>();

    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String?,
      topics: List<String>.from(map['topics'] ?? []),
      updatedAt: DateTime.parse(map['updated_at']),
      posterName: map['poster_name'] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BlogModel obj) {
    // Convert BlogModel to map and write to binary
    final map = {
      'id': obj.id,
      'poster_id': obj.posterId,
      'title': obj.title,
      'content': obj.content,
      'image_url': obj.imageUrl,
      'topics': obj.topics,
      'updated_at': obj.updatedAt.toIso8601String(),
      'poster_name': obj.posterName,
    };

    writer.writeMap(map);
  }
}
