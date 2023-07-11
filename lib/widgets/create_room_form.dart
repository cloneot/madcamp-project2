import 'package:flutter/material.dart';
import 'package:madcamp_project2/provider/user_data_provider.dart';
import 'package:madcamp_project2/resources/socket_methods.dart';
import 'package:provider/provider.dart';

class CreateRoomForm extends StatefulWidget {
  const CreateRoomForm({super.key});

  @override
  State<CreateRoomForm> createState() => _CreateRoomFormState();
}

class _CreateRoomFormState extends State<CreateRoomForm> {
  final _formKey = GlobalKey<FormState>();
  final SocketMethods _socketMethods = SocketMethods();
  final TextEditingController _nicknameController = TextEditingController();
  String roomName = '';
  String password = '';
  String nickName = '';

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
    _nicknameController.text =
        Provider.of<UserDataProvider>(context, listen: false).username ??
            'name_error!';
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 150),
          TextFormField(
            maxLength: 20,
            decoration: const InputDecoration(
              hintText: "Enter room name",
            ),
            autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "required field";
              }
              return null;
            },
            onSaved: (newValue) => roomName = newValue ?? '',
          ),
          TextFormField(
            maxLength: 20,
            controller: _nicknameController,
            readOnly: true,
            // decoration: const InputDecoration(
            //   hintText: "Enter nickname",
            // ),
            autovalidateMode: AutovalidateMode.always,
            textInputAction: TextInputAction.done,
            onSaved: (newValue) => nickName = newValue ?? '',
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _socketMethods.createRoom(roomName, nickName);
                }
              },
              child: const Text('Create Room'),
            ),
          ),
        ],
      ),
    );
  }
}
