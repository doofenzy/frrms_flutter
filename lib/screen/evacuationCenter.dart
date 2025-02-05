import 'package:flutter/material.dart';
import '../component/header.dart';
import '../component/sidebar.dart';
import '../context/dropDownField.dart';
import '../screen/evacuees.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalamityDetailsScreen extends StatefulWidget {
  final int calamityID;
  final String calamityName;

  CalamityDetailsScreen({required this.calamityID, required this.calamityName});

  @override
  _CalamityDetailsScreenState createState() => _CalamityDetailsScreenState();
}

class _CalamityDetailsScreenState extends State<CalamityDetailsScreen> {
  String? evacuationCenterName;
  String? zone;
  String? evacuationType;
  String? nameOfSiteManager;
  String? contactInformation;
  int? evacueesCount = 0;
  final List<Map<String, dynamic>> evacueeData = [
    {"description": "Infant\n(<1 yrs. old)", "count": 0},
    {"description": "School Age\n(6-9 yrs. old)", "count": 0},
    {"description": "Senior Citizen\n(>59 yrs. old)", "count": 0},
    {"description": "Person with\ndisabilities", "count": 0},
    {"description": "Todler\n(1-3 yrs. old)", "count": 0},
    {"description": "Teenage\n(13-19 yrs. old)", "count": 0},
    {"description": "Pregnant\nWomen", "count": 0},
    {"description": "Single Headed", "count": 0},
    {"description": "Pre-Schooler\n(4-5 yrs. old)", "count": 0},
    {"description": "Adult\n(20-59 yrs. old)", "count": 0},
    {"description": "Breastfeeding\nMothers", "count": 0},
    {"description": "Person with\n Serious Illness", "count": 0},
  ];

  Future<void> fetchSumData() async {
    final url = Uri.parse(
        'http://127.0.0.1:8000/api/evacuees/calamity/${widget.calamityID}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        int totalEvacuees = 0;
        setState(() {
          for (var item in evacueeData) {
            item['count'] = 0;
          }

          for (var item in data) {
            evacueeData[0]['count'] += item['infant'] ?? 0;
            evacueeData[1]['count'] += item['school_age'] ?? 0;
            evacueeData[2]['count'] += item['senior_citizen'] ?? 0;
            evacueeData[3]['count'] += item['pwd'] ?? 0;
            evacueeData[4]['count'] += item['toddlers'] ?? 0;
            evacueeData[5]['count'] += item['teen_age'] ?? 0;
            evacueeData[6]['count'] += item['pregnant'] ?? 0;
            evacueeData[7]['count'] += item['solo_parent'] ?? 0;
            evacueeData[8]['count'] += item['preschool'] ?? 0;
            evacueeData[9]['count'] += item['adult'] ?? 0;
            evacueeData[10]['count'] += item['lactating_mothers'] ?? 0;
            evacueeData[11]['count'] += item['serious_illness'] ?? 0;
          }

          totalEvacuees =
              evacueeData.fold(0, (sum, item) => sum + (item['count'] as int));
          evacueesCount = totalEvacuees;
        });
        print('Total evacuees: $evacueesCount');
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> postData() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/evacuation-centers');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': evacuationCenterName,
      'zone': zone,
      'type': evacuationType,
      'contact_person': nameOfSiteManager,
      'contact_number': contactInformation,
      // 'calamityName': calamityName,
      'calamity_id': widget.calamityID,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        print('Data posted successfully');
        fetchData();
      }
    } catch (e) {
      print('Error posting data: $e');
    }
  }

  final List<Map<String, String>> datas = [];

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://127.0.0.1:8000/api/evacuation-centers/calamity/${widget.calamityID}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          datas.clear(); // Clear the existing data
          for (var item in data) {
            datas.add({
              'id': item['id'].toString(),
              'location': item['name'].toString(),
              'Zone': item['zone'].toString(),
              'Type': item['type'].toString(),
              'Contact Person': item['contact_person'].toString(),
              'Contact Number': item['contact_number'].toString(),
            });
          }
        });
        print(datas);
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchSumData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: HeaderWidget(
            imagePath: '../../assets/Logo.png',
          ),
        ),
        drawer: Sidebar(
          onItemTapped: (index) {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(12.0),
              padding: EdgeInsets.all(12.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        height: 315.0,
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              color: Color(0xFFEAF1FF),
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.calamityName}',
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
                                  SizedBox(height: 10.0),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, left: 90),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            height: 150,
                                            child: CircularProgressIndicator(
                                              value: evacueesCount! / 100,
                                              strokeWidth: 10.0,
                                              backgroundColor: Colors.grey[300],
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                evacueesCount! >= 85
                                                    ? Colors.red
                                                    : evacueesCount! >= 45
                                                        ? Colors.yellow
                                                        : Colors.green,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Overall Total\n of Evacuees',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 2.0),
                                              Text(
                                                '${evacueesCount!}',
                                                style: TextStyle(
                                                  fontSize: 40.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.7, // Adjust width
                                  height: 300.0,
                                  margin:
                                      EdgeInsets.only(left: 32.0, right: 16.0),
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
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 12,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 3.5,
                                        mainAxisSpacing: 8.0,
                                        crossAxisSpacing: 8.0,
                                      ),
                                      itemBuilder: (context, index) {
                                        final data = evacueeData[index];
                                        final count = data['count'];
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 16.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: count / 100,
                                                      strokeWidth: 6.0,
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        count >= 85
                                                            ? Colors.red
                                                            : count >= 45
                                                                ? Colors.yellow
                                                                : Colors.green,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '$count',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 10.0),
                                              Expanded(
                                                child: Text(
                                                  data['description'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                            )
                          ],
                        )),
                    SizedBox(height: 20.0),
                    Container(
                      height: 500.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Evacuation Center List',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
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
                                                  width: 900,
                                                  height: 350,
                                                  padding: EdgeInsets.all(20.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                              .transparent,
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
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    TextField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Name of Evacuation Center',
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      evacuationCenterName =
                                                                          value;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      DropdownField(
                                                                    label:
                                                                        'Zone',
                                                                    items: [
                                                                      '1',
                                                                      '2',
                                                                      '3',
                                                                    ],
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        zone =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
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
                                                                    setState(
                                                                        () {
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
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    TextField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Name of Site Manager',
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      nameOfSiteManager =
                                                                          value;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    TextField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Contact Information',
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
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
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              foregroundColor:
                                                                  Colors.white,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.0,
                                                                      vertical:
                                                                          12.0),
                                                            ),
                                                            onPressed: () {
                                                              //   updateCalamityData(int.parse(selectedData[
                                                              //       'ID']!)); // Update the specific calamity
                                                              //   print(int.parse(selectedData['ID']!));

                                                              //   Navigator.of(context).pop();
                                                              // },onPressed: () {
                                                              if ((evacuationCenterName == null || evacuationCenterName!.isEmpty) ||
                                                                  (zone ==
                                                                          null ||
                                                                      zone!
                                                                          .isEmpty) ||
                                                                  (evacuationType ==
                                                                          null ||
                                                                      evacuationType!
                                                                          .isEmpty) ||
                                                                  (nameOfSiteManager ==
                                                                          null ||
                                                                      nameOfSiteManager!
                                                                          .isEmpty) ||
                                                                  (contactInformation ==
                                                                          null ||
                                                                      contactInformation!
                                                                          .isEmpty)) {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          'Incomplete Information'),
                                                                      content: Text(
                                                                          'Please fill out all fields before saving.'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text('OK'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              } else {
                                                                postData();

                                                                print(
                                                                    'Calamity information saved!');
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }
                                                            },
                                                            child: Text('Save',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0)),
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
                                                      Navigator.of(context)
                                                          .pop();
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
                                        color: Colors.white, size: 16),
                                    label: Text('Add Evacuation Center'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),
                          Expanded(
                            child: GridView.builder(
                              itemCount: datas.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 20.0,
                                crossAxisSpacing: 20.0,
                                childAspectRatio: 2.7,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                              EvacueesScreen(
                                                            evacuationCenterID:
                                                                data['id']
                                                                    .toString(),
                                                            calamityID: widget
                                                                .calamityID
                                                                .toString(),
                                                          ),
                                                        ));
                                                    break;
                                                  case 'ViewReliefInventory':
                                                    print(
                                                        'Edit button pressed');
                                                    break;
                                                }
                                              },
                                              itemBuilder:
                                                  (BuildContext context) =>
                                                      <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(
                                                  value: 'ViewEvacuess',
                                                  child: Text('View Evacuees'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: 'ViewReliefInventory',
                                                  child: Text(
                                                      'View Relief Inventory'),
                                                ),
                                              ],
                                              icon: Icon(Icons.more_horiz,
                                                  size: 16.0),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.0),
                                        // Wrap content to avoid overflow
                                        Expanded(
                                          child: ListView(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            children: data.entries
                                                .where((entry) =>
                                                    entry.key != 'id')
                                                .map((entry) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 4.0),
                                                      child: Text(
                                                        '${entry.key}: ${entry.value}',
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          color:
                                                              Colors.grey[700],
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
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
        ));
  }
}
