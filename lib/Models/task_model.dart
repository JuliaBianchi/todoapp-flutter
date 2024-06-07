class TaskModel{
  final int? id;
  final String? description;
  final int? category;
  final String? created_at;

  TaskModel({
    required this.id,
    required this.description,
    required this.category,
    required this.created_at,

  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'description': description,
      'category': category,
      'created_at': created_at,
    };
  }
}