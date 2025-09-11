import 'package:blog/core/theme/appPalette.dart';
import 'package:blog/core/utils/calculate_reading_time.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  final VoidCallback onTap;

  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Sử dụng màu trắng cho tất cả chữ để nhất quán
    const textColor = AppPalette.whiteColor;

    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              Text(
                blog.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // Chủ đề (topics)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: blog.topics
                    .map(
                      (topic) => Chip(
                        label: Text(
                          topic,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor:
                            Colors.black26, // Màu đen mờ để nổi bật trên nền
                        side: BorderSide.none, // Bỏ viền
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero,
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 12),

              // Thời gian đọc
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    '${calulateReadingTime(blog.content)} min read',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
