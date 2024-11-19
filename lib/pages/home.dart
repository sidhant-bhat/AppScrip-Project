import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/user_details.dart';
import 'package:flutter_application_1/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User List",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber.shade100,
      ),
      body: (userProvider.isLoading)
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await userProvider.fetchUsers();
                userProvider.clearSearch();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SearchBar(
                      hintText: "Search",
                      shadowColor: WidgetStateProperty.all(Colors.grey[100]),
                      leading: Icon(
                        Icons.search,
                        color: Colors.grey[500],
                      ),
                      onSubmitted: (value) {
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        userProvider.setSearchString(
                            value);
                      },
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: (userProvider.users.isNotEmpty)
                          ? ListView.builder(
                              itemCount: userProvider.users.length,
                              itemBuilder: (context, index) {
                                final user = userProvider.users[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserDetails(user: user),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(user.name!),
                                    subtitle: Text(user.email!),
                                  ),
                                );
                              },
                            )
                          : const Center(child: Text("No results found.")),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
