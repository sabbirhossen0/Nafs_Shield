import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'HadithViewerPage.dart';
import 'dart:html' as html;


class HadithListPage extends StatefulWidget {
  const HadithListPage({super.key});

  @override
  State<HadithListPage> createState() => _HadithListPageState();
}

class _HadithListPageState extends State<HadithListPage> {
  List<dynamic> hadiths = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHadiths();
  }

  Future<void> fetchHadiths() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8001/api/hadiths/'));

    if (response.statusCode == 200) {
      setState(() {
        hadiths = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load hadiths');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hadith List")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: hadiths.length,
        itemBuilder: (context, index) {
          final hadith = hadiths[index];
          return ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: Text(hadith['title']),
            subtitle: Text(hadith['description']),
            onTap: () {
                // openPdfInNewTab('https://example.com/myfile.pdf');

              html.window.open("http://127.0.0.1:8001${hadith['pdf_file']}", '_blank');

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => HadithViewerPage(
              //       title: hadith['title'],
              //       pdfUrl: 'http://127.0.0.1:8001${hadith['pdf_file']}',
              //
              //
              //
              //
              //     ),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
