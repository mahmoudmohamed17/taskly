import 'package:json_annotation/json_annotation.dart';

import '../utils/enums.dart';
import 'attachment_model.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  final int id;
  final String title;
  final String description;
  final TaskCategory category;
  final List<AttachmentModel> attachments;
  final DateTime creationDate;
  final DateTime? lastUpdateDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.creationDate,
    this.category = TaskCategory.other,
    this.attachments = const [],
    this.lastUpdateDate,
  });

  factory TaskModel.mock({
    int id = 1,
    String title = 'Sample Memory',
    String description = 'This is a mock memory description used for preview and testing purposes.',
    TaskCategory category = TaskCategory.other,
    List<AttachmentModel> attachments = const [],
  }) {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      category: category,
      attachments: attachments,
      creationDate: DateTime.now(),
    );
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    TaskCategory? category,
    DateTime? creationDate,
    DateTime? lastUpdateDate,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      creationDate: creationDate ?? this.creationDate,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
    );
  }

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}

final mockMemories = [
  TaskModel(
    id: 1,
    title: 'Ahmed\'s Birthday',
    description: 'Ahmed\'s birthday is on March 15th. He loves chocolate cake and anything related to football.',
    category: TaskCategory.friends,
    creationDate: DateTime(2024, 1, 10),
    lastUpdateDate: DateTime(2024, 6),
  ),
  TaskModel(
    id: 2,
    title: 'Monthly Rent Payment',
    description: 'Rent is due on the 1st of every month. Amount: 5,500 EGP. Transfer to account 0123456789.',
    category: TaskCategory.financial,
    creationDate: DateTime(2024, 2),
  ),
  TaskModel(
    id: 3,
    title: 'Mom\'s Medication',
    description: 'Mom takes Concor 5mg every morning after breakfast and Lipitor 20mg at night before sleep.',
    category: TaskCategory.family,
    creationDate: DateTime(2024, 3, 20),
    lastUpdateDate: DateTime(2024, 9, 5),
  ),
  TaskModel(
    id: 4,
    title: 'Annual Blood Test',
    description: 'Schedule yearly blood work: CBC, lipid panel, blood sugar, and thyroid levels. Last done: Jan 2024.',
    category: TaskCategory.medical,
    creationDate: DateTime(2024, 1, 15),
  ),
  TaskModel(
    id: 5,
    title: 'Book Reading Goal',
    description: 'Goal: read 12 books this year. Currently on book 7 — "Atomic Habits" by James Clear.',
    category: TaskCategory.personal,
    creationDate: DateTime(2024),
    lastUpdateDate: DateTime(2024, 8, 12),
  ),
  TaskModel(
    id: 6,
    title: 'WiFi Password',
    description: 'Home WiFi — Network: HomeNet_5G | Password: MySecure@2024. Router admin: 192.168.1.1',
    creationDate: DateTime(2024, 4, 3),
  ),
  TaskModel(
    id: 7,
    title: 'Sara\'s Allergy',
    description:
        'Sara is allergic to penicillin and shellfish. Always remind her before ordering food or prescribing medicine.',
    category: TaskCategory.family,
    creationDate: DateTime(2023, 11, 22),
    lastUpdateDate: DateTime(2024, 2, 18),
  ),
  TaskModel(
    id: 8,
    title: 'Emergency Fund',
    description: 'Emergency fund target: 50,000 EGP. Currently saved: 32,000 EGP. Monthly contribution: 2,000 EGP.',
    category: TaskCategory.financial,
    creationDate: DateTime(2024, 5, 10),
  ),
];
