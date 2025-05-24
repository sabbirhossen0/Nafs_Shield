import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class GeminiResponsePage extends StatefulWidget {
  @override
  _GeminiResponsePageState createState() => _GeminiResponsePageState();
}

class _GeminiResponsePageState extends State<GeminiResponsePage> {
  String responseMessage = '';
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;

  Future<void> fetchGeminiResponse(String userInput) async {
    setState(() {
      isLoading = true;
      responseMessage = '';
    });

    final url = Uri.parse('http://127.0.0.1:8001/chat/'); // Your Django endpoint
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': userInput}),
    );

    setState(() {
      isLoading = false;
      if (response.statusCode == 200) {
        final decoded = utf8.decode(response.bodyBytes);
        final data = jsonDecode(decoded);
        responseMessage = data['reply'] ?? 'No response';
      } else {
        responseMessage = 'Error: ${response.statusCode}';
      }
    });
  }

  bool isArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shifa Mind')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => fetchGeminiResponse(messageController.text),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (messageController.text.trim().isNotEmpty) {
                  fetchGeminiResponse(messageController.text.trim());
                }
              },
              child: Text('Submit'),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator()
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Directionality(
                    textDirection: isArabic(responseMessage)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Text(
                      responseMessage,
                      style: isArabic(responseMessage)
                          ? GoogleFonts.notoNaskhArabic(fontSize: 18)
                          : GoogleFonts.notoSansBengali(fontSize: 18),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
