import 'package:flutter/material.dart';
import 'component/header.dart'; // Replace with the correct file path
import 'component/sidebar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: HeaderWidget(
            imagePath: '../../assets/logo.png',
          ),
        ),
        drawer: Sidebar(), // Use the Sidebar widget here
        body: Center(
          child:
              Text('Swipe from left or tap the menu icon to open the sidebar'),
        ),
      ),
    );
  }
}
