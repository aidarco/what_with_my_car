class ProblemModel {
  final String id;
  final String userId;
  final String description;
  final String problemName;
  final List<String> imageUrls;

  ProblemModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.problemName,
    this.imageUrls = const [],
  });
  factory ProblemModel.fromMap(Map<String, dynamic> data) {
    return ProblemModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      description: data['description'] as String,
      problemName: data['problemName'] as String,
      imageUrls: (data['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'description': description,
      'problemName': problemName,
      'imageUrls': imageUrls, // Include image URLs
    };
  }
  }