class CourseDataModel {
  String name;
  String description;
  String category;

  CourseDataModel({
    required this.name,
    required this.description,
    required this.category,
  });

  factory CourseDataModel.fromDoc(Map<String, dynamic> doc) {
    return CourseDataModel(
      name: doc['name'],
      description: doc['description'],
      category: doc['category'],
    );
  }
}
