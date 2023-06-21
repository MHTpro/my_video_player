import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({super.key});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  late VideoPlayerController videoController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.network(
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
      ),
    );

    videoController.setLooping(true);
    videoController.addListener(
      () {
        if (startedPlaying && !videoController.value.isPlaying) {
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  //function
  Future<bool> started() async {
    await videoController.initialize();
    await videoController.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: FutureBuilder<bool>(
          future: started(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data ?? false) {
              return RotatedBox(
                quarterTurns: 1,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.height,
                      child: VideoPlayer(videoController),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.red.shade900,
                          size: 60.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text(
                "Waiting for video to load",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
