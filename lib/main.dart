import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:enefty_icons/enefty_icons.dart';

// Screens
import 'package:gym_companion/screens/home_screen.dart';
import 'package:gym_companion/screens/workout_screen.dart';
import 'package:gym_companion/screens/nutrition_screen.dart';
import 'package:gym_companion/screens/progress_screen.dart';
import 'package:gym_companion/screens/profile_screen.dart';
import 'package:gym_companion/screens/login_screen.dart'; // Import des Login-Screens

// Theme
import 'package:gym_companion/utils/theme.dart';

// Provider für Navigation
class NavigationProvider with ChangeNotifier {
  String _currentScreen = 'home';

  String get currentScreen => _currentScreen;

  void changeScreen(String screen) {
    _currentScreen = screen;
    notifyListeners();
  }
}

// Screen Manager Widget
class ScreenManager extends StatelessWidget {
  final Map<String, Widget> _screens = {
    'home': HomeScreen(),
    'workout': WorkoutScreen(),
    'nutrition': NutritionScreen(),
    'progress': ProgressScreen(),
    'profile': ProfileScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        return _screens[navigationProvider.currentScreen] ?? HomeScreen();
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: AuthWrapper(), // Verwendung des AuthWrappers als Start-Widget
      ),
    );
  }
}

// AuthWrapper Widget
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return LoginScreen(); // Benutzer ist nicht eingeloggt
          } else {
            return MainScreen(); // Benutzer ist eingeloggt
          }
        } else {
          // Ladeanzeige während der Authentifizierungsprüfung
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

// MainScreen Widget
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenManager(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

// Bottom Navigation Bar
class BottomNavBar extends StatelessWidget {
  final List<IconData> iconList = [
    EneftyIcons.home_2_outline,
    EneftyIcons.activity_outline,
    EneftyIcons.archive_book_outline,
    EneftyIcons.chart_2_outline,
    EneftyIcons.profile_outline,
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final screens = ['home', 'workout', 'nutrition', 'progress', 'profile'];

    return AnimatedBottomNavigationBar(
      icons: iconList,
      backgroundColor: Colors.black, // Schwarzer Hintergrund
      activeIndex: screens.indexOf(navigationProvider.currentScreen),
      inactiveColor: Colors.white,
      activeColor: Colors.redAccent,
      notchSmoothness: NotchSmoothness.verySmoothEdge, // Smooth Animation
      gapLocation: GapLocation.none, // Kein Floating Button
      onTap: (index) {
        navigationProvider.changeScreen(screens[index]);
      },
      iconSize: 24, // Größere Icons für besseren Look
    );
  }
}