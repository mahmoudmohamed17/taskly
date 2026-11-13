import 'package:material_ui/material_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme/app_colors.dart';
import 'app_strings.dart';

enum TaskCategory {
  medical(
    icon: Icons.medical_services_outlined,
    label: AppStrings.categoriesMedical,
    categoryColors: AppCategoryColors.medical,
  ),
  financial(
    icon: Icons.attach_money_outlined,
    label: AppStrings.categoriesFinancial,
    categoryColors: AppCategoryColors.financial,
  ),
  family(
    icon: Icons.family_restroom,
    label: AppStrings.categoriesFamily,
    categoryColors: AppCategoryColors.family,
  ),
  friends(
    icon: Icons.people_outline,
    label: AppStrings.categoriesFriends,
    categoryColors: AppCategoryColors.friends,
  ),
  personal(
    icon: Icons.person_outline,
    label: AppStrings.categoriesPersonal,
    categoryColors: AppCategoryColors.personal,
  ),
  other(
    icon: Icons.other_houses_outlined,
    label: AppStrings.categoriesOther,
    categoryColors: AppCategoryColors.other,
  );

  const TaskCategory({required this.icon, required this.label, required this.categoryColors});

  /// The icon that visually represents this category.
  final IconData icon;

  /// Human-readable display name (e.g. for chips / pickers).
  final String label;

  /// The semantic colors associated with this category.
  final AppCategoryColors categoryColors;
}

enum AttachmentType {
  pdf(label: 'PDF', icon: FontAwesomeIcons.filePdf, colors: MemoryFileColor.pdf),
  docx(label: 'DOCX', icon: FontAwesomeIcons.fileWord, colors: MemoryFileColor.docx),
  audio(label: 'MP3', icon: FontAwesomeIcons.itunesNote, colors: MemoryFileColor.audio),
  jpg(label: 'JPG', icon: FontAwesomeIcons.image, colors: MemoryFileColor.image),
  png(label: 'PNG', icon: FontAwesomeIcons.image, colors: MemoryFileColor.image),
  video(label: 'MP4', icon: FontAwesomeIcons.video, colors: MemoryFileColor.video);

  final String label;
  final FaIconData icon;
  final MemoryFileColor colors;

  const AttachmentType({
    required this.label,
    required this.icon,
    required this.colors,
  });

  static AttachmentType fromExtension(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'pdf':
        return AttachmentType.pdf;
      case 'doc':
      case 'docx':
        return AttachmentType.docx;
      case 'mp3':
        return AttachmentType.audio;
      case 'jpg':
      case 'jpeg':
        return AttachmentType.jpg;
      case 'png':
        return AttachmentType.png;
      case 'mp4':
        return AttachmentType.video;
      default:
        return AttachmentType.png;
    }
  }
}
