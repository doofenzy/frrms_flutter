import 'package:flutter/material.dart';
import '../context/dateField.dart';
import '../context/dropDownField.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'dart:convert';

enum actionButton { View_Information, View_Information_Board }

class EvacuationManagement extends StatefulWidget {
  @override
  _EvacuationManagementState createState() => _EvacuationManagementState();
}

class _EvacuationManagementState extends State<EvacuationManagement> {
  final List<Map<String, String>> tableData = [];

  actionButton? selectedMenu;
  int? id;
  String? selectedCalamityType;
  String? selectedSeverityLevel;
  String? selectedCause;
  String? selectedAlertLevel;
  String? currentStatus;
  String? calamityName;
  DateTime? selectedDate;

  Future<void> postData() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/calamities');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'calamity_name': calamityName,
      'type': selectedCalamityType,
      'severity_level': selectedSeverityLevel,
      'cause': selectedCause,
      'alert_level': selectedAlertLevel,
      'status': currentStatus,
      'date': selectedDate?.toIso8601String(),
    });

    print('Body: $body');

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        final newItem = jsonDecode(response.body);

        setState(() {
          tableData.add({
            'ID': newItem['id'].toString(),
            'Date & Time': newItem['date'],
            'Type of Calamity': newItem['type'],
            'Calamity Name': newItem['calamity_name'],
            'Security Level': newItem['severity_level'],
            'Cause of Calamity': newItem['cause'],
            'Evacuation Alert Level Issued': newItem['alert_level'],
            'Status': newItem['status'],
          });
          updateFilteredCalamities();
        });

        print('Data posted successfully');

        print('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting data: $e');
    }
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/calamities');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          tableData.clear();
          for (var item in data) {
            tableData.add({
              'ID': item['id'].toString(),
              'Date & Time': item['date'],
              'Type of Calamity': item['type'],
              'Calamity Name': item['calamity_name'],
              'Security Level': item['severity_level'],
              'Cause of Calamity': item['cause'],
              'Evacuation Alert Level Issued': item['alert_level'],
              'Status': item['status'],
            });
          }
          updateFilteredCalamities();
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> deleteData(int id) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/calamities/$id');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 204) {
        print('Data deleted successfully');

        setState(() {
          tableData.removeWhere((item) => item['ID'] == id.toString());
          updateFilteredCalamities();
        });
      } else {
        print('Failed to delete data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  Future<void> updateCalamityData(int id) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/calamities/$id');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'calamity_name': calamityName,
      'type': selectedCalamityType,
      'severity_level': selectedSeverityLevel,
      'cause': selectedCause,
      'alert_level': selectedAlertLevel,
      'status': currentStatus,
      'date': selectedDate?.toIso8601String(),
    });

    try {
      final response = await http.patch(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final updatedItem = jsonDecode(response.body);
        setState(() {
          final index =
              tableData.indexWhere((item) => item['ID'] == id.toString());
          if (index != -1) {
            tableData[index] = {
              'ID': updatedItem['id'].toString(),
              'Date & Time': updatedItem['date'],
              'Type of Calamity': updatedItem['type'],
              'Calamity Name': updatedItem['calamity_name'],
              'Security Level': updatedItem['severity_level'],
              'Cause of Calamity': updatedItem['cause'],
              'Evacuation Alert Level Issued': updatedItem['alert_level'],
              'Status': updatedItem['status'],
            };
            updateFilteredCalamities();
          }
        });
        print('Data updated successfully');
      } else {
        print('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  List<Map<String, String>> filteredCalamities = [];
  String searchQuery = '';

  void updateFilteredCalamities() {
    setState(() {
      filteredCalamities = tableData.where((calamity) {
        return calamity.values.any((value) => value.contains(searchQuery));
      }).toList();
    });
  }

  void resetValue() {
    setState(() {
      selectedCalamityType = null;
      selectedSeverityLevel = null;
      selectedCause = null;
      selectedAlertLevel = null;
      currentStatus = null;
      calamityName = null;
      selectedDate = null;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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

  void updateModal(int id) {
    Map<String, String>? selectedData = tableData
        .firstWhere((item) => int.parse(item['ID']!) == id, orElse: () => {});

    if (selectedData.isEmpty) {
      print("Data not found for ID: $id");
      return;
    }

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
                width: 900,
                height: 400,
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
                        color: Colors.transparent,
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
                                  initialDateTime: selectedDate,
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
                                value: selectedCalamityType,
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
                                value: selectedSeverityLevel,
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
                                  value: selectedCause,
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
                                value: selectedAlertLevel,
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
                                value: currentStatus,
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
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 12.0),
                          ),
                          onPressed: () {
                            //   updateCalamityData(int.parse(selectedData[
                            //       'ID']!)); // Update the specific calamity
                            //   print(int.parse(selectedData['ID']!));

                            //   Navigator.of(context).pop();
                            // },onPressed: () {
                            if (calamityName == null || calamityName!.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Incomplete Information'),
                                    content: Text(
                                        'Please fill out all fields before saving.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              updateCalamityData(int.parse(selectedData[
                                  'ID']!)); // Update the specific calamity
                              print(int.parse(selectedData['ID']!));
                              resetValue();
                              Navigator.of(context).pop();
                            }
                          },
                          child:
                              Text('Update', style: TextStyle(fontSize: 16.0)),
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
            Container(
              width: 300,
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
            width: 200.0,
            height: 50.0,
            margin: EdgeInsets.only(right: 70.0, left: 40.0, top: 10),
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
                            width: 900,
                            height: 400,
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
                                    color: Colors.transparent,
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
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 12.0),
                                      ),
                                      onPressed: () {
                                        if ((calamityName == null ||
                                                calamityName!.isEmpty) ||
                                            selectedDate == null ||
                                            (selectedCalamityType == null ||
                                                selectedCalamityType!
                                                    .isEmpty) ||
                                            (selectedSeverityLevel == null ||
                                                selectedSeverityLevel!
                                                    .isEmpty) ||
                                            (selectedCause == null ||
                                                selectedCause!.isEmpty) ||
                                            (selectedAlertLevel == null ||
                                                selectedAlertLevel!.isEmpty) ||
                                            (currentStatus == null ||
                                                currentStatus!.isEmpty)) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Incomplete Information'),
                                                content: Text(
                                                    'Please fill out all fields before saving.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          postData();
                                          resetValue();
                                          print('Calamity information saved!');
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text('Save',
                                          style: TextStyle(fontSize: 16.0)),
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
              icon: Icon(Icons.add, size: 18.0),
              label: Text(
                'Add Calamity',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            // Table widget with margin
            Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Table(
                    border: TableBorder(
                      left: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      right: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      horizontalInside: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      top: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    columnWidths: const {
                      0: FixedColumnWidth(100.0),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
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

                      ...filteredCalamities.asMap().entries.map(
                        (entry) {
                          final data = entry.value;

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
                                              actionButton.View_Information) {
                                            updateModal(int.parse(data['ID']!));
                                          } else if (selectedMenu ==
                                              actionButton
                                                  .View_Information_Board) {
                                            context.go(
                                              '/calamityDetails/${data['ID']!}/${data['Calamity Name']!}',
                                            );
                                          } else {
                                            print('Invalid action');
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
