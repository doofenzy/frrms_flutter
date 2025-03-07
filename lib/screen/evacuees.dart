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
  List<Map<String, dynamic>> headFamilyData = [];
  List<Map<String, dynamic>> cardData = [];
  List<Map<String, dynamic>> familyMembers = [];
  String searchQuery = '';
  String evacuationCenterName = '';
  String evacuationCenterStatus = '';

  @override
  void initState() {
    super.initState();
    fetchEvacueesData();
    getEvacuationCenter();
    getEvacueeStats();
    print(widget.evacuationCenterID);
    displayEvacuees(int.parse(widget.evacuationCenterID));
    fetchHeadFamilyData();
  }

  Future<void> getEvacuationCenter() async {
    final url = Uri.parse(
        'http://127.0.0.1:8000/api/evacuation-centers/${widget.evacuationCenterID}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        setState(() {
          evacuationCenterName = data['name'];
          evacuationCenterStatus = data['type'] == 'Private Evacuation Center'
              ? 'PRIVATE EC'
              : 'PUBLIC EC';
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> displayEvacuees(int id) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/members/$id');
    try {
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          evacuees = data
              .map((item) => {
                    'ID': item['id'].toString(),
                    'Name': item['name'],
                    'Infant': item['infant'].toString(),
                    'Toddlers': item['toddlers'].toString(),
                    'Preschool': item['preschool'].toString(),
                    'School Age': item['schoolAge'].toString(),
                    'Teen Age': item['teenAge'].toString(),
                    'Adult': item['adult'].toString(),
                    'Senior Citizens': item['seniorCitizen'].toString(),
                    'Lactating Mothers': item['lactatingMothers'].toString(),
                    'Pregnant': item['pregnant'].toString(),
                    'PWD': item['pwd'].toString(),
                    'Solo Parent': item['soloParent'].toString(),
                    'Persons per Family': item['totalMembers'].toString(),
                  })
              .toList();
          filteredEvacuees = evacuees;
        });
        // print(filteredEvacuees);
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

  Future<void> getEvacueeStats() async {
    final url = Uri.parse(
        'http://127.0.0.1:8000/api/members/getEvacueeStats/${widget.evacuationCenterID}');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      print(data);
      setState(() {
        cardData = [
          {"number": data['totalPopulation'], "label": "Total Population"},
          {"number": data['totalFemales'], "label": "Females"},
          {"number": data['totalMales'], "label": "Males"},
          {"number": data['totalFamilies'], "label": "Number of Families"},
          {"number": data['totalSeniors'], "label": "Seniors"},
          {"number": data['totalUnderaged'], "label": "Underaged"},
        ];
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }

  Future<void> getHeadFamily(int id) async {
    final url =
        Uri.parse('http://127.0.0.1:8000/api/members/getHeadFamily/$id');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      setState(() {
        familyMembers = List<Map<String, dynamic>>.from(data);
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }

  Future<void> addEvacueeToEvacuationCenter(int id) async {
    final url = Uri.parse(
        'http://127.0.0.1:8000/api/members/update-evacuation-center/$id');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'evacuation_center_id': widget.evacuationCenterID,
      'calamity_id': widget.calamityID,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);
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

  Future<void> deleteMember(int id) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/members/deleteMember/$id');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      print('Member deleted');
    } else {
      print('Failed to delete member: ${response.statusCode}');
    }
  }

  Future<void> fetchHeadFamilyData() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/head-family/');
    print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        // print('Head Family Data: $data');
        setState(() {
          headFamilyData =
              data.map((item) => item as Map<String, dynamic>).toList();
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
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

  void deleteMemberEvacuee() {}

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
                '${evacuationCenterStatus} - ${evacuationCenterName}',
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15.0), // Add border radius to the card
                    ),
                    child: Container(
                      width: 240.0,
                      height: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            15.0), // Add border radius to the container
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 27, 82, 235), // Light blue

                            Color.fromARGB(255, 217, 228, 242), // Lighter blue
                          ],
                        ),
                      ),
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
                            fillColor:
                                Colors.white, // Set the fill color to white
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .grey, // Set the border color to black
                                width: 0.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .grey, // Set the border color to black
                                width: 0.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .grey, // Set the border color to black
                                width: 0.5,
                              ),
                            ),
                          ),
                          onChanged: (value) {},
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
                              Icon(
                                Icons.add,
                                size: 30.0,
                                color: Colors.white,
                              ), // Add icon
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
                columnWidths: {
                  0: FlexColumnWidth(0.5),
                  1: FlexColumnWidth(2.0),
                  8: FlexColumnWidth(1.5),
                  9: FlexColumnWidth(1.5), // Name of Family Head
                },
                children: [
                  // Table header row
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('HH Id',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text('Name of Family Head',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Infant\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: '> 1 y/o',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      10, // Set the font size for the non-bold text
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Toddlers\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: '> 1-3 y/o',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      10, // Set the font size for the non-bold text
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Preschool\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: '4-5 y/o',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      10, // Set the font size for the non-bold text
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'School Age\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: '6-12 y/o',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      10, // Set the font size for the non-bold text
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Teen Age\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: '13-19 y/o',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      10, // Set the font size for the non-bold text
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Adult\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: '20-59 y/o',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      10, // Set the font size for the non-bold text
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Senior Citizens\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: '<60 and above',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      10, // Set the font size for the non-bold text
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Lactating Mothers',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text('Pregnant',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text('PWD',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text('Solo Parent',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('# of Persons per Family',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text('Actions',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
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
                          child: Text(evacuee['Persons per Family']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 100,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                print(familyMembers);
                                getHeadFamily(int.parse(evacuee['ID']));
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: Container(
                                            width:
                                                1300.0, // Set the desired width
                                            height:
                                                800.0, // Set the desired height
                                            child: Column(
                                              children: [
                                                // Header with "X" button
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.0),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Household Information',
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Icon(Icons.close),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Dialog content
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'HOUSEHOLD INFORMATION',
                                                          style: TextStyle(
                                                            fontSize: 30.0,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 16.0),
                                                        Container(
                                                          width: 1300.0,
                                                          height: 600,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .account_circle_rounded,
                                                                      size:
                                                                          200.0, // Adjust the size as needed
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            40.0),
                                                                    Expanded(
                                                                      child:
                                                                          Table(
                                                                        border: TableBorder.all(
                                                                            style:
                                                                                BorderStyle.none), // Remove the outline of the table
                                                                        children:
                                                                            List.generate(
                                                                          5,
                                                                          (rowIndex) {
                                                                            return TableRow(
                                                                              children: List.generate(4, (colIndex) {
                                                                                // Calculate the actual index in the fields list
                                                                                int actualIndex = rowIndex * 4 + colIndex;

                                                                                // Get the corresponding data from headFamilyData using evacuee['ID']
                                                                                final headFamily = headFamilyData[int.parse(evacuee['ID']) - 1];

                                                                                // Define the fields to display in the table (excluding last item)
                                                                                final allFields = [
                                                                                  headFamily['fname'],
                                                                                  headFamily['lname'],
                                                                                  headFamily['mname'],
                                                                                  headFamily['suffix'],
                                                                                  headFamily['zone'],
                                                                                  headFamily['lot'],
                                                                                  headFamily['status'],
                                                                                  headFamily['phone_number'],
                                                                                  headFamily['religion'],
                                                                                  headFamily['birthdate'],
                                                                                  headFamily['age'],
                                                                                  headFamily['gender'],
                                                                                  headFamily['occupation'],
                                                                                  headFamily['group'],
                                                                                  headFamily['four_p'],
                                                                                  headFamily['gov_id'],
                                                                                  headFamily['brgy'],
                                                                                  headFamily['relationship'],
                                                                                  headFamily['evacuation_type']
                                                                                ]; // Now contains exactly 19 items

                                                                                // Prevent out-of-bounds errors by stopping when actualIndex exceeds fields length
                                                                                if (actualIndex >= allFields.length) {
                                                                                  return SizedBox(); // Remove input field
                                                                                }

                                                                                String value = allFields[actualIndex]?.toString() ?? '';

                                                                                // print(actualIndex); // Now prints 0-18 (only 19 items)

                                                                                return Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: TextField(
                                                                                    readOnly: true,
                                                                                    decoration: InputDecoration(
                                                                                      contentPadding: EdgeInsets.all(8.0),
                                                                                      border: OutlineInputBorder(),
                                                                                      hintText: value,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                  color: Colors
                                                                      .grey,
                                                                  thickness:
                                                                      1.0,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: familyMembers
                                                                      .asMap()
                                                                      .entries
                                                                      .map(
                                                                          (entry) {
                                                                    final data =
                                                                        entry
                                                                            .value;
                                                                    return Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.account_circle_rounded,
                                                                              size: 200.0,
                                                                              color: Colors.grey,
                                                                            ),
                                                                            SizedBox(width: 40.0),
                                                                            Expanded(
                                                                              child: Table(
                                                                                border: TableBorder.all(style: BorderStyle.none),
                                                                                children: List.generate(4, (rowIndex) {
                                                                                  return TableRow(
                                                                                    children: List.generate(4, (colIndex) {
                                                                                      List<String> keys = data.keys.where((key) => key != "id").toList();
                                                                                      int index = rowIndex * 4 + colIndex;
                                                                                      if (index >= keys.length) {
                                                                                        return SizedBox();
                                                                                      }
                                                                                      String key = keys[index];
                                                                                      return Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: TextField(
                                                                                          enabled: true,
                                                                                          decoration: InputDecoration(
                                                                                            contentPadding: EdgeInsets.all(8.0),
                                                                                            border: OutlineInputBorder(),
                                                                                            disabledBorder: OutlineInputBorder(
                                                                                              borderSide: BorderSide(color: Colors.grey),
                                                                                            ),
                                                                                            hintText: data[key].toString(),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    }),
                                                                                  );
                                                                                }),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                20.0),
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              ElevatedButton.icon(
                                                                            onPressed:
                                                                                () {
                                                                              deleteMember(data['id']);
                                                                            },
                                                                            icon:
                                                                                Icon(Icons.delete),
                                                                            label:
                                                                                Text("Delete"),
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.redAccent,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                10.0),
                                                                        Divider(
                                                                            color:
                                                                                Colors.grey,
                                                                            thickness: 1.0),
                                                                      ],
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0), // Adjust padding if needed
                                textStyle: TextStyle(
                                    fontSize:
                                        12.0), // Set the font size to a smaller value
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Set the border radius
                                  side: BorderSide(
                                      color:
                                          Colors.blue), // Set the outline color
                                ),
                                backgroundColor:
                                    Colors.white, // Set the background color
                                foregroundColor:
                                    Colors.blue, // Set the text color
                              ).copyWith(
                                overlayColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue
                                        .withOpacity(0.2); // Hover color
                                  }
                                  return null;
                                }),
                              ),
                              child: Text('Update'),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
