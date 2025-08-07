import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MaterialApp(
    home: HelloFromBackend(),
  ));
}

class HelloFromBackend extends StatefulWidget {
  const HelloFromBackend({Key? key}) : super(key: key);

  @override
  State<HelloFromBackend> createState() => _HelloFromBackendState();
}

class _HelloFromBackendState extends State<HelloFromBackend> {
  String _message = '';
  bool _loading = false;
  final ApiService _apiService = ApiService();

  Future<void> _fetchMessage() async {
    setState(() {
      _loading = true;
      _message = '';
    });
    try {
      final msg = await _apiService.fetchHello();
      setState(() {
        _message = msg;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _message = 'Error:  ${e.toString()}';
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flask + Flutter Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _fetchMessage,
              child: const Text('Fetch from Flask'),
            ),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (_message.isNotEmpty) Text(_message),
          ],
        ),
      ),
    );
  }
}

