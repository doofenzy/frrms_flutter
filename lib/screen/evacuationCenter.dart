import 'package:flutter/material.dart';
import '../component/header.dart';
import '../component/sidebar.dart';
import '../context/dropDownField.dart';
import '../screen/evacuees.dart';

class CalamityDetailsScreen extends StatefulWidget {
  final Map<String, String> calamityData;

  CalamityDetailsScreen({required this.calamityData});

  @override
  _CalamityDetailsScreenState createState() => _CalamityDetailsScreenState();
}

class _CalamityDetailsScreenState extends State<CalamityDetailsScreen> {
  String? evacuationCenterName;
  String? zone;
  String? evacuationType;
  String? nameOfSiteManager;
  String? contactInformation;

  final List<Map<String, String>> datas = [
    {
      "location": "Location 1",
      "zone": "Zone A",
      "type": "Public",
      "name": "Center Address 1",
      "contact": "1234567890"
    },
    {
      "location": "Location 2",
      "zone": "Zone B",
      "type": "Private",
      "name": "Center Address 2",
      "contact": "0987654321"
    },
    {
      "location": "Location 1",
      "zone": "Zone A",
      "type": "Public",
      "name": "Center Address 1",
      "contact": "1234567890"
    },
    {
      "location": "Location 2",
      "zone": "Zone B",
      "type": "Private",
      "name": "Center Address 2",
      "contact": "0987654321"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HeaderWidget(
          imagePath: '../../assets/logo.png', // Path to your logo
        ),
      ),
      drawer: Sidebar(
        onItemTapped: (index) {
          // Handle sidebar navigation
          Navigator.pop(context); // Close the drawer
        },
      ),
      body: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    height: 300.0,
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors
                          .blue[50], // Background color for the main container
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        // Light blue background
                        Container(
                          color: Color(0xFFEAF1FF),
                          width: double.infinity,
                          height: double.infinity,
                        ),

                        // Typhoon name and description
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TYPHOON EGAY',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'An overview of evacuees',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 32.0), // Space for alignment
                              Align(
                                alignment: Alignment
                                    .centerLeft, // Aligns horizontally at the center
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0,
                                      left: 90), // Fine-tune vertical spacing
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center, // Center the children horizontally
                                    children: [
                                      Text(
                                        'Overall Total of Evacuees', // Label text
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              4.0), // Space between the label and the number
                                      Text(
                                        '64', // The number to display
                                        style: TextStyle(
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // White container, centered and shifted towards the right
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: MediaQuery.of(context).size.width *
                                0.7, // Adjust width
                            height: 300.0,
                            margin: EdgeInsets.only(
                                left: 32.0,
                                right: 16.0), // Create space on the left
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                itemCount: 12, // 4 rows * 3 columns
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, // 3 items per row
                                  childAspectRatio:
                                      4, // Adjust the aspect ratio to make it look like rows
                                  mainAxisSpacing:
                                      1.0, // Reduce the spacing between rows
                                  crossAxisSpacing:
                                      2.0, // Reduce the spacing between columns
                                ),
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Text(
                                        '${index + 1}', // Number on the left side
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              4.0), // Reduce the spacing between number and description
                                      Expanded(
                                        child: Text(
                                          'Description ${index + 1}', // Description on the right side
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    )),

                SizedBox(height: 20.0), // Space between the two boxes
                Container(
                  height: 500.0, // Height of the second box
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color to white
                    border: Border.all(
                      color: Colors.grey, // Set border color to gray
                      width: 1.0, // Set border width
                    ),
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                            10.0), // Add padding around text and button
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Space between text and button
                          children: [
                            Text(
                              'Evacuation Center List',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ), // Text style for upper-left text
                            ),
                            Container(
                              width: 250.0,
                              height: 50.0,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4,
                                              padding: EdgeInsets.all(20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 30.0),
                                                  Text(
                                                    'CALAMITY INFORMATION',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 24.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.0),
                                                  Table(
                                                    border: TableBorder.all(
                                                      color: Colors
                                                          .transparent, // Table border color
                                                    ),
                                                    columnWidths: const {
                                                      0: FlexColumnWidth(1),
                                                      1: FlexColumnWidth(1),
                                                    },
                                                    children: [
                                                      TableRow(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Name of Evacuation Center',
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  evacuationCenterName =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Zone',
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  zone = value;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                DropdownField(
                                                              label:
                                                                  'Evacuation Type',
                                                              items: [
                                                                'Private Evacuation Center',
                                                                'Public Evacuation Center'
                                                              ],
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  evacuationType =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          // Empty cell
                                                        ],
                                                      ),
                                                      // Row 1
                                                      TableRow(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Name of Site Manager',
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  nameOfSiteManager =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                DropdownField(
                                                              label:
                                                                  'Contact Information',
                                                              items: [
                                                                'Flood',
                                                                'Typhoon'
                                                              ],
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  contactInformation =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox()
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor: Colors
                                                              .blue, // Set the background color to blue
                                                          foregroundColor: Colors
                                                              .white, // Set the text color to white
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0), // Rectangular shape with rounded corners
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20.0,
                                                                  vertical:
                                                                      12.0), // Add padding for the rectangle size
                                                        ),
                                                        onPressed: () {
                                                          // Save logic here\
                                                          // saveCalamityData();

                                                          print(
                                                              'Calamity information saved!');
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Save',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    16.0)), // Set font size and text
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 5.0,
                                              right: 5.0,
                                              child: IconButton(
                                                icon: Icon(Icons.close,
                                                    color: Colors.grey),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.add,
                                    color: Colors.white,
                                    size: 16), // Example icon
                                label: Text(
                                    'Add Evacuation Center'), // Button text
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue, // Button color
                                  foregroundColor:
                                      Colors.white, // Text and icon color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        4.0), // Rectangle shape
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black, // Color of the divider line
                        thickness: 1.0, // Thickness of the line
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: datas.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Number of cards per row
                            mainAxisSpacing: 20.0, // Spacing between rows
                            crossAxisSpacing: 20.0, // Spacing between columns
                            childAspectRatio:
                                2.9, // Adjust this for vertical length (smaller = taller cards)
                          ),
                          itemBuilder: (context, index) {
                            final data = datas[index];
                            return Card(
                              margin: EdgeInsets.only(
                                  bottom: 10.0, right: 10.0, left: 10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data['location'] ?? '',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        PopupMenuButton<String>(
                                          onSelected: (String result) {
                                            switch (result) {
                                              case 'ViewEvacuess':
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EvacueesPage()),
                                                );
                                                break;
                                              case 'ViewReliefInventory':
                                                print('Edit button pressed');
                                                // Add your edit logic here
                                                break;
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(
                                              value: 'ViewEvacuess',
                                              child: Text('View Evacuees'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: 'ViewReliefInventory',
                                              child:
                                                  Text('View Relief Inventory'),
                                            ),
                                          ],
                                          icon: Icon(Icons.more_horiz,
                                              size: 16.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Expanded(
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        children: data.entries
                                            .where((entry) =>
                                                entry.key != 'location')
                                            .map((entry) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 4.0),
                                                  child: Text(
                                                    '${entry.key}: ${entry.value}',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.grey[700],
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ])),
    );
  }
}
