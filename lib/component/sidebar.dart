import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          HoverContainer(
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
          HoverContainer(
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
          HoverContainer(
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
          HoverContainer(
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
          HoverContainer(
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

class HoverContainer extends StatefulWidget {
  final Widget child;

  const HoverContainer(
      {super.key, required this.child, required EdgeInsets margin});

  @override
  // ignore: library_private_types_in_public_api
  _HoverContainerState createState() => _HoverContainerState();
}

class _HoverContainerState extends State<HoverContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin: const EdgeInsets.all(2.0),
        color: _isHovered
            ? Colors.grey[300]
            : Colors.transparent, // Change color on hover
        child: widget.child,
      ),
    );
  }
}
