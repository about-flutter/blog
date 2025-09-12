import 'package:blog/core/error/exceptions.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  /// Upload a list of blogs to local storage
  Future<void> upLoadLocalBlogs({required List<BlogModel> blogs});

  /// Load blogs from local storage
  /// Throws [CacheException] if there's an error during loading
  Future<List<BlogModel>> loadBlogs();

  /// Clear all cached blogs
  Future<void> clearCache();

  /// Save a single blog to cache
  Future<void> saveBlog(BlogModel blog);

  /// Get a single blog by ID from cache
  /// Returns null if not found
  Future<BlogModel?> getBlogById(String id);
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  static const String _blogKeysKey = 'blog_keys';
  static const String _blogPrefix = 'blog_';

  @override
  Future<List<BlogModel>> loadBlogs() async {
    try {
      final blogKeys = box.get(_blogKeysKey);
      if (blogKeys == null) {
        return [];
      }

      List<BlogModel> blogs = [];
      for (String key in (blogKeys as List<String>)) {
        final blogData = box.get(key);
        if (blogData != null) {
          if (blogData is BlogModel) {
            blogs.add(blogData);
          } else {
            // For backward compatibility with old format
            blogs.add(BlogModel.fromJson(blogData));
          }
        }
      }

      return blogs;
    } catch (e) {
      throw CacheException('Error reading blogs from local storage: $e');
    }
  }

  @override
  Future<void> upLoadLocalBlogs({required List<BlogModel> blogs}) async {
    try {
      // Clear existing blogs
      await clearCache();

      // Store each blog with a prefixed key
      List<String> keys = [];
      for (final blog in blogs) {
        final key = _blogPrefix + blog.id;
        await box.put(key, blog);
        keys.add(key);
      }

      // Save list of keys for easy retrieval
      await box.put(_blogKeysKey, keys);
    } catch (e) {
      throw CacheException('Error saving blogs to local storage: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      // Get existing keys
      final blogKeys = box.get(_blogKeysKey);
      if (blogKeys != null) {
        // Delete each blog entry
        for (String key in (blogKeys as List<String>)) {
          await box.delete(key);
        }
      }

      // Clear the keys list
      await box.delete(_blogKeysKey);
    } catch (e) {
      throw CacheException('Error clearing blog cache: $e');
    }
  }

  @override
  Future<void> saveBlog(BlogModel blog) async {
    try {
      final key = _blogPrefix + blog.id;

      // Store the blog
      await box.put(key, blog);

      // Update keys list
      List<String> keys = [];
      final existingKeys = box.get(_blogKeysKey);
      if (existingKeys != null) {
        keys = List<String>.from(existingKeys);
        if (!keys.contains(key)) {
          keys.add(key);
        }
      } else {
        keys = [key];
      }

      await box.put(_blogKeysKey, keys);
    } catch (e) {
      throw CacheException('Error saving blog to cache: $e');
    }
  }

  @override
  Future<BlogModel?> getBlogById(String id) async {
    try {
      final key = _blogPrefix + id;
      final blogData = box.get(key);

      if (blogData == null) {
        return null;
      }

      if (blogData is BlogModel) {
        return blogData;
      } else {
        // For backward compatibility
        return BlogModel.fromJson(blogData);
      }
    } catch (e) {
      throw CacheException('Error getting blog from cache: $e');
    }
  }
}
