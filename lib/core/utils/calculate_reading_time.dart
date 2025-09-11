int calulateReadingTime(String content) {
  final words = content.trim().split(RegExp(r'\s+')).length;
  final readingTime = (words / 200).ceil(); // Giả sử tốc độ đọc trung bình là 200 từ/phút
  return readingTime;
}