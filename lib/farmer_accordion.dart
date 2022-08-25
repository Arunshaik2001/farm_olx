import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Dynamic TextFormFields'),),
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
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        hintText: 'Enter group name'
                    ),
                    validator: (v){
                      if(v!.trim().isEmpty) return 'Please enter something';
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: TextFormField(
                    controller: _cropController,
                    decoration: const InputDecoration(
                        hintText: 'Enter crop name'
                    ),
                    validator: (v){
                      if(v!.trim().isEmpty) return 'Please enter something';
                      return null;
                    },
                  ),
                ),
                ..._getFriends(),
                const SizedBox(height: 40,),
                FlatButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                    }
                  },
                  child: const Text('Submit'),
                  color: Colors.green,
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }

  /// get firends text-fields
  List<Widget> _getFriends(){
    List<Widget> friendsTextFields = [];
    for(int i=0; i<farmersList.length; i++){
      friendsTextFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(child: FriendTextFields(i)),
                const SizedBox(width: 16,),
                // we need add button at last friends row
                _addRemoveButton(i == farmersList.length-1, i),
              ],
            ),
          )
      );
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          farmersList.insert(index+1, "");
          acresList.insert(index+1, "");
          idCardList.insert(index+1, "");
        }
        else {
          farmersList.removeAt(index);
          acresList.removeAt(index);
          idCardList.removeAt(index);
        }
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon((add) ? Icons.add : Icons.remove, color: Colors.white,),
      ),
    );
  }


}

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
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
      _nameController.text = _MyFormState.farmersList[widget.index] ?? '';
      _acresController.text = _MyFormState.acresList[widget.index] ?? '';
      _idCardController.text = _MyFormState.idCardList[widget.index] ?? '';
    });

    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          onChanged: (v) => _MyFormState.farmersList[widget.index] = v,
          decoration: const InputDecoration(
              hintText: 'Enter farmer name'
          ),
          validator: (v){
            if(v!.trim().isEmpty) return 'Please enter something';
            return null;
          },
        ),
        TextFormField(
          controller: _acresController,
          onChanged: (v) => _MyFormState.acresList[widget.index] = v,
          decoration: const InputDecoration(
              hintText: 'Enter farm acres'
          ),
          validator: (v){
            if(v!.trim().isEmpty) return 'Please enter something';
            return null;
          },
        ),
        TextFormField(
          controller: _idCardController,
          onChanged: (v) => _MyFormState.idCardList[widget.index] = v,
          decoration: const InputDecoration(
              hintText: 'Enter PAN number'
          ),
          validator: (v){
            if(v!.trim().isEmpty) return 'Please enter something';
            return null;
          },
        ),
      ],
    );
  }
}