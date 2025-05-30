import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class HadithViewerPage extends StatefulWidget {
  final String title;
  final String pdfUrl;

  const HadithViewerPage({
    super.key,
    required this.title,
    required this.pdfUrl,
  });

  @override
  State<HadithViewerPage> createState() => _HadithViewerPageState();
}

class _HadithViewerPageState extends State<HadithViewerPage> {
  String? localFilePath;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/temp.pdf');
        await file.writeAsBytes(bytes);
        setState(() {
          localFilePath = file.path;
          isLoading = false;
          errorMessage = '';
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to download PDF: Status code ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load PDF: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : localFilePath != null
          ? PDFView(
        filePath: localFilePath!,
      )
          : const Center(child: Text('Error loading PDF')),
    );
  }
}