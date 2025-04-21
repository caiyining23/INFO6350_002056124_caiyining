class Post {
  final String title;
  final String price;
  final String description;
  final List<String> imageUrls;

  Post({
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrls,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      title: map['title'] ?? '',
      price: map['price'] ?? '',
      description: map['description'] ?? '',
      imageUrls: List<String>.from(map['images'] ?? []),
    );
  }
}
