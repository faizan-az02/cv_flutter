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
  String? buttonMessage;
  bool gotData = false;
  int code = -1;

  Future<void> fetchData() async {

    setState(() {

      if (isFirst == false)
      {
        gotData = true;
      }

      isFirst = false;
      pressed = true;

    });

    await Future.delayed(Duration(seconds: 3));

    ApiResponse result;

    result = await ApiService.fetchData();

    if (result.statusCode != 200)
    {
      setState(() {
        data = null;
        pressed = false;
        code = result.statusCode;
      });
    }
    else
    {
      setState(() {
        pressed = false;
        data = result.body;
        code = result.statusCode;
      });
    }
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

      body: pressed ? 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SpinKitDancingSquare(
              color: Colors.white,
              size: 50.0,
            ),

            Text(
              gotData ? "Refreshing Data" : "Getting Data",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: "Livvic",
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        )
      :SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // ✅ center vertically
          children: [
            Text(data != null? 
              "$data":
              isFirst ? 
              "Press Button to Fetch The Data":
              "No Data Found",
              ),
              Text("Status Code: $code")
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: fetchData,
        icon: const Icon(Icons.get_app),
        label: Text(isFirst ? "Get Data" : "Refresh Data"),
      ),
    );
  }
}
