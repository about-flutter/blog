import 'package:blog/core/theme/appPalette.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:blog/core/utils/calculate_reading_time.dart';
class BlogDetailScreen extends StatelessWidget {
  final Blog blog;
  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(blog.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (blog.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  blog.imageUrl!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              blog.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'By ${blog.posterName ?? 'Unknown Author'}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const Spacer(),
                Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
              
                const SizedBox(width: 4),
                Text(
                  _formatDate(blog.updatedAt),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                 const SizedBox(width: 4),
                  Text(
                    '${calulateReadingTime(blog.content)} min read',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: blog.topics
                  .map(
                    (topic) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppPalette.gradient2,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        topic,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            Text(
              blog.content,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
