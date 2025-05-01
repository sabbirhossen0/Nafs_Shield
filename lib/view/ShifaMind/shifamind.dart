import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatWithGaminiPage extends StatefulWidget {
  @override
  _ChatWithGaminiPageState createState() => _ChatWithGaminiPageState();
}

class _ChatWithGaminiPageState extends State<ChatWithGaminiPage> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final message = _controller.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _isLoading = true;
      _response = '';
    });

    final url = Uri.parse('http://127.0.0.1:8001/gamini/chat/'); // Use local IP for real device

    try {
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() => _response = data['reply']);
      } else {
        setState(() => _response = 'Error: ${res.body}');
      }
    } catch (e) {
      setState(() => _response = 'Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ShifaMind'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Your message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendMessage,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Send'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _response,
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
