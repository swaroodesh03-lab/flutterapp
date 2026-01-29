import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/personalization_provider.dart';
import '../widgets/character_preview.dart';

class CharacterSelectionScreen extends ConsumerWidget {
  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);
    final notifier = ref.read(personalizationProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF5E6D3),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Personalize Your Adventure',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Character Preview Section
              Center(
                child: CharacterPreview(
                  gender: state.gender,
                  skinTone: state.skinTone,
                  hairStyle: state.hairStyle,
                  hairColor: state.hairColor,
                  hasGlasses: state.hasGlasses,
                ),
              ),
              const SizedBox(height: 30),

              // Name Input
              const Text('Child\'s Name', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                onChanged: (value) => notifier.setName(value),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 24),

              // Gender Selection
              const Text('Gender', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  _choiceChip(ref, 'Boy', state.gender == 'Boy', (val) => notifier.setGender('Boy')),
                  const SizedBox(width: 8),
                  _choiceChip(ref, 'Girl', state.gender == 'Girl', (val) => notifier.setGender('Girl')),
                ],
              ),
              const SizedBox(height: 20),

              // Skin Tone Selection
              const Text('Skin Tone', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: ['Light', 'Medium', 'Dark'].map((tone) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _choiceChip(ref, tone, state.skinTone == tone, (val) => notifier.setSkinTone(tone)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Hair Style Selection
              const Text('Hair Style', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: ['Short', 'Long', 'Curly'].map((style) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _choiceChip(ref, style, state.hairStyle == style, (val) => notifier.setHairStyle(style)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Hair Color Selection
              const Text('Hair Color', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: ['Black', 'Brown', 'Blonde'].map((color) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _choiceChip(ref, color, state.hairColor == color, (val) => notifier.setHairColor(color)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Glasses Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Wears Glasses?', style: TextStyle(fontWeight: FontWeight.bold)),
                  Switch(
                    value: state.hasGlasses,
                    onChanged: (value) => notifier.setHasGlasses(value),
                    activeColor: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Continue Button
              ElevatedButton(
                onPressed: () {
                  if (state.name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a name')),
                    );
                    return;
                  }
                  context.push('/book-cover', extra: {
                    'name': state.name,
                    'character': state.gender, // Or a combined key
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Confirm Personalization', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _choiceChip(WidgetRef ref, String label, bool isSelected, Function(bool) onSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: Colors.blue.shade100,
      labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.black54),
    );
  }
}
