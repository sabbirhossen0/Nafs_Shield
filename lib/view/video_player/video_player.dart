import 'package:flutter/material.dart';
import 'package:nafsshield/view/video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _MyAppState();
}

class _MyAppState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //  for video play
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                      border: Border.all(width: 10, color: Colors.black)),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.blue,
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.red,
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.yellow,
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.green,
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.blue,
                          )),
                    ],
                  ),
                ),
                //title
                SafeArea(
                  child: InkWell(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0,left: 8),
                          child: Text(
                            'Top Flutter Widgets You MUST Know as a Keyboard Fighter | Flutter Widgets You Can’t Live Without Full Guide ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '1.2M views',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            Text(' 5mo ago ', style: TextStyle(fontSize: 10)),
                            Text('#flutter ...more',
                                style: TextStyle(fontSize: 10)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                //subscribe
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP57T34jBNENtsoMoDNV9FOypOI0ppMl9fDQ&usqp=CAU"),
                        radius: 20,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'KeyBoard Fighter',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                      Text('100.8k'),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Subscribe'),
                        style: ButtonStyle(
                          foregroundColor:
                          WidgetStateProperty.all(Colors.black),
                        ),
                      )
                    ],
                  ),
                ),

                //button
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors
                                .grey[200], // Background color (light gray)
                            borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: InkWell(
                                  child: Icon(Icons.thumb_up_alt_outlined),
                                ),
                              ),

                              // TextButton.icon(
                              //   onPressed: () {
                              //     // Add your onPressed function here
                              //   },
                              //   icon: Icon(Icons.thumb_up, color: Colors.blue),  // The icon for the button
                              //   label: Text(
                              //     "",
                              //     style: TextStyle(color: Colors.blue),
                              //   ),  // The text label for the button
                              // ),

                              Text(" 100.4k | "),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                  child: Icon(Icons.thumb_down_alt_outlined),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                          // color: Colors.white70,

                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30)),

                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.share_sharp),
                                iconSize: 18.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Text('Share'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.video_call_outlined)),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text('Remix'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.download)),
                              Text('Download')
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.save_alt)),
                              Text('Save')
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.report_gmailerrorred_sharp)),
                              Text('Report')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //comment part
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Comments',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.videogame_asset_outlined)
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 16),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP57T34jBNENtsoMoDNV9FOypOI0ppMl9fDQ&usqp=CAU"),
                                radius: 20,
                              )),
                          Expanded(
                              child:
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 8.0,bottom: 8.0),
                              //   child: TextField(
                              //                             decoration: InputDecoration(
                              //   hintText: "Write your comment",
                              //   hintStyle: TextStyle(color: Colors.white70),
                              //
                              //   border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(
                              //         100.0), // Circular border radius
                              //     borderSide: BorderSide.none, // No border line
                              //   ),
                              //   filled: true,
                              //   fillColor: Colors.black26, // Transparent or adjust based on background
                              //                             ),
                              //                           ),
                              // )
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 8.0, right: 16),
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8.0, top: 4),
                                    child: Text('add a comment...'),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      // border: Border.all(width: 10, color: Colors.black)
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.red, // Set the color to red
                                width: 2.0, // Adjust the width as needed
                              ),
                            ),
                          ),
                          child: Image.network(
                              'https://img.freepik.com/free-vector/modern-youtube-thumbnail-design-with-awesome-text-template_1361-2737.jpg?ga=GA1.1.1168531304.1692472651&semt=ais_hybrid'),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://banner2.cleanpng.com/20190731/uqk/kisspng-google-icon-1713874997698.webp"),
                                  radius: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ultimate Guide to Video Creation for Beginners!',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'The Flutter Way . 312K Views . 1 years ago',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ImageIcon(
                                  AssetImage("assets/menu.png"),
                                  size: 20, // Set the desired size
                                  color: Colors.black, // Optional color overlay
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}