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

  @override
  void initState() {
    super.initState();
    fetchGeminiResponse();
  }

  Future<void> fetchGeminiResponse() async {
    final url = Uri.parse('http://127.0.0.1:8000/chat/'); // Update your Django endpoint
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': 'I am feeling sad'}),
    );

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decoded);
      setState(() {
        responseMessage = data['reply'] ?? 'No response';
      });
    } else {
      setState(() {
        responseMessage = 'Error: ${response.statusCode}';
      });
    }
  }

  bool isArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gemini API Response')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: isArabic(responseMessage) ? TextDirection.rtl : TextDirection.ltr,
          child: Text(
            responseMessage,
            style: isArabic(responseMessage)
                ? GoogleFonts.notoNaskhArabic(fontSize: 18)
                : GoogleFonts.notoSansBengali(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
