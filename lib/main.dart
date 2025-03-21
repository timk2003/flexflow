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
class BottomNavBar extends StatelessWidget {
  final List<IconData> iconList = [
    EneftyIcons.home_outline,
    EneftyIcons.activity_outline,
    EneftyIcons.archive_book_outline,
    EneftyIcons.chart_2_outline,
    EneftyIcons.user_outline,
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final screens = ['home', 'workout', 'nutrition', 'progress', 'profile'];

    return AnimatedBottomNavigationBar(
      icons: iconList,
      activeIndex: screens.indexOf(navigationProvider.currentScreen),
      backgroundColor: Colors.black, // Schwarzer Hintergrund
      activeColor: Colors.redAccent,
      height: 80, // Höhe des Navigationsbereichs,
      inactiveColor: Colors.white,
      iconSize: 26, // Etwas größere Icons für besseren Look
      gapLocation: GapLocation.none, // Kein Floating Button
      notchSmoothness: NotchSmoothness.smoothEdge, // Weiche Übergänge
      leftCornerRadius: 20,
      rightCornerRadius: 20,
      splashSpeedInMilliseconds: 300, // Schnelle Animation
      splashColor: Colors.redAccent.withOpacity(0.3), // Glow-Effekt
      onTap: (index) {
        navigationProvider.changeScreen(screens[index]);
      },
      scaleFactor: 1.1, // Aktives Icon wird leicht größer
    );
  }
}