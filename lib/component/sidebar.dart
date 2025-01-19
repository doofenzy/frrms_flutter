import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key, required this.onItemTapped});

  final void Function(int index) onItemTapped;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  // Track which dropdowns are expanded
  final Map<int, bool> _expandedItems = {};

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildSidebarItem(
            context,
            icon: Icons.dashboard,
            title: 'Dashboard',
            index: 0,
          ),
          _buildDropdownSidebarItem(
            context,
            icon: Icons.person,
            title: 'Profiling',
            index: 1,
            subItems: [
              _buildSubItem(context, 'Individual List', 1),
              _buildSubItem(context, 'Household List', 2),
            ],
          ),
          _buildDropdownSidebarItem(
            context,
            icon: Icons.fire_truck,
            title: 'Relief Operation',
            index: 3,
            subItems: [
              _buildSubItem(context, 'Relief Operation', 3),
              _buildSubItem(context, 'Inventory', 4),
              _buildSubItem(context, 'Donation', 5),
            ],
          ),
          _buildSidebarItem(
            context,
            icon: Icons.warning,
            title: 'Evacuation Management',
            index: 6,
          ),
          _buildDropdownSidebarItem(
            context,
            icon: Icons.stacked_bar_chart_sharp,
            title: 'Risk Management',
            index: 7,
            subItems: [
              _buildSubItem(context, 'Buenavista Map', 7),
              _buildSubItem(context, 'Flood Reports', 8),
              _buildSubItem(context, 'SITREP', 9),
            ],
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
          widget.onItemTapped(index); // Notify parent about the tapped item
        },
      ),
    );
  }

  Widget _buildDropdownSidebarItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required int index,
    required List<Widget> subItems,
  }) {
    bool isExpanded = _expandedItems[index] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HoverContainer(
          child: ListTile(
            leading: Icon(icon, color: Colors.teal),
            title: Text(
              title,
              style: TextStyle(color: Colors.teal),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.teal,
            ),
            onTap: () {
              setState(() {
                _expandedItems[index] = !isExpanded;
              });
            },
          ),
        ),
        if (isExpanded) ...subItems,
      ],
    );
  }

  Widget _buildSubItem(BuildContext context, String title, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: HoverContainer(
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.teal),
          ),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            widget.onItemTapped(index); // Notify parent about the tapped item
          },
        ),
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
