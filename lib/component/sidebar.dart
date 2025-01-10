import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.onItemTapped});

  final void Function(int index) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildSidebarItem(
            context,
            icon: Icons.dashboard,
            title: 'Dashboard',
            index: 0,
          ),
          _buildSidebarItem(
            context,
            icon: Icons.person,
            title: 'Profiling',
            index: 1,
          ),
          _buildSidebarItem(
            context,
            icon: Icons.fire_truck,
            title: 'Relief Operation',
            index: 2,
          ),
          _buildSidebarItem(
            context,
            icon: Icons.warning,
            title: 'Evacuation Management',
            index: 3,
          ),
          _buildSidebarItem(
            context,
            icon: Icons.stacked_bar_chart_sharp,
            title: 'Risk Management',
            index: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(BuildContext context,
      {required IconData icon, required String title, required int index}) {
    return HoverContainer(
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(
          title,
          style: TextStyle(color: Colors.teal),
        ),
        onTap: () {
          Navigator.pop(context); // Close the drawer
          onItemTapped(index); // Notify the parent about the tapped item
        },
      ),
    );
  }
}

class HoverContainer extends StatefulWidget {
  final Widget child;

  const HoverContainer({super.key, required this.child});

  @override
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
        color: _isHovered
            ? Colors.grey[300]
            : Colors.transparent, // Change color on hover
        child: widget.child,
      ),
    );
  }
}
