import 'package:flutter/material.dart';

class UsreInfoScreen extends StatefulWidget {
  static String routeName = '/user_info';
  const UsreInfoScreen({super.key});

  @override
  State<UsreInfoScreen> createState() => _UsreInfoScreenState();
}

class _UsreInfoScreenState extends State<UsreInfoScreen> {
  // final TextEditingController _nameController = TextEditingController();
  // final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    // socket init
  }

  @override
  void dispose() {
    // _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("User Info Screen"),
      ),
    );
  }
}
