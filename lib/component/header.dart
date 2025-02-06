import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String imagePath;
  final double height;

  const HeaderWidget({
    super.key,
    required this.imagePath,
    this.height = 80.0, // Default height value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          double.infinity, // Makes the header span the full width of the screen
      height: height, // Sets the height dynamically
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center the logo vertically
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              const SizedBox(width: 8.0),
              Image.asset(
                imagePath,
                height: height *
                    0.6, // Adjust the logo height relative to the header
              ),
            ],
          ),
          Container(
            width: 200,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 30.0,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Secretary',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.zero, // Removes default padding
                  constraints: BoxConstraints(), // Shrinks button to fit icon
                  onPressed: () {
                    print('Logout button pressed');
                  },
                  icon: Icon(Icons.logout, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
