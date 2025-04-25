import 'package:flutter/material.dart';

void main() {
  runApp(const AsyncDatabaseApp());
}

class AsyncDatabaseApp extends StatelessWidget {
  const AsyncDatabaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: DatabasePage());
  }
}

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  bool isLoading = true;
  List<String> data = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseData();
  }

  Future<void> fetchDatabaseData() async {
    // Simulating database fetch with delay
    await Future.delayed(const Duration(seconds: 3), () {
      data = [
        "User 1 - bakhtawar",
        "User 2 - hamza",
        "User 3 - samiullah",
        "User 4 - safiullah",
        "User 5 - anaya",
      ];
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Async DB Query Simulation")),
      body: Center(
        child:
            isLoading
                ? const CircularProgressIndicator()
                : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(data[index]),
                    );
                  },
                ),
      ),
    );
  }
}
