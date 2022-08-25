import 'package:farm_olx/constants/constants.dart';
import 'package:farm_olx/enums/actor_type.dart';
import 'package:farm_olx/farmer_accordion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class EnterMobileNumberScreen extends StatefulWidget {
  final Function? onNextCallback;

  EnterMobileNumberScreen({this.onNextCallback, Key? key}) : super(key: key);

  @override
  _EnterMobileNumberScreenState createState() => _EnterMobileNumberScreenState();
}

class _EnterMobileNumberScreenState extends State<EnterMobileNumberScreen> {
  Key? failureAlertKey;
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  late List<String> actorTypeList = ["FPO", "Investor"];
  late String actorSelected = "";

  @override
  void initState() {
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    actorSelected = "FPO";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 48,
              ),
              Image.asset(
                "assets/images/ic_nurture_logo.png",
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 48,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextField(
                      autofocus: false,
                      controller: emailEditingController,
                      onSubmitted: (newValue) {
                        print(newValue);
                      },
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        labelText: "Email Address",
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
              Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextField(
                      autofocus: false,
                      controller: passwordEditingController,
                      obscureText: true,
                      onSubmitted: (newValue) {
                        print(newValue);
                      },
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        labelText: "Password",
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
              const SizedBox(height: 12,),
              DropdownButtonFormField2(
                decoration: InputDecoration(
                  //Add isDense true and zero Padding.
                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  //Add more decoration as you want here
                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                ),
                isExpanded: true,
                hint: const Text(
                  'Register as ...',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: actorTypeList
                    .map((item) =>
                    DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                },
                onChanged: (value) {
                  actorSelected = value.toString();
                },
                onSaved: (value) {
                  actorSelected = value.toString();
                },
              ),
              // DropdownButton<String>(
              //   // Initial Value
              //   value: actorSelected,
              //   // Down Arrow Icon
              //   icon: const Icon(Icons.keyboard_arrow_down),
              //   // Array list of items
              //   items: actorTypeList.map((String items) {
              //     return DropdownMenuItem(
              //       value: items,
              //       child: Text(items),
              //     );
              //   }).toList(),
              //   // After selecting the desired option,it will
              //   // change button value to selected value
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       actorSelected = newValue!;
              //     });
              //   },
              // ),
              Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
                child: MaterialButton(
                  onPressed: () async {
                    print("onPressed");
                    Constants.actorType = actorSelected == "FPO" ? ActorType.FPO : ActorType.INVESTOR;
                    if (actorSelected == "FPO") {
                      await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return MyForm();
                      }));
                    } else {
                      await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return const HomePage();
                      }));
                    }
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
