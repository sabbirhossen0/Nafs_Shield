import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for rootBundle
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart'; // for Get.arguments

class tutorial extends StatefulWidget {
  const tutorial({super.key});

  @override
  State<tutorial> createState() => _tutorialState();
}

class _tutorialState extends State<tutorial> {


  String? localPdfPath;
  late String lang; // Declare lang here
  String l = '';

  @override
  void initState() {
    super.initState();

    // Get the language argument and handle null/empty case
    lang = Get.arguments ?? ''; // Assign empty string if Get.arguments is null
    // Print the value of lang to debug
    print("Received lang: $lang");
    // Set the path based on the language
    l = getPdfPath(lang);
    // Load the PDF from assets and store locally
    loadPdf();
  }


  // Method to get PDF path based on the language
  String getPdfPath(String lang) {
    switch (lang.toLowerCase()) {
      case 'python':
        return 'assets/pdf/pp.pdf';
      case 'c':
        return 'assets/pdf/c.pdf';
      case 'c++':
        return 'assets/pdf/cpp.pdf';
      case 'java':
        return 'assets/pdf/java.pdf';
      case 'c#':
        return 'assets/pdf/cs.pdf';
      case 'dart':
        return 'assets/pdf/dart.pdf';
      case 'rust':
        return 'assets/pdf/rust.pdf';
      case 'go':
        return 'assets/pdf/go.pdf';





      default:
        return 'assets/pdf/c.pdf'; // Handle default case if needed
    }
  }

  // Load PDF from assets and store it in a local file
  Future<void> loadPdf() async {
    try {
      final ByteData bytes = await rootBundle.load(l); // Load the selected PDF
      final Directory dir = await getApplicationDocumentsDirectory();
      final File file = File('${dir.path}/as.pdf'); // Store the file locally
      await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);

      setState(() {
        localPdfPath = file.path;
      });
    } catch (e) {
      print('Error loading PDF: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(lang), // Display the language in the title
      ),
      body: localPdfPath != null
          ? PDFView(
        filePath: localPdfPath, // Display the local PDF path
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
      )
          : Center(child: CircularProgressIndicator()), // Show loading indicator while PDF is loading
    );
  }
}
