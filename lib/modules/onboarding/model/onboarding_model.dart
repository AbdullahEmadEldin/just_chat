import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final List<SubtitleModel> subtitles;
 
  final String lottiePath;

  OnboardingModel({
    required this.title,
    required this.lottiePath,
    required this.subtitles,
  });
}

class SubtitleModel {
  final String subtitle;
  final IconData subtitleIcon;
  SubtitleModel({
    required this.subtitle,
    required this.subtitleIcon,
  });
}