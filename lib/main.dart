import 'package:expense_track/constants/theme.dart';
import 'package:expense_track/provider/financial_provider.dart';
import 'package:expense_track/screens/expense_track_screen.dart';
import 'package:expense_track/screens/home.dart';
import 'package:expense_track/screens/profile.dart';
import 'package:expense_track/utils/auth.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FinancialsProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthGate(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List screens = [
    HomeScreen(),
    TrackerScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: kPrimaryColor,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.track_changes),
            title: const Text('Tracker'),
            activeColor: kPrimaryColor,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.man),
            title: const Text('Profile'),
            activeColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
