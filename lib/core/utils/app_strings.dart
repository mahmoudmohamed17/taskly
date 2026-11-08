class AppStrings {
  AppStrings._();

  // Common
  static const String appName = 'common.appName';
  static const String tagline = 'common.tagline';
  static const String close = 'common.close';
  static const String next = 'common.next';
  static const String back = 'common.back';
  static const String skip = 'common.skip';
  static const String start = 'common.start';
  static const String save = 'common.save';
  static const String edit = 'common.edit';
  static const String delete = 'common.delete';
  static const String secureLocal = 'common.secureLocal';
  static const String requiredField = 'common.requiredField';

  // Onboarding
  static const String onboardingStep1Title = 'onboarding.step1.title';
  static const String onboardingStep1SubTitle = 'onboarding.step1.subTitle';
  static const String onboardingStep1Description = 'onboarding.step1.description';

  static const String onboardingStep2Title = 'onboarding.step2.title';
  static const String onboardingStep2SubTitle = 'onboarding.step2.subTitle';
  static const String onboardingStep2Description = 'onboarding.step2.description';

  static const String onboardingStep3Title = 'onboarding.step3.title';
  static const String onboardingStep3SubTitle = 'onboarding.step3.subTitle';
  static const String onboardingStep3Description = 'onboarding.step3.description';

  // Home
  static const String homeGreeting = 'home.greeting';
  static const String homeHeadline = 'home.headline';
  static const String homeSearchPlaceholder = 'home.searchPlaceholder';
  static const String homeNoMemories = 'home.noMemories';
  static const String homeClearSearch = 'home.clearSearch';
  static const String homeVoiceEyebrow = 'home.voiceEyebrow';
  static const String homeVoiceTitle = 'home.voiceTitle';
  static const String homeVoiceDescription = 'home.voiceDescription';
  static const String homeStartListening = 'home.startListening';
  static const String homeMemoriesTitle = 'home.memoriesTitle';
  static const String homeMemoriesCount = 'home.memoriesCount';
  static const String homeViewAll = 'home.viewAll';
  static const String homeEmptyDescription = 'home.emptyDescription';
  static const String homePrivacyTitle = 'home.privacyTitle';
  static const String homePrivacyDescription = 'home.privacyDescription';

  // Search
  static const String searchLabel = 'searchPage.label';
  static const String searchBack = 'searchPage.back';
  static const String searchTitle = 'searchPage.title';
  static const String searchSubtitle = 'searchPage.subtitle';
  static const String searchPromptTitle = 'searchPage.promptTitle';
  static const String searchPromptDescription = 'searchPage.promptDescription';
  static const String searchRecentTitle = 'searchPage.recentTitle';
  static const String searchClearRecent = 'searchPage.clearRecent';
  static const String searchVoiceTipTitle = 'searchPage.voiceTipTitle';
  static const String searchVoiceTipDescription = 'searchPage.voiceTipDescription';
  static const String searchVoiceResults = 'searchPage.voiceSearchResults';
  static const String searchResultsTitle = 'searchPage.resultsTitle';
  static const String searchResultsCount = 'searchPage.resultsCount';
  static const String searchEmptyTitle = 'searchPage.emptyTitle';
  static const String searchEmptyDescription = 'searchPage.emptyDescription';
  static const String searchReset = 'searchPage.reset';

  // Categories
  static const String categoriesAll = 'categories.all';
  static const String categoriesMedical = 'categories.medical';
  static const String categoriesFinancial = 'categories.financial';
  static const String categoriesFamily = 'categories.family';
  static const String categoriesFriends = 'categories.friends';
  static const String categoriesPersonal = 'categories.personal';
  static const String categoriesOther = 'categories.other';

  // Voice
  static const String voiceDialogLabel = 'voice.dialogLabel';
  static const String voiceTitle = 'voice.title';
  static const String voiceDescription = 'voice.description';
  static const String voiceListening = 'voice.listening';
  static const String voiceNoMatch = 'voice.noMatch';
  static const String voiceServiceNotAvailable = 'voice.serviceNotAvailable';

  // Memory
  static const String memoryDetailsLabel = 'memory.detailsLabel';
  static const String memoryDetails = 'memory.details';
  static const String memoryAttachments = 'memory.attachments';
  static const String memoryCreatedAt = 'memory.createdAt';
  static const String memoryUpdatedAt = 'memory.updatedAt';
  static const String memoryReminder = 'memory.reminder';
  static const String memoryOpenAttachment = 'memory.openAttachment';
  static const String memoryRecallByVoice = 'memory.recallByVoice';
  static const String memoryNoAttachments = 'memory.noAttachments';
  static const String memoryDeleted = 'memory.memoryDeleted';
  static const String memoryLocalData = 'memory.localData';

  // Add Memory
  static const String addMemoryDialogLabel = 'addMemory.dialogLabel';
  static const String addMemoryTitle = 'addMemory.title';
  static const String addMemorySubtitle = 'addMemory.subtitle';
  static const String addMemoryNameLabel = 'addMemory.nameLabel';
  static const String addMemoryNamePlaceholder = 'addMemory.namePlaceholder';
  static const String addMemoryDetailsLabel = 'addMemory.detailsLabel';
  static const String addMemoryDetailsPlaceholder = 'addMemory.detailsPlaceholder';
  static const String addMemoryCategoryLabel = 'addMemory.categoryLabel';
  static const String addMemoryCategoryHint = 'addMemory.categoryHint';
  static const String addMemoryCategoryNotSet = 'addMemory.categoryNotSet';
  static const String addMemoryAttachmentTitle = 'addMemory.attachmentTitle';
  static const String addMemoryAttachmentTypes = 'addMemory.attachmentTypes';
  static const String addMemoryAttachmentCount = 'addMemory.attachmentCount';
  static const String addMemorySave = 'addMemory.save';
  static const String addMemorySaved = 'addMemory.saved';

  // Edit Memory
  static const String editMemoryTitle = 'editMemory.title';
  static const String editMemoryUpdate = 'editMemory.update';
  static const String editMemoryCancel = 'editMemory.cancel';
  static const String editMemoryStatusTitle = 'editMemory.statusTitle';
  static const String editMemoryStatusDescription = 'editMemory.statusDescription';
  static const String editMemoryUpdatedSuccessfully = 'editMemory.updatedSuccessfully';

  // Theme
  static const String themeLight = 'theme.light';
  static const String themeDark = 'theme.dark';

  // Errors - generic
  static const String errorUnknown = 'errors.unknown';

  // Errors - storage / database
  static const String errorStorageReadFailed = 'errors.storage.readFailed';
  static const String errorStorageWriteFailed = 'errors.storage.writeFailed';
  static const String errorStorageDeleteFailed = 'errors.storage.deleteFailed';
  static const String errorDatabaseCorrupted = 'errors.storage.databaseCorrupted';
  static const String errorInsufficientStorage = 'errors.storage.insufficientStorage';

  // Errors - file system
  static const String errorFileNotFound = 'errors.file.notFound';
  static const String errorFileAccessDenied = 'errors.file.accessDenied';
  static const String errorFileTooLarge = 'errors.file.tooLarge';
  static const String errorUnsupportedFileType = 'errors.file.unsupportedType';
  static const String errorFileCopyFailed = 'errors.file.copyFailed';

  // Errors - voice
  static const String errorVoicePermissionDenied = 'errors.voice.permissionDenied';
  static const String errorVoiceNotAvailable = 'errors.voice.notAvailable';
  static const String errorVoiceTimeout = 'errors.voice.timeout';
  static const String errorVoiceRecognitionFailed = 'errors.voice.recognitionFailed';

  // Errors - validation
  static const String errorTitleRequired = 'errors.validation.titleRequired';
  static const String errorTitleTooLong = 'errors.validation.titleTooLong';
  static const String errorCategoryRequired = 'errors.validation.categoryRequired';
  static const String errorDetailsTooLong = 'errors.validation.detailsTooLong';

  // Errors - memory CRUD
  static const String errorMemoryNotFound = 'errors.memory.notFound';
  static const String errorMemorySaveFailed = 'errors.memory.saveFailed';
  static const String errorMemoryUpdateFailed = 'errors.memory.updateFailed';
  static const String errorMemoryDeleteFailed = 'errors.memory.deleteFailed';
  static const String errorMemoryAttachmentFailed = 'errors.memory.attachmentFailed';
}
