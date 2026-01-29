import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/character_selection_screen.dart';
import 'screens/book_cover_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: WonderblyApp(),
    ),
  );
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CharacterSelectionScreen(),
    ),
    GoRoute(
      path: '/book-cover',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return BookCoverScreen(
          characterName: extra?['name'] ?? '',
          selectedCharacter: extra?['character'] ?? '',
        );
      },
    ),
  ],
);

class WonderblyApp extends StatelessWidget {
  const WonderblyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wonderbly Personalized Books',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          primary: const Color(0xFF6750A4),
          secondary: const Color(0xFF625B71),
          tertiary: const Color(0xFF7D5260),
        ),
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
