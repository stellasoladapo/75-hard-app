import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/challenge_controller.dart';
import '../models/challenge_state.dart';
import '../widgets/fade_in_card.dart';
import '../widgets/nature_scaffold.dart';
import '../widgets/section_card.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key, required this.controller});

  final ChallengeController controller;
  final ImagePicker _picker = ImagePicker();

  Future<void> _addPhoto(BuildContext context) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) {
      return;
    }

    await controller.setPhotoForToday(image.path);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Today\'s progress photo was saved.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<DayEntry> photos = controller.photoEntries;

    return NatureScaffold(
      imageUrl:
          'https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=1400&q=80',
      overlayColors: const <Color>[
        Color(0x445C7C62),
        Color(0xCFEAF6EC),
        Color(0xF0F1F8E9),
      ],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        children: <Widget>[
          FadeInCard(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: <Color>[
                    Color(0xDDF1F8E9),
                    Color(0xCCA5D6A7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x220E2414),
                    blurRadius: 24,
                    offset: Offset(0, 14),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'PHOTO GALLERY',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.secondary,
                            letterSpacing: 1.4,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Capture the visual proof', style: theme.textTheme.headlineMedium),
                        const SizedBox(height: 10),
                        Text(
                          'Upload your daily progress photo and keep the transformation timeline visible.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  FilledButton.icon(
                    onPressed: () => _addPhoto(context),
                    icon: const Icon(Icons.add_a_photo_outlined),
                    label: const Text('Add'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          if (photos.isEmpty)
            FadeInCard(
              delay: const Duration(milliseconds: 80),
              child: SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('No progress photos yet', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Add your first image from the gallery. Saving a photo also checks off the progress-picture habit for today.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
          else
            for (int index = 0; index < photos.length; index++)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: FadeInCard(
                  delay: Duration(milliseconds: 80 + (index * 60)),
                  child: SectionCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                          child: Image.file(
                            File(photos[index].photoPath!),
                            width: double.infinity,
                            height: 320,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                              return Container(
                                height: 320,
                                color: theme.colorScheme.primary.withOpacity(0.08),
                                alignment: Alignment.center,
                                child: Text(
                                  'Photo unavailable',
                                  style: theme.textTheme.titleMedium,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                MaterialLocalizations.of(context).formatFullDate(
                                  DateTime.parse(photos[index].dateKey),
                                ),
                                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Saved to the daily checklist for that date.',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
