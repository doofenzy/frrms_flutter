import 'package:flutter/material.dart';

class EvacuationManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data as a list of maps
    final List<Map<String, String>> tableData = [
      {
        'column1': 'Row 1, Cell 1',
        'column2': 'Row 1, Cell 2',
        'column3': 'Row 1, Cell 3'
      },
      {
        'column1': 'Row 2, Cell 1',
        'column2': 'Row 2, Cell 2',
        'column3': 'Row 2, Cell 3'
      },
      {
        'column1': 'Row 3, Cell 1',
        'column2': 'Row 3, Cell 2',
        'column3': 'Row 3, Cell 3'
      },
      // Add more data here
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Search input field with a fixed width
            SizedBox(
              width: 400, // Adjust the width as needed
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                ),
                onChanged: (value) {
                  print('Search query: $value');
                  // Add search filtering logic here
                },
              ),
            ),
          ],
        ),
        actions: [
          // Rectangle button with plus logo and text
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button color
              foregroundColor: Colors.white, // Text and icon color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0), // Rectangle shape
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            ),
            onPressed: () {
              print('Rectangle button pressed');
            },
            icon: Icon(Icons.add, size: 18.0), // Plus logo
            label: Text(
              'Add Calamity', // Button text
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Table widget
            Table(
              border: TableBorder.all(),
              children: [
                // Table header row
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Column 1',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Column 2',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Column 3',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                // Map through the data and generate rows dynamically
                ...tableData.map(
                  (data) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data['column1']!),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data['column2']!),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data['column3']!),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
