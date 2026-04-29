import 'package:flutter/material.dart';
import 'package:eclipse_player/theme/cinematic_theme.dart';
import 'package:get/get.dart';
import 'theme/design_system.dart';
import 'screens/home_screen.dart';
import 'screens/browser_screen.dart';
import 'screens/downloads_screen.dart';
import 'screens/library_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/player_screen.dart';
import 'screens/audio_player_screen.dart';
import 'screens/video_player_screen.dart';
import 'screens/playlist_screen.dart';
import 'screens/advanced_settings_screen.dart';
import 'screens/download_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Ensure all services are initialized
  try {
    // Initialize GetX services if needed
    await _initializeServices();
  } catch (e) {
    debugPrint('Service initialization warning: $e');
  }
  
  runApp(const EclipsePlayerApp());
}

Future<void> _initializeServices() async {
  // Add any initialization code here
  // e.g., database initialization, preferences loading, etc.
}

class EclipsePlayerApp extends StatelessWidget {
  const EclipsePlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eclipse Player',
      theme: createCinematicTheme(),
      darkTheme: createCinematicTheme(),
      themeMode: ThemeMode.dark,
      home: const MainNavigationScreen(),
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
      getPages: [
        GetPage(name: '/', page: () => const MainNavigationScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/browser', page: () => const BrowserScreen()),
        GetPage(name: '/downloads', page: () => const DownloadsScreen()),
        GetPage(name: '/library', page: () => const LibraryScreen()),
        GetPage(name: '/settings', page: () => const SettingsScreen()),
        GetPage(name: '/player', page: () => const PlayerScreen()),
        GetPage(name: '/audio', page: () => const AudioPlayerScreen()),
        GetPage(name: '/video', page: () => const VideoPlayerScreen()),
        GetPage(name: '/playlist', page: () => const PlaylistScreen()),
        GetPage(name: '/advanced_settings', page: () => const AdvancedSettingsScreen()),
        GetPage(name: '/download_details', page: () => const DownloadDetailsScreen()),
      ],
      builder: (context, child) {
        // Ensure material app is properly built
        return child ?? const SizedBox.shrink();
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const BrowserScreen(),
    const DownloadsScreen(),
    const LibraryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PremiumColors.bg0,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: PremiumColors.bg1,
        selectedItemColor: PremiumColors.accentCyan,
        unselectedItemColor: PremiumColors.textTertiary,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language_rounded),
            label: 'Browser',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_rounded),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_rounded),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}