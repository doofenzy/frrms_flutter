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
        title: Text('Evacuation Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              print('Settings button pressed');
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            print('Search button pressed');
          },
        ),
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
