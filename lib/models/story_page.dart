class StoryPage {
  final int pageNumber;
  final String textTemplate;
  final String backgroundImagePath;

  StoryPage({
    required this.pageNumber,
    required this.textTemplate,
    required this.backgroundImagePath,
  });

  String getPersonalizedText(String name) {
    return textTemplate.replaceAll('{NAME}', name);
  }
}
