import 'package:flutter/material.dart';
import 'package:my_video_player/control/controls_overlay.dart';
import 'package:my_video_player/pages/full_screen.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //controller
  late VideoPlayerController controller;

  //make function
  Future<ClosedCaptionFile> loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context).loadString(
      "assets/bumble_bee_captions.vtt",
    );
    return WebVTTCaptionFile(fileContents);
    //for vtt files
  }

  @override
  void initState() {
    controller = VideoPlayerController.network(
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      closedCaptionFile: loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
      ),
    );

    controller.addListener(
      () {
        setState(
          () {},
        );
      },
    );
    controller.setLooping(true);
    controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push<FullScreen>(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const FullScreen();
              },
            ),
          );
        },
        backgroundColor: Colors.red.shade900,
        child: const Icon(
          Icons.fullscreen,
          size: 30.0,
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "M-H-T Player",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Movie name",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // ClosedCaption(
                //   text: controller.value.caption.text,
                //   textStyle: const TextStyle(
                //     color: Colors.white,
                //     fontSize: 30.0,
                //   ),
                // ),
                ConrolsOverlay(controller: controller),
                const SizedBox(
                  height: 10.0,
                ),
                VideoProgressIndicator(
                  controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.red,
                    backgroundColor: Colors.white,
                    bufferedColor: Colors.black38,
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
