import 'package:flutter/material.dart';
import '../component/header.dart';
import '../component/sidebar.dart';

class CalamityDetailsScreen extends StatelessWidget {
  final Map<String, String> calamityData;

  CalamityDetailsScreen({required this.calamityData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HeaderWidget(
          imagePath: '../../assets/logo.png', // Path to your logo
        ),
      ),
      drawer: Sidebar(
        onItemTapped: (index) {
          // Handle sidebar navigation
          Navigator.pop(context); // Close the drawer
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: calamityData.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '${entry.key}: ${entry.value}',
                style: TextStyle(fontSize: 16.0),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
