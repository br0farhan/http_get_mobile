import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_http/models/user.dart';
import 'package:get_http/services/user_service.dart';

class HomePageStatelessFutureBuilder extends StatelessWidget {
  const HomePageStatelessFutureBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Builder Statetless builder"),
      ),
      body: FutureBuilder<List<User>>(
        future: UserServices.fetchUsers(),
        builder: (context, snapshot) {
          final users = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Data tidak ada bro"),
            );
          }
          return ListView.builder(
              itemCount: users!.length,
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
              });
        },
      ),
    );
  }
}
