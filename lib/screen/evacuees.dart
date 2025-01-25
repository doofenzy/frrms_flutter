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
              margin: const EdgeInsets.only(top: 16.0, left: 16.0),
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
            SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 50.0), // Add margin to left and right
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300.0, // Adjust the width of the container
                    height: 130.0, // Adjust the height of the container
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Black border color
                        width: 1.0, // Border width
                      ),
                    ),
                    padding: const EdgeInsets.all(
                        8.0), // Add padding inside the container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Essential Contacts:',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: Colors.black, // Black line divider
                          thickness: 1.0, // Thickness of the divider
                        ),
                        Text(
                          'PNP:120-1212',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Ambulance: 09290284932',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Site Manager: 2930912832',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 300, // Adjust this value for the desired width
                        margin:
                            EdgeInsets.only(top: 50.0, left: 40.0, right: 40.0),
                        padding: EdgeInsets.only(bottom: 40),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        width: 200.0, // Adjust the width of the button
                        height: 50.0, // Adjust the height of the button
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blue, // Set the background color to blue
                            foregroundColor:
                                Colors.white, // Set the text color to white
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Rectangular shape with rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 12.0,
                            ), // Add padding for the rectangle size
                          ),
                          onPressed: () {
                            // Save logic here
                            print('Calamity information saved!');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, size: 20.0), // Add icon
                              SizedBox(
                                  width: 8.0), // Space between icon and text
                              Text(
                                'Add Evacuee',
                                style: TextStyle(
                                    fontSize: 16.0), // Set font size and text
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
