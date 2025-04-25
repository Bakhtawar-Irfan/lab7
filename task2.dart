import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Post Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ApiPostFetcher(),
    );
  }
}

class ApiPostFetcher extends StatefulWidget {
  const ApiPostFetcher({super.key});

  @override
  State<ApiPostFetcher> createState() => _ApiPostFetcherState();
}

class _ApiPostFetcherState extends State<ApiPostFetcher> {
  String? title;
  String? body;
  bool isLoading = false;

  // Fetch a random post from the API
  Future<void> fetchRandomPost() async {
    setState(() {
      isLoading = true; // Set loading state to true while fetching data
    });

    int randomId =
        Random().nextInt(100) + 1; // Generate random ID between 1 and 100
    final url = Uri.parse(
      'https://jsonplaceholder.typicode.com/posts/$randomId',
    );

    try {
      // Sending GET request
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          title = data['title'];
          body = data['body'];
          isLoading = false; // Set loading state to false after data is fetched
        });
      } else {
        setState(() {
          title = "Error";
          body = "Failed to fetch data.";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        title = "Error";
        body = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Random Post Viewer")),
      body: Center(
        child:
            isLoading
                ? const CircularProgressIndicator() // Show loading spinner when fetching data
                : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (title != null) ...[
                        Text(
                          title!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(body ?? ''),
                      ],
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: fetchRandomPost,
                        child: const Text("Fetch Random Post"),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
