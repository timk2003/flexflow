import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

// Screens
import 'package:gym_companion/screens/home_screen.dart';
import 'package:gym_companion/screens/workout_screen.dart';
import 'package:gym_companion/screens/nutrition_screen.dart';
import 'package:gym_companion/screens/progress_screen.dart';
import 'package:gym_companion/screens/profile_screen.dart';
import 'package:gym_companion/screens/login_screen.dart';

// Theme
import 'package:gym_companion/utils/theme.dart';

// Auth Provider
class AuthProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}

// Navigation Provider
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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: AuthWrapper(), // Entscheidet zwischen Login und App
      ),
    );
  }
}

// Entscheidet, ob Login oder Haupt-App angezeigt wird
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data != null) {
          Provider.of<AuthProvider>(context, listen: false).setUser(snapshot.data);
          return MainApp();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

// Haupt-App mit Bottom Navigation
class MainApp extends StatelessWidget {
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
