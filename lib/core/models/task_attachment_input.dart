import 'dart:io';

import '../utils/enums.dart';

class TaskAttachmentInput {
  const TaskAttachmentInput({
    required this.file,
    required this.name,
    required this.type,
    required this.sizeBytes,
  });

  final File file;
  final String name;
  final AttachmentType type;
  final int sizeBytes;
}
