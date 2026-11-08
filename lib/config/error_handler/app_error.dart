import '../../core/utils/app_strings.dart';

/// All failure cases the app can encounter while operating offline-first.
///
/// The sealed class guarantees exhaustive handling in every switch/when that
/// consumes it — no silent fall-through to an unknown state.
sealed class AppError {
  const AppError();

  String get messageKey => switch (this) {
    _StorageReadFailed() => AppStrings.errorStorageReadFailed,
    _StorageWriteFailed() => AppStrings.errorStorageWriteFailed,
    _StorageDeleteFailed() => AppStrings.errorStorageDeleteFailed,
    _DatabaseCorrupted() => AppStrings.errorDatabaseCorrupted,
    _InsufficientStorage() => AppStrings.errorInsufficientStorage,
    _FileNotFound() => AppStrings.errorFileNotFound,
    _FileAccessDenied() => AppStrings.errorFileAccessDenied,
    _FileTooLarge() => AppStrings.errorFileTooLarge,
    _UnsupportedFileType() => AppStrings.errorUnsupportedFileType,
    _FileCopyFailed() => AppStrings.errorFileCopyFailed,
    _VoicePermissionDenied() => AppStrings.errorVoicePermissionDenied,
    _VoiceNotAvailable() => AppStrings.errorVoiceNotAvailable,
    _VoiceTimeout() => AppStrings.errorVoiceTimeout,
    _VoiceRecognitionFailed() => AppStrings.errorVoiceRecognitionFailed,
    _TitleRequired() => AppStrings.errorTitleRequired,
    _TitleTooLong() => AppStrings.errorTitleTooLong,
    _CategoryRequired() => AppStrings.errorCategoryRequired,
    _DetailsTooLong() => AppStrings.errorDetailsTooLong,
    _MemoryNotFound() => AppStrings.errorTaskNotFound,
    _MemorySaveFailed() => AppStrings.errorTaskSaveFailed,
    _MemoryUpdateFailed() => AppStrings.errorTaskUpdateFailed,
    _MemoryDeleteFailed() => AppStrings.errorTaskDeleteFailed,
    _MemoryAttachmentFailed() => AppStrings.errorTaskAttachmentFailed,
    _Unknown() => AppStrings.errorUnknown,
  };

  // ─── Storage / Database ───────────────────────────────────────────────────

  /// Drift (or any local-DB) read operation failed.
  const factory AppError.storageReadFailed({Object? cause}) = _StorageReadFailed;

  /// Drift write / insert / update operation failed.
  const factory AppError.storageWriteFailed({Object? cause}) = _StorageWriteFailed;

  /// Drift delete operation failed.
  const factory AppError.storageDeleteFailed({Object? cause}) = _StorageDeleteFailed;

  /// The SQLite database file is corrupted or cannot be opened.
  const factory AppError.databaseCorrupted({Object? cause}) = _DatabaseCorrupted;

  /// The device has insufficient free storage to complete an operation.
  const factory AppError.insufficientStorage({Object? cause}) = _InsufficientStorage;

  // ─── File System ──────────────────────────────────────────────────────────

  /// A referenced attachment file is missing from disk.
  const factory AppError.fileNotFound({Object? cause}) = _FileNotFound;

  /// The app lacks permission to access a file or directory.
  const factory AppError.fileAccessDenied({Object? cause}) = _FileAccessDenied;

  /// The selected file exceeds the maximum allowed size.
  const factory AppError.fileTooLarge({Object? cause}) = _FileTooLarge;

  /// The file has an extension or MIME type the app does not support.
  const factory AppError.unsupportedFileType({Object? cause}) = _UnsupportedFileType;

  /// Copying an attachment to the app's private storage failed.
  const factory AppError.fileCopyFailed({Object? cause}) = _FileCopyFailed;

  // ─── Voice / Microphone ───────────────────────────────────────────────────

  /// The user denied microphone permission.
  const factory AppError.voicePermissionDenied({Object? cause}) = _VoicePermissionDenied;

  /// The device does not support on-device speech recognition.
  const factory AppError.voiceNotAvailable({Object? cause}) = _VoiceNotAvailable;

  /// The voice session timed out without detecting any speech.
  const factory AppError.voiceTimeout({Object? cause}) = _VoiceTimeout;

  /// Speech was captured but could not be transcribed.
  const factory AppError.voiceRecognitionFailed({Object? cause}) = _VoiceRecognitionFailed;

  // ─── Validation ───────────────────────────────────────────────────────────

  /// The task title was left empty.
  const factory AppError.titleRequired() = _TitleRequired;

  /// The task title exceeds the maximum character limit.
  const factory AppError.titleTooLong() = _TitleTooLong;

  /// No category was selected before saving.
  const factory AppError.categoryRequired() = _CategoryRequired;

  /// The details text exceeds the maximum character limit.
  const factory AppError.detailsTooLong() = _DetailsTooLong;

  // ─── Task CRUD ───────────────────────────────────────────────────────────

  /// The requested task does not exist in the local DB (deleted elsewhere).
  const factory AppError.memoryNotFound({Object? cause}) = _MemoryNotFound;

  /// Creating a new task record failed.
  const factory AppError.memorySaveFailed({Object? cause}) = _MemorySaveFailed;

  /// Updating an existing task record failed.
  const factory AppError.memoryUpdateFailed({Object? cause}) = _MemoryUpdateFailed;

  /// Deleting a task record (and its files) failed.
  const factory AppError.memoryDeleteFailed({Object? cause}) = _MemoryDeleteFailed;

  /// Attaching a file to a task failed.
  const factory AppError.memoryAttachmentFailed({Object? cause}) = _MemoryAttachmentFailed;

  // ─── Catch-all ────────────────────────────────────────────────────────────

  /// An unexpected error that does not match any known category.
  const factory AppError.unknown({Object? cause}) = _Unknown;
}

// ─── Storage ─────────────────────────────────────────────────────────────────

final class _StorageReadFailed extends AppError {
  const _StorageReadFailed({this.cause});
  final Object? cause;
}

final class _StorageWriteFailed extends AppError {
  const _StorageWriteFailed({this.cause});
  final Object? cause;
}

final class _StorageDeleteFailed extends AppError {
  const _StorageDeleteFailed({this.cause});
  final Object? cause;
}

final class _DatabaseCorrupted extends AppError {
  const _DatabaseCorrupted({this.cause});
  final Object? cause;
}

final class _InsufficientStorage extends AppError {
  const _InsufficientStorage({this.cause});
  final Object? cause;
}

// ─── File System ─────────────────────────────────────────────────────────────

final class _FileNotFound extends AppError {
  const _FileNotFound({this.cause});
  final Object? cause;
}

final class _FileAccessDenied extends AppError {
  const _FileAccessDenied({this.cause});
  final Object? cause;
}

final class _FileTooLarge extends AppError {
  const _FileTooLarge({this.cause});
  final Object? cause;
}

final class _UnsupportedFileType extends AppError {
  const _UnsupportedFileType({this.cause});
  final Object? cause;
}

final class _FileCopyFailed extends AppError {
  const _FileCopyFailed({this.cause});
  final Object? cause;
}

// ─── Voice ───────────────────────────────────────────────────────────────────

final class _VoicePermissionDenied extends AppError {
  const _VoicePermissionDenied({this.cause});
  final Object? cause;
}

final class _VoiceNotAvailable extends AppError {
  const _VoiceNotAvailable({this.cause});
  final Object? cause;
}

final class _VoiceTimeout extends AppError {
  const _VoiceTimeout({this.cause});
  final Object? cause;
}

final class _VoiceRecognitionFailed extends AppError {
  const _VoiceRecognitionFailed({this.cause});
  final Object? cause;
}

// ─── Validation ──────────────────────────────────────────────────────────────

final class _TitleRequired extends AppError {
  const _TitleRequired();
}

final class _TitleTooLong extends AppError {
  const _TitleTooLong();
}

final class _CategoryRequired extends AppError {
  const _CategoryRequired();
}

final class _DetailsTooLong extends AppError {
  const _DetailsTooLong();
}

// ─── Task CRUD ─────────────────────────────────────────────────────────────

final class _MemoryNotFound extends AppError {
  const _MemoryNotFound({this.cause});
  final Object? cause;
}

final class _MemorySaveFailed extends AppError {
  const _MemorySaveFailed({this.cause});
  final Object? cause;
}

final class _MemoryUpdateFailed extends AppError {
  const _MemoryUpdateFailed({this.cause});
  final Object? cause;
}

final class _MemoryDeleteFailed extends AppError {
  const _MemoryDeleteFailed({this.cause});
  final Object? cause;
}

final class _MemoryAttachmentFailed extends AppError {
  const _MemoryAttachmentFailed({this.cause});
  final Object? cause;
}

// ─── Unknown ─────────────────────────────────────────────────────────────────

final class _Unknown extends AppError {
  const _Unknown({this.cause});
  final Object? cause;
}
