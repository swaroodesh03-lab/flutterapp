import 'package:flutter/material.dart';

class CharacterSelectionPage extends StatefulWidget {
  const CharacterSelectionPage({super.key});

  @override
  State<CharacterSelectionPage> createState() => _CharacterSelectionPageState();
}

class _CharacterSelectionPageState extends State<CharacterSelectionPage> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedGender = 'Boy';
  int? _selectedCharacterIndex;

  // GCS bucket URL for character images
  final String bucketUrl = 'https://storage.googleapis.com/flutterappfortesting/characters';
  
  // List of boy character image filenames
  final List<String> boyCharacters = [
    'boy1.png',
    'boy2.png',
    'boy3.png',
    'boy4.png',
    'boy5.png',
    'boy6.png',
  ];
  
  // List of girl character image filenames
  final List<String> girlCharacters = [
    'girl1.png',
    'girl2.png',
    'girl3.png',
    'girl4.png',
    'girl5.png',
    'girl6.png',
  ];
  
  // Get current character list based on selected gender
  List<String> get currentCharacters {
    return _selectedGender == 'Boy' ? boyCharacters : girlCharacters;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E6D3),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'I Spy You',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Step 1 of 1',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Who is this book for?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                ),
              ),
              const SizedBox(height: 30),
              
              // First name input
              const Text(
                'First name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // Gender selection
              const Text(
                'Choose their character',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildGenderButton('Boy'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildGenderButton('Girl'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Character grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: currentCharacters.length,
                itemBuilder: (context, index) {
                  return _buildCharacterCard(index);
                },
              ),
              const SizedBox(height: 30),
              
              // Continue button
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a first name'),
                      ),
                    );
                    return;
                  }
                  if (_selectedCharacterIndex == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a character'),
                      ),
                    );
                    return;
                  }
                  
                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: ${_nameController.text}, ${currentCharacters[_selectedCharacterIndex!]}',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Back to product page link
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_back, size: 16, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      'Back to the product page',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderButton(String gender) {
    final isSelected = _selectedGender == gender;
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedGender = gender;
          _selectedCharacterIndex = null; // Reset selection when gender changes
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : Colors.transparent,
        side: BorderSide(
          color: isSelected ? Colors.black : Colors.grey,
          width: isSelected ? 2 : 1,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        gender,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildCharacterCard(int index) {
    final isSelected = _selectedCharacterIndex == index;
    final imageUrl = '$bucketUrl/${currentCharacters[index]}';
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCharacterIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFB8D8E8),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade400,
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.error, color: Colors.red),
              );
            },
          ),
        ),
      ),
    );
  }
}
