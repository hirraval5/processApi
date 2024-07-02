import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_network_helper_1/base_service.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with BaseService {
  bool _isLoading = false;

  static const _url = "https://jsonplaceholder.typicode.com/comments";

  final List<Map<String, dynamic>> _listData = [];

  Future<void> _getComments() async {
    final response = await processApi(
      () => get(Uri.parse(_url)),
      onLoading: (loading) => setState(() => _isLoading = loading),
      onError: (error, stackTrace) {
        log("Error while getting comments -> $error $stackTrace");
      },
    );
    if (response?.body != null) _listData.addAll(jsonDecode(response!.body));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _getComments();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          if (_isLoading) return const Center(child: CircularProgressIndicator());
          if (_listData.isEmpty) {
            return const Center(
              child: Text("No Data Found"),
            );
          }
          return ListView.builder(
            itemCount: _listData.length,
            itemBuilder: (context, index) {
              final comment = _listData[index];
              return ListTile(
                title: Text(comment['name']),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment['email']),
                    Text(comment['body']),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
