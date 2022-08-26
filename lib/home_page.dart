import 'package:farm_olx/invest_card.dart';
import 'package:farm_olx/model/invest_card_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'enter_mobile_number_screen.dart';

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
          groupName: "कृषि संगठन",
          farmSize: "100 Acres",
          crop: "Rice",
          budget: "₹ 50000",
          totalFarmers: "10",
          rating: "4.8"),
      InvestCardDTO(
          groupName: "युवा कृषि",
          farmSize: "150 Acres",
          crop: "Cotton",
          budget: "₹ 150000",
          totalFarmers: "17",
          rating: "4.6"),
      InvestCardDTO(
          groupName: "कृषि साथी",
          farmSize: "75 Acres",
          crop: "Grapes",
          budget: "₹ 200000",
          totalFarmers: "12",
          rating: "4.3"),
      InvestCardDTO(
          groupName: "कृषि नवोदय",
          farmSize: "200 Acres",
          crop: "Wheat",
          budget: "₹ 100000",
          totalFarmers: "15",
          rating: "4.0"),
      InvestCardDTO(
          groupName: "कृषि सारथी",
          farmSize: "150 Acres",
          crop: "Potato",
          budget: "₹ 50000",
          totalFarmers: "20",
          rating: "3.7")
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
            actions: [
              Container(
                height: 10,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.deepPurple,),
                child: MaterialButton(
                  height: 20,
                  textColor: Colors.white,
                  color: Colors.deepPurpleAccent,
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return EnterMobileNumberScreen();
                    }));
                  },
                  child: const Text("Sign out"),
                ),
              ),
            ],
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
