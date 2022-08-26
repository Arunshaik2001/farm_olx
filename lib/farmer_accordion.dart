import 'package:farm_olx/enter_mobile_number_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fpo_profile.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _cropController;
  static List<String> farmersList = [""];
  static List<String> acresList = [""];
  static List<String> idCardList = [""];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _cropController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Register group details'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name textfield
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _nameController,
                          validator: (v) {
                            if (v!.trim().isEmpty) return 'Please enter something';
                            return null;
                          },
                          autofocus: true,
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            labelText: "Enter group name",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: TextFormField(
                    controller: _cropController,
                    validator: (v) {
                      if (v!.trim().isEmpty) return 'Please enter something';
                      return null;
                    },
                    autofocus: true,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      labelText: "Enter crop name",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                    ),
                  ),
                ),
                ..._getFriends(),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.deepPurple,),
                  width: double.infinity,
                  child: MaterialButton(
                    height: 48,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return FpoProfile(
                            farmersList: farmersList,
                            acresList: acresList,
                            idCardList: idCardList,
                            cropName: _cropController.text,
                            groupName: _nameController.text,
                          );
                        }));
                      }
                    },
                    child: const Text('Submit', style: TextStyle(fontSize: 20,color: Colors.white),),
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
        ),
      ),
    );
  }

  /// get firends text-fields
  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < farmersList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: FriendTextFields(i)),
            const SizedBox(
              height: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == farmersList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          farmersList.insert(index + 1, "");
          acresList.insert(index + 1, "");
          idCardList.insert(index + 1, "");
        } else {
          farmersList.removeAt(index);
          acresList.removeAt(index);
          idCardList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.deepPurple : Colors.deepOrange,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;

  const FriendTextFields(this.index);

  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  late TextEditingController _nameController;
  late TextEditingController _acresController;
  late TextEditingController _idCardController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _acresController = TextEditingController();
    _idCardController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _acresController.dispose();
    _idCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _MyFormState.farmersList[widget.index];
      _acresController.text = _MyFormState.acresList[widget.index];
      _idCardController.text = _MyFormState.idCardList[widget.index];
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Farmer ${(widget.index + 1).toString()}",
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 32.0),
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: _nameController,
                  onChanged: (v) => _MyFormState.farmersList[widget.index] = v,
                  validator: (v) {
                    if (v!.trim().isEmpty) return 'Please enter something';
                    return null;
                  },
                  autofocus: true,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    labelText: "Enter farmer name",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 32.0),
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: _acresController,
                  onChanged: (v) => _MyFormState.acresList[widget.index] = v,
                  validator: (v) {
                    if (v!.trim().isEmpty) return 'Please enter something';
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3),],
                  autofocus: true,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    labelText: "Enter farm acres",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 32.0),
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: _idCardController,
                  onChanged: (v) => _MyFormState.idCardList[widget.index] = v,
                  validator: (v) {
                    if (v!.trim().isEmpty) return 'Please enter something';
                    return null;
                  },
                  autofocus: true,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    labelText: "Enter PAN number",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
