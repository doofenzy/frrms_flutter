import 'package:flutter/material.dart';
import '../component/header.dart'; // Adjust the import path as needed
import '../component/sidebar.dart'; // Adjust the import path as needed

class EvacueesPage extends StatelessWidget {
  final List<Map<String, dynamic>> cardData = [
    {"number": 800, "label": "Total Population"},
    {"number": 232, "label": "Females"},
    {"number": 568, "label": "Males"},
    {"number": 120, "label": "Number of Families"},
    {"number": 50, "label": "Seniors"},
    {"number": 50, "label": "Underaged"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HeaderWidget(
          imagePath: '../assets/Logo.png', // Adjust the image path as needed
        ),
      ),
      drawer: Sidebar(
        onItemTapped: (index) {
          // Handle sidebar navigation
          Navigator.pop(context); // Close the drawer
        },
      ), // Use the Sidebar widget here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Text(
                'PRIVATE EC - EDWARD MAGADAP',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 16.0), // Add margin to top and left
              child: Text(
                'An Overview of Evacuees',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 16.0, top: 16.0), // Add margin to top and left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Card(
                    elevation: 4.0,
                    child: Container(
                      color: const Color.fromARGB(255, 106, 153, 236),
                      width: 240.0, // Adjust the width of each card
                      height: 130.0, // Adjust the height of each card
                      child: Padding(
                        padding: const EdgeInsets.all(
                            16.0), // Add padding to the container
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the left
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${cardData[index]["number"]}', // Display the number
                              style: TextStyle(
                                fontSize:
                                    40.0, // Larger font size for the number
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                height:
                                    8.0), // Space between the number and the label
                            Text(
                              cardData[index]["label"], // Display the label
                              style: TextStyle(
                                fontSize: 20.0, // Font size for the label
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 50.0), // Add margin to left and right
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300.0, // Adjust the width of the container
                    height: 130.0, // Adjust the height of the container
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Black border color
                        width: 1.0, // Border width
                      ),
                    ),
                    padding: const EdgeInsets.all(
                        8.0), // Add padding inside the container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Essential Contacts:',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: Colors.black, // Black line divider
                          thickness: 1.0, // Thickness of the divider
                        ),
                        Text(
                          'PNP:120-1212',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Ambulance: 09290284932',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Site Manager: 2930912832',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 300, // Adjust this value for the desired width
                        margin:
                            EdgeInsets.only(top: 50.0, left: 40.0, right: 40.0),
                        padding: EdgeInsets.only(bottom: 40),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        width: 200.0, // Adjust the width of the button
                        height: 50.0, // Adjust the height of the button
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blue, // Set the background color to blue
                            foregroundColor:
                                Colors.white, // Set the text color to white
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Rectangular shape with rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 12.0,
                            ), // Add padding for the rectangle size
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Search'),
                                  content: Container(
                                    width: 400.0, // Set the desired width
                                    height: 400.0, // Set the desired height
                                    child: Column(
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Search...',
                                            border: OutlineInputBorder(),
                                          ),
                                          onChanged: (value) {
                                            // Handle search logic here
                                            print('Search query: $value');
                                          },
                                        ),
                                        SizedBox(
                                            height:
                                                16.0), // Space between the search bar and the table
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: 90, // Number of rows
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('ID $index'),
                                                    Text('Name $index'),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        // Handle add button logic here
                                                        print(
                                                            'Add button pressed for ID $index');
                                                      },
                                                      child: Text('Add'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, size: 20.0), // Add icon
                              SizedBox(
                                  width: 8.0), // Space between icon and text
                              Text(
                                'Add Evacuee',
                                style: TextStyle(
                                    fontSize: 16.0), // Set font size and text
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
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
                    // columnWidths: const {
                    //   0: FixedColumnWidth(100.0),
                    //   1: FlexColumnWidth(2),
                    //   2: FlexColumnWidth(2), // More space for longer content
                    //   3: FlexColumnWidth(2),
                    //   4: FlexColumnWidth(2),
                    //   5: FlexColumnWidth(2),
                    //   6: FlexColumnWidth(2),
                    //   7: FlexColumnWidth(2),
                    //   8: FlexColumnWidth(2),
                    // },
                    children: [
                      // Table header row
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('HH Id',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Name of Family Head',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Infant',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Toddlers',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Preschool',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('School Age',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Teen Age',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Adult',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Senior Citezens',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('# of Persons per Family',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Lactating Mothers',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Pregnant',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('PWD',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Solo Parent',
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
                      // ...filteredCalamities.asMap().entries.map(
                      //   (entry) {
                      //     final data = entry.value;

                      //     return TableRow(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(data['ID']!),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(data['Date & Time']!),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(data['Type of Calamity']!),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(data['Calamity Name']!),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(data['Security Level']!),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(data['Cause of Calamity']!),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(
                      //               data['Evacuation Alert Level Issued']!),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(data['Status']!),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(2.0),
                      //           child: MenuAnchor(
                      //             builder: (BuildContext context,
                      //                 MenuController controller,
                      //                 Widget? child) {
                      //               return IconButton(
                      //                 onPressed: () {
                      //                   if (controller.isOpen) {
                      //                     controller.close();
                      //                   } else {
                      //                     controller.open();
                      //                   }
                      //                 },
                      //                 icon: const Icon(Icons.more_horiz),
                      //                 tooltip: 'Show menu',
                      //               );
                      //             },
                      //             menuChildren: List<MenuItemButton>.generate(
                      //               3,
                      //               (int menuIndex) => MenuItemButton(
                      //                 onPressed: () {},
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // ).toList()
                    ]
                    //end
                    )),
          ],
        ),
      ),
    );
  }
}
