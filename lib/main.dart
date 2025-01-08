// main.dart
import 'package:flutter/material.dart';
import 'component/sidebar.dart'; // Import your Sidebar widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Sidebar Example'),
      ),
      drawer: Sidebar(), // Use the Sidebar widget here
      body: Center(
        child: Text('Swipe from left or tap the menu icon to open the sidebar'),
      ),
    );
  }
}
