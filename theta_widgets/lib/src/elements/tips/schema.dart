class TipObject {
  TipObject({
    required this.isVisible,
    required this.title,
    required this.description,
    required this.networkImage,
    required this.onTap,
  });

  final bool isVisible;
  final String title;
  final String description;
  final String networkImage;
  final Function() onTap;
}
