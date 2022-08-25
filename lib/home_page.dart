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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FPO'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          alignment: Alignment.center,
          child: ListView.builder(
              itemCount: investCardsList.length,
              itemBuilder: (context, index) {
                return InvestCard(investCardDTO: investCardsList[index]);
              }),
        ),
      ),
    );
  }
}
