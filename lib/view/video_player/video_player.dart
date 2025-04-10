import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final Map video;

  VideoPlayerPage({required this.video});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isError = false;

  @override
  void initState() {
    super.initState();

    String videoUrl = widget.video["video_file"];
    print("Video URL: $videoUrl"); // Debugging

    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
      }).catchError((error) {
        print("Video initialization failed: $error");
        setState(() {
          _isError = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.video["title"])),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                if (_isError)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Failed to load vid. Please check the vid URL.",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  )
                else if (!_controller.value.isInitialized)
                  Center(child: CircularProgressIndicator())
                else
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.height/2,
                          child: AspectRatio(
                            // aspectRatio: _controller.value.aspectRatio,
                            aspectRatio: 16/9,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      ),
                      // Play/Pause Button
                      Positioned(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            radius: 30,
                            child: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Channel Name"),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: Text("Subscribe"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(widget.video["description"]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
