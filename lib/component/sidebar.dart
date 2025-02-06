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
            icon: Icons.warning,
            title: 'Calamity',
            index: 3,
            subItems: [
              _buildSubItem(context, 'Evacuation Management', 3),
              _buildSubItem(context, 'Risk Assessment', 3),
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
        leading: Icon(icon, color: Colors.grey[600]),
        title: Text(
          title,
          style: TextStyle(color: Colors.grey[600]),
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
            leading: Icon(icon, color: Colors.grey[600]),
            title: Text(
              title,
              style: TextStyle(color: Colors.grey[600]),
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
            style: TextStyle(color: Colors.grey[600]),
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
            ? Colors.grey[400]
            : Colors.transparent, // Change color on hover
        child: widget.child,
      ),
    );
  }
}
