import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();

}


class _UploadPageState extends State<UploadPage> {
  XFile? _video;
  final picker = ImagePicker();
  final dio = Dio();

  Future<void> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _video = pickedFile;
    });
  }

  Future<void> uploadVideo() async {
    if (_video == null) return;
    String fileName = _video!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "title": "New Video",
      "description": "Description here",
      "video_file": await MultipartFile.fromFile(_video!.path, filename: fileName),
    });

    await dio.post('http://127.0.0.1:8001/videos/', data: formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Video")),
      body: Column(
        children: [
          ElevatedButton(onPressed: pickVideo, child: Text("Pick Video")),
          ElevatedButton(onPressed: uploadVideo, child: Text("Upload Video")),
        ],
      ),
    );
  }
}
