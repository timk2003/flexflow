import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Screens
import 'package:gym_companion/screens/home_screen.dart';
import 'package:gym_companion/screens/login_screen.dart';
import 'package:gym_companion/screens/workout_screen.dart';
import 'package:gym_companion/screens/nutrition_screen.dart';
import 'package:gym_companion/screens/progress_screen.dart';
import 'package:gym_companion/screens/profile_screen.dart';

// Theme
import 'package:gym_companion/utils/theme.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

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
        home: AuthWrapper(),
      ),
    );
  }
}

// AuthWrapper entscheidet, ob der Nutzer eingeloggt ist oder nicht
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          return MainScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

// Hauptbildschirm mit Bottom Navigation
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
  @override
  Widget build(BuildContext context) {
    return WaterDropNavBar(
      onItemSelected: (index) {
        final screens = ['home', 'workout', 'nutrition', 'progress', 'profile'];
        Provider.of<NavigationProvider>(context, listen: false).changeScreen(screens[index]);
      },
      selectedIndex: 0,
      waterDropColor: Colors.white,
      backgroundColor: Theme.of(context).primaryColor,
      barItems: [
        BarItem(filledIcon: EneftyIcons.home_2_bold, outlinedIcon: EneftyIcons.home_2_outline),
        BarItem(filledIcon: EneftyIcons.activity_bold, outlinedIcon: EneftyIcons.activity_outline),
        BarItem(filledIcon: EneftyIcons.archive_book_bold, outlinedIcon: EneftyIcons.archive_book_outline),
        BarItem(filledIcon: EneftyIcons.chart_2_bold, outlinedIcon: EneftyIcons.chart_2_outline),
      ],
    );
  }
}
