import 'package:flutter/material.dart';

enum PublicationType {
  weekly,
  quarterly,
  yearlyBook,
  brochure,
  archive,
  filesAndBooks,
}

extension PublicationTypeExtension on PublicationType {
  String get displayName {
    switch (this) {
      case PublicationType.weekly:
        return 'Weekly Newspaper';
      case PublicationType.quarterly:
        return 'Quarterly Newspaper';
      case PublicationType.yearlyBook:
        return 'Yearly Book';
      case PublicationType.brochure:
        return 'Brochure';
      case PublicationType.archive:
        return 'Archive';
      case PublicationType.filesAndBooks:
        return 'Files & Books';
    }
  }

  String get apiTypeSlug {
    switch (this) {
      case PublicationType.weekly:
        return 'weekly';
      case PublicationType.quarterly:
        // TODO: Confirm quarterly vs monthly slug with backend team
        return 'monthly';
      case PublicationType.yearlyBook:
        return 'yearly';
      case PublicationType.brochure:
        return 'brochure';
      case PublicationType.archive:
        return 'archive';
      case PublicationType.filesAndBooks:
        return 'file';
    }
  }

  String get subtitle {
    switch (this) {
      case PublicationType.weekly:
        return 'Browse our weekly newspaper archive';
      case PublicationType.quarterly:
        return 'Browse our quarterly newspaper archive';
      case PublicationType.yearlyBook:
        return 'Browse our yearly book collection';
      case PublicationType.brochure:
        return 'Browse our brochure collection';
      case PublicationType.archive:
        return 'Browse our complete archive';
      case PublicationType.filesAndBooks:
        return 'Browse our files and books collection';
    }
  }

  IconData get icon {
    switch (this) {
      case PublicationType.weekly:
        return Icons.newspaper;
      case PublicationType.quarterly:
        return Icons.calendar_month;
      case PublicationType.yearlyBook:
        return Icons.book;
      case PublicationType.brochure:
        return Icons.broken_image;
      case PublicationType.archive:
        return Icons.archive;
      case PublicationType.filesAndBooks:
        return Icons.folder;
    }
  }
}