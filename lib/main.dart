import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MaterialApp(home: DataBackend()));
}

class DataBackend extends StatefulWidget {
  const DataBackend({super.key});

  @override
  State<DataBackend> createState() => _DataBackendState();
}

class _DataBackendState extends State<DataBackend> {
  Map<String, dynamic>? data;

  Future<void> fetchData() async {
    final result = await ApiService.fetchData();
    setState(() {
      data = result;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 108, 33, 238),
        title: Text(
          "DATA FROM API",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: "Livvic",
            fontWeight: FontWeight.bold,
            ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("${data?['name']}"),
          ],
        ),
      ),
    );
  }
}
