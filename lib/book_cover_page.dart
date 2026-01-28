import 'package:flutter/material.dart';

class BookCoverPage extends StatelessWidget {
  final String userName;
  final String characterImageUrl;

  const BookCoverPage({
    super.key,
    required this.userName,
    required this.characterImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('Building BookCoverPage for user: $userName');
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
                    // Book cover container
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
                          // 1. Base Cover Image
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                coverImageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: const Color(0xFF8DB600),
                                  child: const Center(child: Text('Cover Image Load Error')),
                                ),
                              ),
                            ),
                          ),

                          // 2. Character Circle (Precisely centered in the magnifying glass)
                          // Based on standard layouts, the magnifying glass lens center is approx at (0.5, 0.45)
                          Align(
                            alignment: const Alignment(0, -0.1), // Adjusted to match hand lens center
                            child: Container(
                              width: size * 0.45,
                              height: size * 0.45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFB8D8E8),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 6,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  characterImageUrl,
                                  fit: BoxFit.contain,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                                  },
                                ),
                              ),
                            ),
                          ),

                          // 3. Name (Placed below the lens)
                          Align(
                            alignment: const Alignment(0, 0.75), // Placed below the center lens
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                userName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size * 0.12,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'serif', // Generic slab-like serif
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
                    
                    // Action buttons
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
                          label: 'Preview',
                          icon: Icons.visibility,
                          onPressed: () {
                             ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Building $userName\'s story...')),
                            );
                          },
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
          borderRadius: BorderRadius.circular(30), // Pill style
        ),
      ),
    );
  }
}
