import 'package:flutter/material.dart';

class CharacterPreview extends StatelessWidget {
  final String gender;
  final String skinTone;
  final String hairStyle;
  final String hairColor;
  final bool hasGlasses;
  final double size;

  const CharacterPreview({
    super.key,
    required this.gender,
    required this.skinTone,
    required this.hairStyle,
    required this.hairColor,
    required this.hasGlasses,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    const String baseUrl = 'https://storage.googleapis.com/flutterappfortesting/characters';
    
    // For now, since we might not have all layered assets yet, 
    // we'll map these options to existing dummy images if available, 
    // or simulate the stack if the assets exist.
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFB8D8E8),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Base Skin Layer
            Image.network(
              '$baseUrl/${gender.toLowerCase()}_skin_${skinTone.toLowerCase()}.png',
              width: size * 0.9,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 100, color: Colors.white),
            ),
            // Hair Layer
            Image.network(
              '$baseUrl/${gender.toLowerCase()}_hair_${hairStyle.toLowerCase()}_${hairColor.toLowerCase()}.png',
              width: size * 0.9,
              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
            ),
            // Glasses Layer
            if (hasGlasses)
              Image.network(
                '$baseUrl/accessories_glasses.png',
                width: size * 0.9,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
          ],
        ),
      ),
    );
  }
}
