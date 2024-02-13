class TaskModel{
  final int id;
  final String description;
  final DateTime created_at;
  final DateTime deleted_at;
  final DateTime updated_at;
  final bool isCompleted;


  TaskModel({
    required this.id,
    required this.description,
    required this.created_at,
    required this.updated_at,
    required this.deleted_at,
    required this.isCompleted,
  });
}