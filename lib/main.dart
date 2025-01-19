import 'package:flutter/material.dart';
import 'component/header.dart';
import 'component/sidebar.dart';
import 'screen/dashboard.dart'; // 0
import 'screen/Profiling/householdList.dart'; //1
import 'screen/Profiling/individualList.dart'; //2
import 'screen/ReliefOperation/donation.dart'; //3
import 'screen/ReliefOperation/inventory.dart'; //4
import 'screen/ReliefOperation/reliefOperation.dart'; //5
import 'screen/evacuationManagement.dart'; //6
import 'screen/RiskAssessment/buenavistaMap.dart'; //7
import 'screen/RiskAssessment/floodReports.dart'; //8
import 'screen/RiskAssessment/sitrep.dart'; //9

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
    Individuallist(),
    Householdlist(),
    Reliefoperation(),
    Inventory(),
    Donation(),
    EvacuationManagement(),
    Buenavistamap(),
    Floodreports(),
    Sitrep()
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
