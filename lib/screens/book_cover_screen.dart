import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/personalization_provider.dart';
import '../widgets/character_preview.dart';

class BookCoverScreen extends ConsumerWidget {
  const BookCoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);
    const String coverImageUrl = 'https://storage.googleapis.com/flutterappfortesting/book/cover.jpg';

    return Scaffold(
      backgroundColor: const Color(0xFFF5E6D3),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'I Spy You',
          style: TextStyle(color: Colors.white, fontFamily: 'serif'),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double size = constraints.maxWidth > 500 ? 500 : constraints.maxWidth;
          
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                coverImageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: const Color(0xFF8DB600),
                                  child: const Center(child: Text('Cover Image Load Error')),
                                ),
                              ),
                            ),
                          ),
                          // Character Circle (Using our Layered Preview)
                          Align(
                            alignment: Alignment.center, 
                            child: CharacterPreview(
                              gender: state.gender,
                              skinTone: state.skinTone,
                              hairStyle: state.hairStyle,
                              hairColor: state.hairColor,
                              hasGlasses: state.hasGlasses,
                              size: size * 0.42,
                            ),
                          ),
                          Align(
                            alignment: const Alignment(0, 0.85),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                state.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size * 0.12,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'serif',
                                  letterSpacing: 1.5,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(2, 2),
                                      blurRadius: 4.0,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(
                          label: 'Back',
                          icon: Icons.arrow_back,
                          onPressed: () => Navigator.pop(context),
                          color: Colors.grey.shade800,
                        ),
                        const SizedBox(width: 20),
                        _buildActionButton(
                          label: 'Preview Story',
                          icon: Icons.visibility,
                          onPressed: () => context.push('/preview'),
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
