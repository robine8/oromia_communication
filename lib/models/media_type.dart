import 'package:flutter/material.dart';

enum MediaType {
  pressRelease,
  documentary,
  video,
  imageGallery,
  audioFiles,
}

extension MediaTypeExtension on MediaType {
  String get displayName {
    switch (this) {
      case MediaType.pressRelease:
        return 'Press Release';
      case MediaType.documentary:
        return 'Documentary';
      case MediaType.video:
        return 'Video';
      case MediaType.imageGallery:
        return 'Image & Gallery';
      case MediaType.audioFiles:
        return 'Audio Files';
    }
  }

  String get apiTypeSlug {
    switch (this) {
      case MediaType.pressRelease:
        return 'press-release';
      case MediaType.documentary:
        return 'documentary';
      case MediaType.video:
        return 'video';
      case MediaType.imageGallery:
        return 'image-gallery';
      case MediaType.audioFiles:
        return 'audio-files';
    }
  }

  String get subtitle {
    switch (this) {
      case MediaType.pressRelease:
        return 'Our recent press releases';
      case MediaType.documentary:
        return 'Our recent documentaries';
      case MediaType.video:
        return 'Our recent videos';
      case MediaType.imageGallery:
        return 'Our recent galleries';
      case MediaType.audioFiles:
        return 'Our recent audio files';
    }
  }

  IconData get icon {
    switch (this) {
      case MediaType.pressRelease:
        return Icons.description;
      case MediaType.documentary:
        return Icons.movie;
      case MediaType.video:
        return Icons.play_circle_filled;
      case MediaType.imageGallery:
        return Icons.photo_library;
      case MediaType.audioFiles:
        return Icons.audiotrack;
    }
  }
}