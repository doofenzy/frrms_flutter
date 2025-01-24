import 'package:flutter/material.dart';
import '../component/header.dart'; // Adjust the import path as needed
import '../component/sidebar.dart'; // Adjust the import path as needed

class EvacueesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HeaderWidget(
          imagePath: '../assets/Logo.png', // Adjust the image path as needed
        ),
      ),
      drawer: Sidebar(
        onItemTapped: (index) {
          // Handle sidebar navigation
          Navigator.pop(context); // Close the drawer
        },
      ), // Use the Sidebar widget here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 16.0, left: 16.0), // Add margin to top and left
              child: Text(
                'PRIVATE EC - EDWARD MAGADAP',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 16.0), // Add margin to top and left
              child: Text(
                'An Overview of Evacuees',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 16.0, top: 16.0), // Add margin to top and left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return Card(
                    elevation: 4.0,
                    child: Container(
                      color: const Color.fromARGB(255, 106, 153, 236),
                      width: 300.0, // Adjust the width of each card
                      height: 150.0, // Adjust the height of each card
                      child: Center(
                        child: Text(
                          'Card ${index + 1}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
