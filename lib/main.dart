import 'package:flutter/material.dart';
import 'component/header.dart';
import 'component/sidebar.dart';
import 'screen/dashboard.dart';
import 'screen/evacuationManagement.dart';
import 'screen/profiling.dart';
import 'screen/reliefOperation.dart';
import 'screen/riskManagement.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Dashboard(),
    Profiling(),
    ReliefOperation(),
    EvacuationManagement(),
    RiskManagement()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HeaderWidget(
          imagePath: '../../assets/logo.png', // Adjust the path to your logo
        ),
      ),
      drawer:
          Sidebar(onItemTapped: _onItemTapped), // Sidebar handles navigation
      body: _screens[_selectedIndex],
    );
  }
}
