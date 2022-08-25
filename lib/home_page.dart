import 'package:farm_olx/invest_card.dart';
import 'package:farm_olx/model/invest_card_dto.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<InvestCardDTO> investCardsList = [];

  @override
  void initState() {
    investCardsList.addAll([
      InvestCardDTO(
          groupName: "Axis Group",
          farmSize: "100",
          crop: "Rice",
          budget: "Rs 5000",
          totalFarmers: "10"),
      InvestCardDTO(
          groupName: "Axis Group",
          farmSize: "100",
          crop: "Rice",
          budget: "Rs 5000",
          totalFarmers: "10"),
      InvestCardDTO(
          groupName: "Axis Group",
          farmSize: "100",
          crop: "Rice",
          budget: "Rs 5000",
          totalFarmers: "10"),
      InvestCardDTO(
          groupName: "Axis Group",
          farmSize: "100",
          crop: "Rice",
          budget: "Rs 5000",
          totalFarmers: "10"),
      InvestCardDTO(
          groupName: "Axis Group",
          farmSize: "100",
          crop: "Rice",
          budget: "Rs 5000",
          totalFarmers: "10")
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            bottom: const TabBar(
              tabs: [
                Tab(text: "Funds List",),
                Tab(text: "Mutual Farm Exchange",),
              ],
            ),
            title: const Text('Funds'),
          ),
          body: TabBarView(
            children: [
              SafeArea(
                child: Scaffold(
                  body: Container(
                    alignment: Alignment.center,
                    child: ListView.builder(
                        itemCount: investCardsList.length,
                        itemBuilder: (context, index) {
                          return InvestCard(investCardDTO: investCardsList[index]);
                        }),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/fund_icon.png", height: 100, width: 100,),
                  const SizedBox(height: 16,),
                  const Text("Coming soon...", style: TextStyle(fontSize: 20),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
