class CategoryDataModel {
  final String name;
  final String? image;
  CategoryDataModel({
    required this.name,
    required this.image,
  });

  factory CategoryDataModel.fromDoc(Map<String, dynamic> json) {
    return CategoryDataModel(
      name: json['name'],
      image: json['image'],
    );
  }
}
