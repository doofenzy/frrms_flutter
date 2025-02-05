import 'package:flutter/material.dart';
import '../component/header.dart';
import '../component/sidebar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EvacueesScreen extends StatefulWidget {
  final String evacuationCenterID;
  final String calamityID;
  EvacueesScreen({required this.evacuationCenterID, required this.calamityID});

  @override
  _EvacueesScreenState createState() => _EvacueesScreenState();
}

class _EvacueesScreenState extends State<EvacueesScreen> {
  List<Map<String, dynamic>> evacueesData = [];
  List<Map<String, dynamic>> filteredEvacueesData = [];
  List<Map<String, dynamic>> evacuees = [];
  List<Map<String, dynamic>> filteredEvacuees = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchEvacueesData();
    displayEvacuees(int.parse(widget.evacuationCenterID));
  }

  final List<Map<String, dynamic>> cardData = [
    {"number": 800, "label": "Total Population"},
    {"number": 232, "label": "Females"},
    {"number": 568, "label": "Males"},
    {"number": 120, "label": "Number of Families"},
    {"number": 50, "label": "Seniors"},
    {"number": 50, "label": "Underaged"},
  ];

  Future<void> displayEvacuees(int id) async {
    final url = Uri.parse(
        'http://127.0.0.1:8000/api/evacuees?evacuation_center_id=$id');
    print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          evacuees = data
              .map((item) => {
                    'ID': item['id'].toString(),
                    'Name': item['head_family'],
                    'Infant': item['infant'].toString(),
                    'Toddlers': item['toddlers'].toString(),
                    'Preschool': item['preschool'].toString(),
                    'School Age': item['school_age'].toString(),
                    'Teen Age': item['teen_age'].toString(),
                    'Adult': item['adult'].toString(),
                    'Senior Citizens': item['senior_citizen'].toString(),
                    'Persons per Family': item['total_persons'].toString(),
                    'Lactating Mothers': item['lactating_mothers'].toString(),
                    'Pregnant': item['pregnant'].toString(),
                    'PWD': item['pwd'].toString(),
                    'Solo Parent': item['solo_parent'].toString(),
                  })
              .toList();
          filteredEvacuees = evacuees;
        });
        print(filteredEvacuees);
      } else {
        print('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  Future<void> fetchEvacueesData() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/evacuees');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          evacueesData = data
              .map((item) => {
                    'ID': item['id'].toString(),
                    'Name': item['head_family'],
                  })
              .toList();
          filteredEvacueesData = evacueesData;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void updateFilteredEvacuees() {
    setState(() {
      filteredEvacueesData = evacueesData.where((evacuees) {
        return evacuees.values.any((value) {
          if (value is String) {
            return value.toLowerCase().contains(searchQuery.toLowerCase());
          }
          return false;
        });
      }).toList();
    });
  }

  Future<void> addEvacueeToEvacuationCenter(int id) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/evacuees/$id');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'evacuation_center_id': widget.evacuationCenterID,
      'calamity_id': widget.calamityID
    });

    try {
      final response = await http.patch(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // final dynamic data = jsonDecode(response.body);
        // setState(() {
        //   evacueesData = evacueesData.map((item) {
        //     if (item['ID'] == id.toString()) {
        //       return {
        //         'ID': data['id'].toString(),
        //         'Name': data['head_family'],
        //       };
        //     }
        //     return item;
        //   }).toList();
        //   filteredEvacueesData = evacueesData;
        // });
        print('success');
      } else {
        print('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  void resetSearch() {
    setState(() {
      searchQuery = '';
      filteredEvacueesData = evacueesData;
    });
  }

  void updateSearchQuery(String query) {
    print('Search query: $query');
    setState(() {
      searchQuery = query;
      updateFilteredEvacuees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HeaderWidget(
          imagePath: '../assets/Logo.png',
        ),
      ),
      drawer: Sidebar(
        onItemTapped: (index) {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
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
              margin: const EdgeInsets.only(left: 16.0),
              child: Text(
                'An Overview of Evacuees',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Card(
                    elevation: 4.0,
                    child: Container(
                      color: const Color.fromARGB(255, 106, 153, 236),
                      width: 240.0,
                      height: 130.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${cardData[index]["number"]}',
                              style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
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
              margin: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300.0,
                    height: 130.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
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
                        width: 300,
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
                        width: 200.0,
                        height: 50.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 12.0,
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: Text('Search'),
                                      content: Container(
                                        width: 400.0,
                                        height: 400.0,
                                        child: Column(
                                          children: [
                                            TextField(
                                              decoration: InputDecoration(
                                                hintText: 'Search...',
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                prefixIcon: Icon(Icons.search),
                                                filled: true,
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  searchQuery = value;
                                                  filteredEvacueesData =
                                                      evacueesData
                                                          .where((evacuees) {
                                                    return evacuees.values
                                                        .any((val) {
                                                      if (val is String) {
                                                        return val
                                                            .toLowerCase()
                                                            .contains(searchQuery
                                                                .toLowerCase());
                                                      }
                                                      return false;
                                                    });
                                                  }).toList();
                                                });
                                              },
                                            ),
                                            SizedBox(height: 16.0),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: filteredEvacueesData
                                                    .length, // Number of rows
                                                itemBuilder: (context, index) {
                                                  final evacuee =
                                                      filteredEvacueesData[
                                                          index];
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            '${evacuee['ID']}'),
                                                        Text(
                                                            '${evacuee['Name']}'),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            addEvacueeToEvacuationCenter(
                                                                int.parse(
                                                                    evacuee[
                                                                        'ID']));
                                                            print(
                                                                'Add button pressed for ID ${evacuee['ID']}');
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
                                            resetSearch();
                                          },
                                          child: Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, size: 20.0), // Add icon
                              SizedBox(width: 8.0),
                              Text(
                                'Add Evacuee',
                                style: TextStyle(fontSize: 16.0),
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
                      ...filteredEvacuees.map((evacuee) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['ID']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['Name']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['Infant']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['Toddlers']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['Preschool']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['School Age']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['Teen Age']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['Adult']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['Senior Citizens']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['Persons per Family']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['Lactating Mothers']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['Pregnant']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['PWD']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(evacuee['Solo Parent']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  addEvacueeToEvacuationCenter(
                                      int.parse(evacuee['ID']));
                                  print(
                                      'Add button pressed for ID ${evacuee['ID']}');
                                },
                                child: Text('Add'),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ])),
          ],
        ),
      ),
    );
  }
}
