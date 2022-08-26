import 'package:farm_olx/model/invest_card_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvestCard extends StatefulWidget {
  final InvestCardDTO investCardDTO;

  InvestCard({Key? key, required this.investCardDTO}) : super(key: key);


  @override
  State<InvestCard> createState() => _InvestCardState();
}

class _InvestCardState extends State<InvestCard> {

  late TextEditingController investAmountController;

  @override
  void initState() {
    investAmountController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xD3E7C5FF),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/images/fund_icon.png",
                      width: 25,
                      height: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.investCardDTO.groupName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  rating(widget.investCardDTO.rating)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  subDetails(
                      "Total Farmers", widget.investCardDTO.totalFarmers),
                  subDetails("Fam Size", widget.investCardDTO.farmSize),
                  subDetails("Crop Name", widget.investCardDTO.crop),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Budget",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(widget.investCardDTO.budget),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.deepPurpleAccent),
                    child: MaterialButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                                top: 16,
                                left: 16,
                                right: 16,
                              ),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: TextField(
                                          autofocus: true,
                                          controller: investAmountController,
                                          onSubmitted: (newValue) {
                                            print(newValue);
                                          },
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4),],
                                          textAlign: TextAlign.left,
                                          decoration: const InputDecoration(
                                            labelText: "Invested Amount",
                                            labelStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  const Text(
                                    'x amount already invested',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16,),
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.deepPurple,),
                                    width: double.infinity,
                                    child: MaterialButton(
                                      height: 48,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        var snackBar = SnackBar(
                                          content: Text('You have successfully invested ₹ ${investAmountController.text}'),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                      child: const Text('Invest now', style: TextStyle(color: Colors.white,),),
                                    ),
                                  ),
                                  const SizedBox(height: 16,),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Invest Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget rating(String stars) {
    return Row(
      children: [
        Image.asset(
          "assets/images/ic_star.png",
          width: 25,
          height: 25,
        ),
        const SizedBox(width: 5,),
        Text(stars,style: const TextStyle(color: Colors.orangeAccent),)
      ],
    );
  }

  Widget subDetails(String title, String subTitle) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          subTitle,
          style: const TextStyle(color: Colors.green),
        )
      ],
    );
  }
}
