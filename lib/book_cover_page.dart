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
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Book cover with character and name overlay
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: AspectRatio(
                        aspectRatio: 1, // Children's books are often square
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // 1. Base book cover image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                coverImageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: const Color(0xFF8DB600), // Matching the green in screenshot
                                  child: const Icon(Icons.error, color: Colors.white),
                                ),
                              ),
                            ),

                            // 2. Character Circle (Placed exactly in the magnifying glass)
                            // In the reference, the lens is roughly center-top
                            Positioned(
                              top: constraints.maxWidth > 600 ? 120 : constraints.maxWidth * 0.2, 
                              child: Container(
                                width: constraints.maxWidth > 600 ? 220 : constraints.maxWidth * 0.4,
                                height: constraints.maxWidth > 600 ? 220 : constraints.maxWidth * 0.4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFB8D8E8), // Sky blue background
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 8,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    characterImageUrl,
                                    fit: BoxFit.contain, // Ensuring character is not cut off
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(child: CircularProgressIndicator(color: Colors.white));
                                    },
                                  ),
                                ),
                              ),
                            ),

                            // 3. User's Name (Styled like "I SPY" / "SAMPLE!" text)
                            Positioned(
                              bottom: constraints.maxWidth > 600 ? 80 : constraints.maxWidth * 0.15,
                              child: Column(
                                children: [
                                  // The name text with the iconic heavy slab style
                                  Text(
                                    userName.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: constraints.maxWidth > 600 ? 64 : constraints.maxWidth * 0.12,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'serif', // Standard heavy serif for blocky look
                                      color: Colors.white,
                                      letterSpacing: 2,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(4, 4),
                                          blurRadius: 0,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        const Shadow(
                                          offset: Offset(-1, -1),
                                          color: Colors.black,
                                        ),
                                        const Shadow(
                                          offset: Offset(1, -1),
                                          color: Colors.black,
                                        ),
                                        const Shadow(
                                          offset: Offset(-1, 1),
                                          color: Colors.black,
                                        ),
                                        const Shadow(
                                          offset: Offset(1, 1),
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    
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
                          label: 'Pre-order',
                          icon: Icons.shopping_cart,
                          onPressed: () {
                             ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Personalizing $userName\'s book...')),
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
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
    );
  }
}
