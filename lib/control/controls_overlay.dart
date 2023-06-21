import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ConrolsOverlay extends StatelessWidget {
  const ConrolsOverlay({
    super.key,
    required this.controller,
  });

  //controller
  final VideoPlayerController controller;

  //all of caption offset
  static const List<Duration> captionOffset = [
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];

  //all of playBack speed
  static const List<double> playBackRates = [
    0.25,
    0.5,
    1.0,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 400.0,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: const Duration(
                microseconds: 50,
              ),
              reverseDuration: const Duration(
                milliseconds: 200,
              ),
              child: controller.value.isPlaying == true
                  ? Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.pause,
                          color: Colors.red.shade900,
                          size: 60.0,
                          semanticLabel: "play",
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.red.shade900,
                          size: 60.0,
                          semanticLabel: "play",
                        ),
                      ),
                    ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60.0,
              width: 60.0,
              child: GestureDetector(
                onTap: () {
                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              alignment: Alignment.center,
              height: 40.0,
              width: 80.0,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: PopupMenuButton<Duration>(
                color: Colors.red,
                initialValue: controller.value.captionOffset,
                tooltip: "Caption offset",
                onSelected: (Duration delay) {
                  controller.setCaptionOffset(delay);
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem<Duration>>[
                    for (final Duration offsetDuration in captionOffset)
                      PopupMenuItem<Duration>(
                        value: offsetDuration,
                        child: Text(
                          "${offsetDuration.inMilliseconds} ms",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                  ];
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    "${controller.value.captionOffset.inMilliseconds} ms",
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              alignment: Alignment.center,
              height: 40.0,
              width: 80.0,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: PopupMenuButton<double>(
                color: Colors.red,
                initialValue: controller.value.playbackSpeed,
                tooltip: "playback speed",
                onSelected: (double speed) {
                  controller.setPlaybackSpeed(speed);
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem<double>>[
                    for (final double speed in playBackRates)
                      PopupMenuItem<double>(
                        value: speed,
                        child: Text(
                          "$speed x",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ];
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    "${controller.value.playbackSpeed} x",
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
