import 'package:flutter/material.dart';

class EvacuationManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data as a list of maps
    final List<Map<String, String>> tableData = [
      {
        'ID': '001',
        'Date & Time': '01/01/24 - 11:11:11 AM',
        'Type of Calamity': 'Flood',
        'Security Level': 'Severe',
        'Cause of Calamity': 'Heavy Rains',
        'Evacuation Alert Level Issued': 'Mandatory Evacuation',
        'Status': 'Ongoing',
        'Actions': 'Button',
      },
      {
        'ID': '001',
        'Date & Time': '01/01/24 - 11:11:11 AM',
        'Type of Calamity': 'Flood',
        'Security Level': 'Severe',
        'Cause of Calamity': 'Heavy Rains',
        'Evacuation Alert Level Issued': 'Mandatory Evacuation',
        'Status': 'Ongoing',
        'Actions': 'Button',
      },
      {
        'ID': '001',
        'Date & Time': '01/01/24 - 11:11:11 AM',
        'Type of Calamity': 'Flood',
        'Security Level': 'Severe',
        'Cause of Calamity': 'Heavy Rains',
        'Evacuation Alert Level Issued': 'Mandatory Evacuation',
        'Status': 'Ongoing',
        'Actions': 'Button',
      },
      // Add more data here
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Search input field with a limited width
            Container(
              width: 300, // Adjust this value for the desired width
              margin: EdgeInsets.only(top: 50.0, left: 40.0, right: 40.0),
              padding: EdgeInsets.only(bottom: 30),
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
                },
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
                right: 40.0, left: 40.0), // Add your desired margin here
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text and icon color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0), // Rectangle shape
                ),
                // padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0), // Padding for the entire body
        child: Column(
          children: [
            // Table widget with margin
            Container(
                margin: EdgeInsets.only(
                    left: 40, right: 40), // Adds margin above the table
                child: Table(
                  border: TableBorder(
                    left: BorderSide(
                      color: Colors.grey, // Left border color
                      width: 1.0, // Left border width
                    ),
                    right: BorderSide(
                      color: Colors.grey, // Right border color
                      width: 1.0, // Right border width
                    ),
                    horizontalInside: BorderSide(
                      color: Colors.grey, // Horizontal line color
                      width: 1.0, // Horizontal line width
                    ),
                    top: BorderSide(
                      color: Colors.grey, // Top border
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: Colors.grey, // Bottom border
                      width: 1.0,
                    ),
                  ),
                  children: [
                    // Table header row
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('ID',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Date & Time',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Type of Calamity',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Security Level',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Cause of Calamity',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Evacuation Alert Level Issued',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Status',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Actions',
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
                              child: Text(data['ID']!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data['Date & Time']!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data['Type of Calamity']!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data['Security Level']!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data['Cause of Calamity']!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text(data['Evacuation Alert Level Issued']!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data['Status']!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data['Actions']!),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
