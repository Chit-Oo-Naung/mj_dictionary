import 'package:flutter/material.dart';
import 'package:mjdictionary/common/global_constant.dart';
import 'package:video_player/video_player.dart';

class KanjiWritingPage extends StatefulWidget {
  const KanjiWritingPage({super.key});

  @override
  State<KanjiWritingPage> createState() => _KanjiWritingPageState();
}

class _KanjiWritingPageState extends State<KanjiWritingPage> {
  late VideoPlayerController videoController;
  bool isPlaying = false;
  var kanjiStr = '万';

  @override
  void initState() {
    loadVideo();
    super.initState();
  }

  void loadVideo() async {
    setState(() {
      videoController =
          VideoPlayerController.asset(Uri.encodeFull('assets/a.mp4'))
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() async {
              // if (videoController != null && mounted) {
                if ((await videoController.position)! >=
                        videoController.value.duration &&
                    isPlaying) {
                  videoController.pause();
                  videoController.seekTo(const Duration(seconds: 0));

                  setState(() {
                    isPlaying = false;
                  });
                }
              // }
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       if (videoController.value.isPlaying) {
      //         videoController.pause();
      //         isPlaying = false;
      //       } else {
      //         videoController.play();
      //         isPlaying = true;
      //       }
      //     });
      //   },
      //   child: Icon(
      //     videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Image.asset(
            'assets/matts.png',
          )),
          if (isPlaying == false)
            Align(
              alignment: Alignment.center,
              child: Center(
                  child: Hero(
                      tag: kanjiStr,
                      child: Material(
                        //wrap the text in Material so that Hero transition doesn't glitch
                        color: Colors.transparent,
                        child: Text(
                          kanjiStr,
                          style: const TextStyle(
                              fontFamily: 'strokeOrders', fontSize: 128),
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
                        ),
                      ))),
            ),
          if (isPlaying == true)
            Positioned.fill(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          // Use the VideoPlayer widget to display the video.
                          child: VideoPlayer(videoController),
                        )))),
          if (isPlaying)
            Positioned.fill(
                child: Image.asset(
              'assets/matts.png',
            )),
          if (isPlaying == false)
            Positioned.fill(
                child: Center(
                    child: Opacity(
                        opacity: 0.7,
                        child: Material(
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  isPlaying = true;
                                  videoController.play();
                                });
                              },
                              child: const Icon(Icons.play_arrow)),
                        ))))
        ],
      ),
    );
  }
}
