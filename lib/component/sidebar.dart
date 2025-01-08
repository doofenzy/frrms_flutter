import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Set the width of the sidebar
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(2.0), // Add margin here
            child: ListTile(
              leading: Icon(Icons.dashboard, color: Colors.teal),
              title: Text(
                'Dashboard',
                style: TextStyle(color: Colors.teal),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(2.0), // Add margin here
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.teal),
              title: Text(
                'Profiling',
                style: TextStyle(color: Colors.teal),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(2.0), // Add margin here
            child: ListTile(
              leading: Icon(Icons.fire_truck, color: Colors.teal),
              title: Text(
                'Relief Operation',
                style: TextStyle(color: Colors.teal),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(2.0), // Add margin here
            child: ListTile(
              leading: Icon(Icons.warning, color: Colors.teal),
              title: Text(
                'Evacuation Management',
                style: TextStyle(color: Colors.teal),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(2.0), // Add margin here
            child: ListTile(
              leading: Icon(Icons.stacked_bar_chart_sharp, color: Colors.teal),
              title: Text(
                'Risk Management',
                style: TextStyle(color: Colors.teal),
              ),
              onTap: () {
                // Handle navigation
              },
            ),
          ),
        ],
      ),
    );
  }
}
