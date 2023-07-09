import 'package:flutter/material.dart';
import 'package:madcamp_project2/screens/game_screen.dart';

class CreateRoomForm extends StatefulWidget {
  const CreateRoomForm({super.key});

  @override
  State<CreateRoomForm> createState() => _CreateRoomFormState();
}

class _CreateRoomFormState extends State<CreateRoomForm> {
  final _formKey = GlobalKey<FormState>();
  String roomName = '';
  String password = '';

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
            decoration: const InputDecoration(
              hintText: "Enter room password",
            ),
            autovalidateMode: AutovalidateMode.always,
            textInputAction: TextInputAction.done,
            onSaved: (newValue) => password = newValue ?? '',
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print('roomname: $roomName, password: $password');

                  // _socketMethods.createRoom()
                  // createRoom() -> createRoomSuccessListener() -> GameScreen
                  Navigator.popAndPushNamed(context, GameScreen.routeName);
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
