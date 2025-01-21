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
      body: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 300.0,
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors
                        .blue[50], // Background color for the main container
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment
                            .topLeft, // Position the first text at the upper-left
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0), // Add some padding for better spacing
                          child: Text(
                            '${calamityData['Calamity Name']}', // Accessing the map data correctly
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment
                            .topLeft, // Position the second text below the first
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 8.0, top: 60.0), // Adjust top padding
                          child: Text(
                            'An overview of evacuees',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Position the new container at the center
                        child: Container(
                          width: double
                              .infinity, // Make the container stretch horizontally
                          height: 100.0, // Height of the new container
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Background color for the new container
                            borderRadius:
                                BorderRadius.circular(10.0), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // Shadow position
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Details about evacuees go here',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.0), // Space between the two boxes
                Container(
                  height: 500.0, // Height of the second box
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color to white
                    border: Border.all(
                      color: Colors.grey, // Set border color to gray
                      width: 1.0, // Set border width
                    ),
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                  ),
                  child: Center(
                    child: Text(
                      'Second Box',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18), // Adjusted text color for contrast
                    ),
                  ),
                )
              ])),
    );
  }
}
