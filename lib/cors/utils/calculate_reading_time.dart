int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  const readingSpeed = 225;

  final readingTime = wordCount / readingSpeed;


  return readingTime.ceil();
}
