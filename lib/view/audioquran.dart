import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class Audio extends StatefulWidget {
  final String id; // Accepting id from another class
  const Audio({super.key, required this.id});

  @override
  State<Audio> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<Audio> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration();
  Duration position = Duration();
  bool playing = false;
  bool isDownloading = false;
  late String audioKey; // Unique key per ID
  String? savedPath;
  late String url;

  @override
  void initState() {
    super.initState();

    // Use widget.id instead of hardcoded "114"
    audioKey = "saved_audio_path_${widget.id}";
    url = "https://server6.mp3quran.net/akdr/${widget.id}.mp3"; // Dynamic URL
    _loadSavedPath();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  // Load saved audio file path from SharedPreferences
  Future<void> _loadSavedPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedPath = prefs.getString(audioKey);
    setState(() {});
  }

  // Get local file path, unique per ID
  Future<String> getLocalFilePath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/saved_audio_${widget.id}.mp3";
  }

  // Save audio file locally
  Future<void> saveAudio() async {
    setState(() {
      isDownloading = true;
    });

    try {
      String filePath = await getLocalFilePath();
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(audioKey, filePath);

        setState(() {
          savedPath = filePath;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Audio saved successfully!")),
        );
      } else {
        throw Exception("Failed to download audio");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving audio: $e")),
      );
    }

    setState(() {
      isDownloading = false;
    });
  }

  // Play audio from local storage or URL
  Future<void> playAudio() async {
    if (playing) {
      await audioPlayer.pause();
      setState(() {
        playing = false;
      });
    } else {
      if (savedPath != null && File(savedPath!).existsSync()) {
        await audioPlayer.play(DeviceFileSource(savedPath!));
      } else {
        await audioPlayer.play(UrlSource(url));
      }

      setState(() {
        playing = true;
      });
    }

    // Listen to audio duration and position
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration d) {
      setState(() {
        position = d;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Audio Player (${widget.id})")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: playAudio,
            child: Icon(
              playing ? Icons.pause_circle_outline : Icons.play_circle_outline,
              size: 100,
              color: Colors.teal,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isDownloading ? null : saveAudio,
            child: isDownloading
                ? CircularProgressIndicator()
                : Text("Save Audio"),
          ),
        ],
      ),
    );
  }
}
