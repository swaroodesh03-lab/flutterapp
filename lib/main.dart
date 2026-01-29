import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/catalog_screen.dart';
import 'screens/character_selection_screen.dart';
import 'screens/book_cover_screen.dart';
import 'screens/book_preview_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/admin_dashboard_screen.dart';

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
      builder: (context, state) => const CatalogScreen(),
    ),
    GoRoute(
      path: '/personalize/:bookId',
      builder: (context, state) => const CharacterSelectionScreen(),
    ),
    GoRoute(
      path: '/book-cover',
      builder: (context, state) => const BookCoverScreen(),
    ),
    GoRoute(
      path: '/preview',
      builder: (context, state) => const BookPreviewScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminDashboardScreen(),
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
