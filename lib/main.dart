import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import go_router
import 'component/header.dart';
import 'component/sidebar.dart';
import 'screen/dashboard.dart'; // 0
import 'screen/Profiling/householdList.dart'; //1
import 'screen/Profiling/individualList.dart'; //2
// import 'screen/ReliefOperation/donation.dart'; //3
// import 'screen/ReliefOperation/inventory.dart'; //4
// import 'screen/ReliefOperation/reliefOperation.dart'; //5
import 'screen/evacuationManagement.dart'; //6
// import 'screen/RiskAssessment/buenavistaMap.dart'; //7
// import 'screen/RiskAssessment/floodReports.dart'; //8
// import 'screen/RiskAssessment/sitrep.dart'; //9
import 'screen/evacuationCenter.dart'; //10
// to fix many changes
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Define your routes
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(selectedIndex: 0),
      ),
      GoRoute(
        path: '/individual-list',
        builder: (context, state) => HomeScreen(selectedIndex: 1),
      ),
      GoRoute(
        path: '/household-list',
        builder: (context, state) => HomeScreen(selectedIndex: 2),
      ),
      GoRoute(
        path: '/evacuation-management',
        builder: (context, state) => HomeScreen(selectedIndex: 3),
      ),
      GoRoute(
        path: '/calamityDetails/:calamityID/:calamityName',
        builder: (context, state) {
          final calamityID = int.parse(state.pathParameters['calamityID']!);
          final calamityName = state.pathParameters['calamityName']!;
          return CalamityDetailsScreen(
            calamityID: calamityID,
            calamityName: calamityName,
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router, // Use the GoRouter configuration
    );
  }
}

class HomeScreen extends StatefulWidget {
  final int selectedIndex; // Pass the selected index from the route

  const HomeScreen({super.key, required this.selectedIndex});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    Dashboard(),
    Individuallist(),
    Householdlist(),
    EvacuationManagement(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // Initialize with the passed index
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Update the URL based on the selected index
    switch (index) {
      case 0:
        GoRouter.of(context).go('/');
        break;
      case 1:
        GoRouter.of(context).go('/individual-list');
        break;
      case 2:
        GoRouter.of(context).go('/household-list');
        break;
      case 3:
        GoRouter.of(context).go('/evacuation-management');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HeaderWidget(
          imagePath: '../../assets/Logo.png', // Adjust the path to your logo
        ),
      ),
      drawer:
          Sidebar(onItemTapped: _onItemTapped), // Sidebar handles navigation
      body: _screens[_selectedIndex],
    );
  }
}
