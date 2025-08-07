import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  bool isFirst = true;
  bool pressed = false;

  Future<void> fetchData() async {
    setState(() {
      if (pressed == true) {
        isFirst = false;
      }
      data = null;
      pressed = true;
    });

    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Fetch data from API
    final result = await ApiService.fetchData();

    // Update state with new data
    setState(() {
      data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(209, 186, 248, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 108, 33, 238),
        title: const Text(
          "DATA FROM API",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: "Livvic",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // ✅ center vertically
          children: [
            if (data == null && !pressed)
              Container(), // placeholder for first time

            if (data == null && pressed)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SpinKitFoldingCube(
                    color: Color.fromARGB(255, 255, 255, 255),
                    size: 50.0,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isFirst ? 'Getting Data' : 'Refreshing Data',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Livvic',
                    ),
                  ),
                ],
              ),

            if (data != null)
              Column(
                children: [
                  Text("${data?['name']}"),
                  Text("${data?['age']}"),
                  Text("${data?['city']}"),
                ],
              ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: fetchData,
        icon: const Icon(Icons.get_app),
        label: pressed ? const Text("Refresh Data") : const Text("Get Data"),
      ),
    );
  }
}
