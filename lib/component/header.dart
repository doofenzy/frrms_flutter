import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Add header here
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome, User!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
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
          // ... other ListTiles
        ],
      ),
    );
  }
}
