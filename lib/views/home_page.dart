import 'package:flutter/material.dart';
import 'package:get_http/models/user.dart';
import 'package:get_http/services/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];
  bool isloading = true;
  void fetchUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    isloading = true;
    final result = await UserServices.fetchUsers();
    users = result;
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Pages"),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final User user = users[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                  ),
                );
              }),
    );
  }
}
