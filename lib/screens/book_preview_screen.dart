import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/personalization_provider.dart';
import '../providers/cart_provider.dart';
import '../models/story_page.dart';
import '../widgets/character_preview.dart';

class BookPreviewScreen extends ConsumerStatefulWidget {
  const BookPreviewScreen({super.key});

  @override
  ConsumerState<BookPreviewScreen> createState() => _BookPreviewScreenState();
}

class _BookPreviewScreenState extends ConsumerState<BookPreviewScreen> {
  final PageController _pageController = PageController();
  
  // Dummy story pages
  final List<StoryPage> pages = [
    StoryPage(
      pageNumber: 1,
      textTemplate: "Once upon a time, there was a kind and curious child named {NAME}.",
      backgroundImagePath: "https://storage.googleapis.com/flutterappfortesting/book/page1.jpg",
    ),
    StoryPage(
      pageNumber: 2,
      textTemplate: "{NAME} loved to explore the magical forest.",
      backgroundImagePath: "https://storage.googleapis.com/flutterappfortesting/book/page2.jpg",
    ),
     StoryPage(
      pageNumber: 3,
      textTemplate: "Suddenly, {NAME} saw a sparkling light!",
      backgroundImagePath: "https://storage.googleapis.com/flutterappfortesting/book/page3.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(personalizationProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Book Preview', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.4, // Book spread ratio
          child: PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              final page = pages[index];
              return _buildPageSpread(page, state);
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Page preview',
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(cartProvider.notifier).addItem(
                  'The Magical Adventure', 
                  24.99, 
                  state
                );
                context.push('/cart');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageSpread(StoryPage page, PersonalizationState state) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              page.backgroundImagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade200),
            ),
          ),
          // Personalized Text
          Positioned(
            bottom: 40,
            left: 40,
            right: 40,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                page.getPersonalizedText(state.name),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                ),
              ),
            ),
          ),
          // Character in the scene (Optional position based on page)
          Positioned(
            bottom: 100,
            right: 60,
            child: CharacterPreview(
              gender: state.gender,
              skinTone: state.skinTone,
              hairStyle: state.hairStyle,
              hairColor: state.hairColor,
              hasGlasses: state.hasGlasses,
              size: 150,
            ),
          ),
        ],
      ),
    );
  }
}
