import 'package:flutter/material.dart';
import 'package:madcamp_project2/models/users.dart';
import 'package:madcamp_project2/utils/http_utils.dart';

class UsreInfoScreen extends StatefulWidget {
  static String routeName = '/user_info';
  const UsreInfoScreen({super.key});

  @override
  State<UsreInfoScreen> createState() => _UsreInfoScreenState();
}

class _UsreInfoScreenState extends State<UsreInfoScreen> {
  var myController = TextEditingController();
  var username = 'asdf';

  @override
  void initState() {
    super.initState();
    print('user info init state');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("User Info Screen22"),
            TextField(
              controller: myController,
              onChanged: (value) => setState(() => username = value),
            ),
            Text(
              '/users/${myController.text}',
            ),
            // FutureBuilder(
            //   future: HttpUtil().get('/test'),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       if (snapshot.hasError) {
            //         return Text("Error: ${snapshot.error}");
            //       }
            //       return Text("Contents: ${snapshot.data}");
            //     } else {
            //       return const CircularProgressIndicator();
            //     }
            //   },
            // ),
            Text(username),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                try {
                  // var response = await dio.get('http://localhost:80/test');
                  var response =
                      await HttpUtil().get('/users/${myController.text}');
                  Users user = Users.fromMap(response);
                  print(user.username);
                  print(user.totalGames);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(response.toString()),
                      duration: const Duration(seconds: 1),
                      action: SnackBarAction(
                        label: 'undo',
                        onPressed: () {},
                      ),
                    ),
                  );
                } catch (err, stkTrace) {
                  print("exception occur: $err stackTrace: $stkTrace");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
