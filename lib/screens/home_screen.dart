import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildFeaturesSection(),
            _buildHowItWorksSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/hero.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Your Child\'s Own Adventure',
              style: GoogleFonts.outfit(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'A personalized book where they are the hero.',
              style: GoogleFonts.outfit(
                fontSize: 24,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.push('/catalog'), // This will navigate to the catalog
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD700),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Personalize Book'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Why Choose Our Books?',
            style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFeatureItem(Icons.face, 'Personalized Characters', 'Choose name, skin tone, and hair color.'),
              _buildFeatureItem(Icons.auto_stories, 'Unique Stories', 'Every child sees themselves in the story.'),
              _buildFeatureItem(Icons.local_shipping, 'Fast Delivery', 'High-quality printing delivered to your door.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          Icon(icon, size: 48, color: const Color(0xFF6750A4)),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildHowItWorksSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: const Color(0xFFF3F0F7),
      child: Column(
        children: [
          Text(
            'How It Works',
            style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 48),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepItem('1', 'Select a Theme', 'Pick a magical world.'),
              Icon(Icons.arrow_forward, color: Colors.grey),
              _buildStepItem('2', 'Customize', 'Add name and appearance.'),
              Icon(Icons.arrow_forward, color: Colors.grey),
              _buildStepItem('3', 'Receive', 'Get your unique book.'),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildStepItem(String step, String title, String description) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF6750A4),
            child: Text(step, style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(description, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.black87,
      child: const Center(
        child: Text(
          '© 2026 Wonderbly-style Personalized Books. All rights reserved.',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
