class TaskModel{
  final int id;
  final String description;
  final String created_at;
  final String deleted_at;
  final String updated_at;
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