import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EnterMobileNumberScreen extends StatefulWidget {
  final Function? onNextCallback;

  EnterMobileNumberScreen({this.onNextCallback, Key? key}) : super(key: key);

  @override
  _EnterMobileNumberScreenState createState() =>
      _EnterMobileNumberScreenState();
}

class _EnterMobileNumberScreenState extends State<EnterMobileNumberScreen> {

  Key? failureAlertKey;
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  late List<String> actorTypeList = ["Farmer","Investor"];
  late String actorSelected = "";

  @override
  void initState() {
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    actorSelected = "Farmer";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            TextField(
              autofocus: true,
              controller: emailEditingController,
              decoration: const InputDecoration(hintText: "Email Address"),

              onSubmitted: (newValue){
                print(newValue);
              },
            ),
            TextField(
              autofocus: true,
              controller: passwordEditingController,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
              onSubmitted: (newValue){
                print(newValue);
              },
            ),
            DropdownButton<String>(

              // Initial Value
              value: actorSelected,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: actorTypeList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  actorSelected = newValue!;
                });
              },
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom)),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(20)
              ),
              child: MaterialButton(
                onPressed: () async{
                  print("onPressed");
                  try {
                    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailEditingController.text,
                      password: passwordEditingController.text,
                    );
                    print("${credential.user?.displayName}");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }

                },
                child: const Text("Next"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
