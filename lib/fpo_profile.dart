import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'enter_mobile_number_screen.dart';

class FpoProfile extends StatefulWidget {
  final List<String> farmersList;
  final List<String> acresList;
  final List<String> idCardList;
  final String groupName;
  final String cropName;

  const FpoProfile({Key? key, required this.farmersList, required this.acresList, required this.idCardList, required this.groupName, required this.cropName}) : super(key: key);

  @override
  State<FpoProfile> createState() => _FpoProfileState();
}

class _FpoProfileState extends State<FpoProfile> {

  Map<String, double> data = new Map();
  final List<Color> _colors = [
    Colors.teal,
    Colors.blueAccent,
  ];

  @override
  void initState() {
    data.addAll({
      '% invested': 2000,
      'Remaining': 3000,
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.farmersList[0]);
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: const Text('Profile'),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Investment Details",),
                Tab(text: "About",),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PieChart(
                    dataMap: data,
                    colorList:
                    _colors, // if not declared, random colors will be chosen
                    animationDuration: const Duration(milliseconds: 1500),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width /
                        2.7, //determines the size of the chart
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    showLegends: true,
                    legendPosition:
                    LegendPosition.right, //can be changed to top, left, bottom
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900],
                    ),
                    chartType: ChartType.disc, //can be changed to ChartType.ring
                  )
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                      child: const Text(
                        'Group details',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Card(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Group Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  "Crop Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.groupName,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  widget.cropName,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                      child: const Text(
                        'Landowner details',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Card(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Farmer Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  "Acres",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  "PAN Number",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    for (int i = 0; i < widget.farmersList.length; i++)
                      Card(
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.farmersList[i],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    widget.acresList[i],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    widget.idCardList[i],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 48,),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey,),
                        width: 100,
                        child: MaterialButton(
                          height: 20,
                          elevation: 10,
                          textColor: Colors.white,
                          onPressed: () async {
                            FirebaseAuth.instance.signOut();
                            await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return EnterMobileNumberScreen();
                            }));
                          },
                          child: const Text("Sign out"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
