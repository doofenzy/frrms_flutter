import 'package:flutter/material.dart';
import '../context/dateField.dart';
import '../context/dropDownField.dart';
import './evacuationCenter.dart';

enum actionButton { edit, delete }

class EvacuationManagement extends StatefulWidget {
  @override
  _EvacuationManagementState createState() => _EvacuationManagementState();
}

class _EvacuationManagementState extends State<EvacuationManagement> {
  actionButton? selectedMenu;
  int? id;
  String? selectedCalamityType;
  String? selectedSeverityLevel;
  String? selectedCause;
  String? selectedAlertLevel;
  String? currentStatus;
  String? calamityName;
  DateTime? selectedDate;
  final List<Map<String, String>> tableData = [
    {
      'ID': '001',
      'Date & Time': '01/01/24 - 11:11',
      'Type of Calamity': 'Flood',
      'Calamity Name': 'Typhoon Odette',
      'Security Level': 'Severe',
      'Cause of Calamity': 'Heavy Rains',
      'Evacuation Alert Level Issued': 'Mandatory Evacuation',
      'Status': 'Ongoing',
    },
    {
      'ID': '001',
      'Date & Time': '01/01/24 - 11:11',
      'Type of Calamity': 'Flood',
      'Calamity Name': 'Typhoon Odette',
      'Security Level': 'Severe',
      'Cause of Calamity': 'Heavy Rains',
      'Evacuation Alert Level Issued': 'Mandatory Evacuation',
      'Status': 'Ongoing',
    },
    {
      'ID': '001',
      'Date & Time': '01/01/24 - 11:11',
      'Type of Calamity': 'Flood',
      'Calamity Name': 'Typhoon Odette',
      'Security Level': 'Severe',
      'Cause of Calamity': 'Heavy Rains',
      'Evacuation Alert Level Issued': 'Mandatory Evacuation',
      'Status': 'Ongoing',
    },
  ];

  List<Map<String, String>> filteredCalamities = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredCalamities = tableData; // Initially display all calamities
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      print('Search query: $searchQuery');
      filteredCalamities = tableData
          .where((calamity) => calamity['Calamity Name']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  void resetValue() {
    selectedCalamityType = null;
    selectedSeverityLevel = null;
    selectedCause = null;
    selectedAlertLevel = null;
    currentStatus = null;
    calamityName = null;
    selectedDate = null;
  }

  void saveCalamityData() {
    int id = tableData.length + 1; // to start the id at 1

    Map<String, String> newCalamity = {
      'ID': id.toString(), // id incrementation
      'Date & Time': selectedDate != null
          ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}/${selectedDate!.hour}:${selectedDate!.minute}'
          : 'N/A',
      'Type of Calamity': selectedCalamityType!,
      'Calamity Name': calamityName!,
      'Security Level': selectedSeverityLevel!,
      'Cause of Calamity': selectedCause!,
      'Evacuation Alert Level Issued': selectedAlertLevel!,
      'Status': currentStatus!,
    };

    newCalamity.forEach((key, value) {
      print('$key: $value');
    });

    setState(() {
      tableData.add(newCalamity);
    });

    resetValue();
  }

  void updateCalamityData(int id) {
    int index = tableData.indexWhere((data) => int.parse(data['ID']!) == id);

    if (index != -1) {
      Map<String, String> updatedCalamity = {
        'ID': id.toString(),
        'Date & Time': selectedDate != null
            ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}/${selectedDate!.hour}:${selectedDate!.minute}'
            : 'N/A',
        'Type of Calamity': selectedCalamityType!,
        'Calamity Name': calamityName!,
        'Security Level': selectedSeverityLevel!,
        'Cause of Calamity': selectedCause!,
        'Evacuation Alert Level Issued': selectedAlertLevel!,
        'Status': currentStatus!,
      };

      setState(() {
        tableData[index] =
            updatedCalamity; // Replace the entry and trigger rebuild
      });

      print('Calamity updated successfully!');
    } else {
      print('Calamity with ID $id not found!');
    }
    resetValue();
  }

  void updateModal(int id) {
    // Find the data associated with the passed ID
    Map<String, String>? selectedData = tableData
        .firstWhere((item) => int.parse(item['ID']!) == id, orElse: () => {});

    if (selectedData.isEmpty) {
      print("Data not found for ID: $id");
      return;
    }

    // Pre-fill the fields with the selected data
    setState(() {
      calamityName = selectedData['Calamity Name'];
      selectedDate = DateTime.tryParse(selectedData['Date & Time'] ?? '') ??
          DateTime.now();
      selectedCalamityType = selectedData['Type of Calamity'];
      selectedSeverityLevel = selectedData['Security Level'];
      selectedCause = selectedData['Cause of Calamity'];
      selectedAlertLevel = selectedData['Evacuation Alert Level Issued'];
      currentStatus = selectedData['Status'];
    });

    print(selectedDate);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      'CALAMITY INFORMATION',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Table(
                      border: TableBorder.all(
                        color: Colors.transparent, // Table border color
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Calamity Name',
                                  border: OutlineInputBorder(),
                                ),
                                controller: TextEditingController(
                                  text: calamityName,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    calamityName = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(),
                            SizedBox(),
                          ],
                        ),
                        // Row 1
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DatePickerField(
                                  initialDateTime:
                                      selectedDate, // Pass initial DateTime
                                  onDateTimeSelected:
                                      (DateTime? selectedDateTime) {
                                    if (selectedDateTime != null) {
                                      print(
                                          "Selected Date & Time: $selectedDateTime");
                                      setState(() {
                                        selectedDate = selectedDateTime;
                                      });
                                    }
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownField(
                                label: 'Type of Calamity',
                                items: ['Flood', 'Typhoon'],
                                value:
                                    selectedCalamityType, // Set initial value
                                onChanged: (value) {
                                  setState(() {
                                    selectedCalamityType = value;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownField(
                                label: 'Severity Level',
                                items: [
                                  'Minor Flooding',
                                  'Moderate Flooding',
                                  'Major Flooding',
                                  'Severe Flooding',
                                  'Catastrophic Flooding',
                                ],
                                value:
                                    selectedSeverityLevel, // Set initial value
                                onChanged: (value) {
                                  setState(() {
                                    selectedSeverityLevel = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        // Row 2
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownField(
                                  label: 'Cause of Flood',
                                  items: [
                                    'Heavy Rainfall',
                                    'River Overflow',
                                    'Urban Drainage Overflow',
                                    'Typhoon',
                                  ],
                                  value: selectedCause, // Set initial value
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCause = value;
                                    });
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownField(
                                label: 'Evacuation Alert Level Issued',
                                items: [
                                  'Pre Evacuation',
                                  'Mandatory Evacuation',
                                ],
                                value: selectedAlertLevel, // Set initial value
                                onChanged: (value) {
                                  setState(() {
                                    selectedAlertLevel = value;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownField(
                                label: 'Current Status',
                                items: [
                                  'Ongoing',
                                  'Under Control',
                                  'Resolved',
                                  'Other(Specify)',
                                ],
                                value: currentStatus, // Set initial value
                                onChanged: (value) {
                                  setState(() {
                                    currentStatus = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
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
                                vertical:
                                    12.0), // Add padding for the rectangle size
                          ),
                          onPressed: () {
                            // Update the table data
                            updateCalamityData(int.parse(selectedData[
                                'ID']!)); // Update the specific calamity

                            Navigator.of(context).pop();
                          },
                          child: Text('Update',
                              style: TextStyle(
                                  fontSize: 16.0)), // Set font size and text
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
                  icon: Icon(Icons.close, color: Colors.grey),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Search input field with a limited width
            Container(
              width: 300, // Adjust this value for the desired width
              margin: EdgeInsets.only(top: 50.0, left: 40.0, right: 40.0),
              padding: EdgeInsets.only(bottom: 40),
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
                ),
                onChanged: updateSearch,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            width: 200.0, // Set the button width
            height: 50.0, // Set the button height
            margin: EdgeInsets.only(
                right: 70.0,
                left: 40.0,
                top: 10), // Add your desired margin here
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text and icon color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0), // Rectangle shape
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.4,
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 30.0),
                                Text(
                                  'CALAMITY INFORMATION',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
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
                                    2: FlexColumnWidth(1),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              labelText: 'Calamity Name',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                calamityName = value;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(), // Empty cell
                                        SizedBox(), // Empty cell
                                      ],
                                    ),
                                    // Row 1
                                    TableRow(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DatePickerField(
                                                onDateTimeSelected: (DateTime?
                                                    selectedDateTime) {
                                              if (selectedDateTime != null) {
                                                setState(() {
                                                  selectedDate =
                                                      selectedDateTime;
                                                });
                                              }
                                            })),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownField(
                                            label: 'Type of Calamity',
                                            items: ['Flood', 'Typhoon'],
                                            onChanged: (value) {
                                              setState(() {
                                                selectedCalamityType = value;
                                              });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownField(
                                            label: 'Severity Level',
                                            items: [
                                              'Minor Flooding',
                                              'Moderate Flooding',
                                              'Major Flooding',
                                              'Severe Flooding',
                                              'Catastrophic Flooding',
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                selectedSeverityLevel = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Row 2
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownField(
                                              label: 'Cause of Flood',
                                              items: [
                                                'Heavy Rainfall',
                                                'River Overflow',
                                                'Urban Drainage Overflow',
                                                'Typhoon',
                                              ],
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedCause = value;
                                                });
                                              }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownField(
                                            label:
                                                'Evacuation Alert Level Issued',
                                            items: [
                                              'Pre Evacuation',
                                              'Mandatory Evacuation',
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                selectedAlertLevel = value;
                                              });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownField(
                                            label: 'Current Status',
                                            items: [
                                              'Ongoing',
                                              'Under Control',
                                              'Resolved',
                                              'Other(Specify)',
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                currentStatus = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors
                                            .blue, // Set the background color to blue
                                        foregroundColor: Colors
                                            .white, // Set the text color to white
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8.0), // Rectangular shape with rounded corners
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0,
                                            vertical:
                                                12.0), // Add padding for the rectangle size
                                      ),
                                      onPressed: () {
                                        // Save logic here\
                                        saveCalamityData();

                                        print('Calamity information saved!');
                                        Navigator.of(context).pop();
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
                              icon: Icon(Icons.close, color: Colors.grey),
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
                    columnWidths: const {
                      0: FixedColumnWidth(100.0),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3), // More space for longer content
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(3),
                      6: FlexColumnWidth(3),
                      7: FlexColumnWidth(2),
                      8: FlexColumnWidth(2),
                    },
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
                            child: Text('Calamity Name',
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
                      ...filteredCalamities.asMap().entries.map(
                        (entry) {
                          final data = entry.value;

                          return TableRow(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CalamityDetailsScreen(
                                        calamityData: data,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data['ID']!),
                                ),
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
                                child: Text(data['Calamity Name']!),
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
                                child: Text(
                                    data['Evacuation Alert Level Issued']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data['Status']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: MenuAnchor(
                                  builder: (BuildContext context,
                                      MenuController controller,
                                      Widget? child) {
                                    return IconButton(
                                      onPressed: () {
                                        if (controller.isOpen) {
                                          controller.close();
                                        } else {
                                          controller.open();
                                        }
                                      },
                                      icon: const Icon(Icons.more_horiz),
                                      tooltip: 'Show menu',
                                    );
                                  },
                                  menuChildren: List<MenuItemButton>.generate(
                                    2,
                                    (int menuIndex) => MenuItemButton(
                                      onPressed: () {
                                        print('current id ${data['ID']}');
                                        setState(() {
                                          selectedMenu =
                                              actionButton.values[menuIndex];
                                          if (selectedMenu ==
                                              actionButton.edit) {
                                            updateModal(int.parse(data['ID']!));
                                          } else if (selectedMenu ==
                                              actionButton.delete) {
                                            int id = int.parse(data['ID']!);
                                            print(id);
                                            tableData.removeAt(id - 1);
                                            updateSearch(
                                                searchQuery); // Ensure the filtered table updates after deletion
                                          }
                                        });
                                      },
                                      child: Text(
                                        ' ${actionButton.values[menuIndex].toString().split('.').last}',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList()
                    ]
                    //end
                    )),
          ],
        ),
      ),
    );
  }
}
