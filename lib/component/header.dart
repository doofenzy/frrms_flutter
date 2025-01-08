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
            height:
                height * 0.6, // Adjust the logo height relative to the header
          ),
        ],
      ),
    );
  }
}
