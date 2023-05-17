class Category {
  static int countCategories = 11;
  late String id;
  final String title;
  final String image;

  Category({
    required this.id,
    required this.title,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

  static Category fromMap(Map<String, dynamic> categoryMap) {
    return Category(
      id: categoryMap['id'].toString(),
      title: categoryMap['title'],
      image: categoryMap['image'],
    );
  }

  @override
  String toString() {
    return 'Category{id: $id, title: $title, image: $image}';
  }
}
