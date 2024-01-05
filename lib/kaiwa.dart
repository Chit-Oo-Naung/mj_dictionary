import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/gradient_text.dart';
import 'package:mjdictionary/utils/colors_util.dart';

class KaiwaPage extends StatefulWidget {
  const KaiwaPage({super.key});

  @override
  State<KaiwaPage> createState() => _KaiwaPageState();
}

class _KaiwaPageState extends State<KaiwaPage> {
  final player = AudioPlayer();

  Duration? duration;

  @override
  void initState() {
    setPlayerConfig();
    super.initState();
  }

  setPlayerConfig() async {
    var audioUrl =
        "https://drive.google.com/uc?export=view&id=1TOi_7FxttBXv_YFEzW-C04ZF4yF48YuX";
    // var audioLocalUrl = "assets/lesson1.mp3";
    player.onDurationChanged.listen((Duration d) {
      duration = d;
      print('Max duration: $d');
    });
    player.play(UrlSource(audioUrl.toString()));
    // await player.play(AssetSource(audioLocalUrl));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColor,
          toolbarHeight: 0,
        ),
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                  // color: mainColor,
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
                    color: mainColor,
                  ),
                )),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: secondaryColor,
                        ),
                      ),
                      GradientText(
                        "Kaiwa",
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                        gradient: LinearGradient(colors: [
                          Colors.black,
                          secondaryColor,
                        ]),
                      ),
                      Container()
                    ],
                  ),
                ),
                // Container(
                //   color: Colors.red,
                //   child: Expanded(
                //     child: Column(
                //       children: [
                //         const SizedBox(height: 16),
                //         StreamBuilder(
                //             stream: player.onPositionChanged,
                //             builder: (context, data) {
                //               return ProgressBar(
                //                 progress:
                //                     data.data ?? const Duration(seconds: 0),
                //                 total: duration ?? const Duration(minutes: 4),
                //                 bufferedBarColor: Colors.white38,
                //                 baseBarColor: Colors.white10,
                //                 thumbColor: Colors.white,
                //                 timeLabelTextStyle:
                //                     const TextStyle(color: Colors.white),
                //                 progressBarColor: Colors.white,
                //                 onSeek: (duration) {
                //                   player.seek(duration);
                //                 },
                //               );
                //             }),
                //         const SizedBox(height: 16),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // color: mainColor,
                // height: 90,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: mainColor,
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      child: StreamBuilder(
                          stream: player.onPositionChanged,
                          builder: (context, data) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width *
                                          0.76,
                                      child: ProgressBar(
                                        progress: data.data ??
                                            const Duration(seconds: 0),
                                        total: duration ??
                                            const Duration(minutes: 4),
                                        bufferedBarColor: Colors.white38,
                                        baseBarColor: Colors.black26,
                                        thumbColor: Colors.black,
                                        timeLabelTextStyle: const TextStyle(
                                            color: Colors.black),
                                        progressBarColor: Colors.black,
                                        onSeek: (duration) {
                                          player.seek(duration);
                                        },
                                      ),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                                    GestureDetector(
                                      onTap: () async {
                                        if (player.state ==
                                            PlayerState.playing) {
                                          await player.pause();
                                        } else {
                                          await player.resume();
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        // color: Colors.blue,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.13,
                                        child: Icon(
                                          player.state == PlayerState.playing
                                              ? Icons.pause_circle
                                              : Icons.play_circle,
                                          color: Colors.black,
                                          size: 55,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(Icons.lyrics_outlined,
                    //             color: Colors.white)),
                    //     IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(Icons.skip_previous,
                    //             color: Colors.white, size: 36)),

                    //     IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(Icons.skip_next,
                    //             color: Colors.white, size: 36)),
                    //     IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(Icons.loop, color: Colors.red)),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
