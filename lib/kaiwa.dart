import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/gradient_text.dart';
import 'package:mjdictionary/components/kaiwa_text.dart';
import 'package:mjdictionary/utils/colors_util.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class KaiwaPage extends StatefulWidget {
  final String lesson;
  final String audioUrl;
  final List messages;
  final List audioClip;
  const KaiwaPage(
      {super.key,
      required this.lesson,
      required this.messages,
      required this.audioClip,
      required this.audioUrl});

  @override
  State<KaiwaPage> createState() => _KaiwaPageState();
}

// class Message {
//   final User sender;
//   final String avatar;
//   final String time;
//   final int unreadCount;
//   final bool isRead;
//   final String text;
//   final bool isMe;

//   Message({
//     required this.sender,
//     required this.avatar,
//     required this.time,
//     required this.unreadCount,
//     required this.text,
//     required this.isRead,
//     required this.isMe,
//   });
// }

class _KaiwaPageState extends State<KaiwaPage> {
  AutoScrollController _autoScrollController = AutoScrollController();
  final player = AudioPlayer();
  Duration? duration;
  var currentIndex = 0;
  String currentTime = "";
  bool showMyanmar = true;
  bool showLeftSide = false;
  bool loading = true;

  // final List audioClip = [
  //   {"time": "0:00:05", "index": 1},
  //   {"time": "0:00:07", "index": 2},
  //   {"time": "0:00:12", "index": 3},
  //   {"time": "0:00:18", "index": 4},
  // ];

  // // String titleJapan = "はじめまして";
  // // String titleMyanmar = "တွေ့ရတာ ဝမ်းသာပါတယ်။";

  // final List messages = [
  //   {
  //     "speaker": "",
  //     "japan": "はじめまして",
  //     "myanmar": "တွေ့ရတာ ဝမ်းသာပါတယ်။",
  //     "isMe": false,
  //     "avatar": "",
  //     "type": "title",
  //     "newline": ""
  //   },
  //   {
  //     "speaker": "さとうさん",
  //     "japan": "おはようございます。",
  //     "myanmar": "မင်္ဂလာနံနက်ခင်းပါ။",
  //     "isMe": false,
  //     "avatar": "sato",
  //     "type": "text",
  //     "newline": ""
  //   },
  //   {
  //     "speaker": "やまださん",
  //     "japan": "おはようございます。さとうさん、こちらは　マイク・ミラーさんです。",
  //     "myanmar": "မင်္ဂလာနံနက်ခင်းပါ။ စတိုစံ သူက မိုက်(ခ်)မီလာစံဖြစ်ပါတယ်။",
  //     "isMe": true,
  //     "avatar": "yamada",
  //     "type": "text",
  //     "newline": ""
  //   },
  //   {
  //     "speaker": "ミラー さん",
  //     "japan": "はじめまして。マイク・ミラーです。アメリカから　きました。どうぞ　よろしく。",
  //     "myanmar":
  //         "တွေ့ရတာ ဝမ်းသာပါတယ်။ မိုက်(ခ်)မီလာဖြစ်ပါတယ်။ အမေရိကားကနေ လာခဲ့ပါတယ်။ ခင်ခင်မင်မင်ဆက်ဆံပေးပါ။",
  //     "isMe": false,
  //     "avatar": "mira",
  //     "type": "text",
  //     "newline": ""
  //   },
  //   {
  //     "speaker": "さとうさん",
  //     "japan": "さとうけいこです。 どうぞ　よろしく。",
  //     "myanmar": "စတိုခဲအိကို ဖြစ်ပါတယ်။ ခင်ခင်မင်မင်ဆက်ဆံပေးပါ။",
  //     "isMe": true,
  //     "avatar": "sato",
  //     "type": "text",
  //     "newline": ""
  //   }
  // ];

  // final List<Message> messages = [
  //   Message(
  //       sender: sato,
  //       time: 'さとうさん',
  //       kanji: '', avatar: sato.avatar,
  //       isRead: true,
  //       text: "おはようございます。\nမင်္ဂလာနံနက်ခင်းပါ။",
  //       unreadCount: 0,
  //       isMe: false),
  //   Message(
  //       sender: yamada,
  //       time: 'やまださん',
  //       isRead: true,
  //       kanji: '', avatar: yamada.avatar,
  //       text:
  //           "おはようございます。さとうさん、こちらは　マイク・ミラーさんです。\nမင်္ဂလာနံနက်ခင်းပါ။ စတိုစံ သူက မိုက်(ခ်)မီလာစံဖြစ်ပါတယ်။",
  //       unreadCount: 0,
  //       isMe: true),
  //   Message(
  //       sender: mira,
  //       time: 'ミラー さん',
  //       isRead: true,
  //       kanji: '', avatar: mira.avatar,
  //       text:
  //           "はじめまして。マイク・ミラーです。アメリカから　きました。どうぞ　よろしく。\nတွေ့ရတာ ဝမ်းသာပါတယ်။ မိုက်(ခ်)မီလာဖြစ်ပါတယ်။ အမေရိကားကနေ လာခဲ့ပါတယ်။ ခင်ခင်မင်မင်ဆက်ဆံပေးပါ။",
  //       unreadCount: 0,
  //       isMe: false),
  //   Message(
  //       sender: sato,
  //       time: 'さとうさん',
  //       kanji: '', avatar: sato.avatar,
  //       isRead: true,
  //       text:
  //           "さとうけいこです。 どうぞ　よろしく。\nစတိုခဲအိကို ဖြစ်ပါတယ်။ ခင်ခင်မင်မင်ဆက်ဆံပေးပါ။",
  //       unreadCount: 0,
  //       isMe: false),
  // ];

  final User user = currentUser;

  // static Color kPrimaryColor = Color(0xff7C7B9B);
  // static Color kPrimaryColorVariant = Color(0xff686795);
  // static Color kAccentColor = Color(0xffFCAAAB);
  // static Color kAccentColorVariant = Color(0xffF7A3A2);
  // static Color kUnreadChatBG = Color(0xffEE1D1D);

  // static final TextStyle bodyTextMessage =
  //     TextStyle(fontSize: 15, fontWeight: FontWeight.w600);

  // static final TextStyle bodyTextTime = TextStyle(
  //   color: Color(0xffAEABC9),
  //   fontSize: 11,
  //   fontWeight: FontWeight.bold,
  //   letterSpacing: 1,
  // );

  // var audioUrl =
  //     "https://drive.google.com/uc?export=view&id=1OtVK0zS9SlN2UomNVqt3RUgCFq4LVQlp";

  // var audioLocalUrl = "assets/lesson1.mp3";

  @override
  void initState() {
    setPlayerConfig();
    player.onDurationChanged.listen((Duration d) {
      duration = d;
      debugPrint('Max duration: $d');
    });
    player.onPositionChanged.listen((event) {
      print("Current Position : $event");
      currentTime = event.toString();
      // var currentAudio = event.toString();
      // TimeOfDay _startTime = TimeOfDay(
      //   hour: int.parse(currentAudio.split(":")[0]),
      //   minute: int.parse(currentAudio.split(":")[1]),
      // );
      // DateTime currentAudio = DateFormat("hh:mm:ss").parse(event.toString());

      for (var i = 0; i < widget.audioClip.length; i++) {
        // DateTime clipAudio = DateFormat("hh:mm:ss").parse(widget.audioClip[i]["time"]);
        // final range = DateTimeRange(start: currentAudio, end: clipAudio);
        // debugPrint("RANGE >> $range");
        if (event.toString().startsWith(widget.audioClip[i]["time"])) {
          setState(() {
            debugPrint("Change Index!");
            currentIndex = widget.audioClip[i]["index"];
            _autoScrollController.scrollToIndex(currentIndex,
                preferPosition: AutoScrollPosition.middle);
          });
        }
      }
    });

    player.onPlayerComplete.listen((event) async {
      print("Player Complete!");
      await player.play(UrlSource(widget.audioUrl.toString()));
      await player.pause();
      currentIndex = 0;
      _autoScrollController.scrollToIndex(currentIndex,
          preferPosition: AutoScrollPosition.middle);
      setState(() {});
    });
    player.onSeekComplete.listen((event) {
      print("Seek Complete!");
      Future.delayed(Duration(milliseconds: 300), () async {
        print("Seek Complete! $currentTime");
        DateTime currentAudio = DateFormat("h:mm:ss").parse(currentTime);
        bool check = true;
        for (var i = 0; i < widget.audioClip.length; i++) {
          DateTime clipAudio =
              await DateFormat("h:mm:ss").parse(widget.audioClip[i]["time"]);
          // final range = DateTimeRange(start: currentAudio, end: clipAudio);
          // debugPrint("RANGE >> $range");
          var compareTime = currentAudio.isBefore(clipAudio);

          if (compareTime && check) {
            check = false;
            print("AAAA >> ${widget.audioClip[i]["time"]}");
            if (i > 0) {
              setState(() {
                debugPrint("Change Index!");
                currentIndex = widget.audioClip[i]["index"] - 1;
                _autoScrollController.scrollToIndex(currentIndex,
                    preferPosition: AutoScrollPosition.middle);
              });
            } else {
              setState(() {
                debugPrint("Change Index!");
                currentIndex = 0;
                _autoScrollController.scrollToIndex(currentIndex,
                    preferPosition: AutoScrollPosition.middle);
              });
            }
          }
          if (!compareTime && check && i == widget.audioClip.length - 1) {
            setState(() {
              debugPrint("Change Index!");
              currentIndex = widget.audioClip[i]["index"];
              _autoScrollController.scrollToIndex(currentIndex,
                  preferPosition: AutoScrollPosition.middle);
            });
          }
        }
      });
    });
    super.initState();
  }

  setPlayerConfig() async {
    await player.play(UrlSource(widget.audioUrl.toString()));
    await player.pause();
    loading = false;
    setState(() {});
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
                        "Unit ${widget.lesson} - Kaiwa",
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
                // Row(
                //   children: [
                //     Text(
                //       "はじめまして တွေ့ရတာ ဝမ်းသာပါတယ်။",
                //       style: bodyTextMessage.copyWith(color: Colors.grey[800]
                //           // isMe
                //           //     ? Colors.white
                //           //     : Colors.grey[800]
                //           ),
                //     ),
                //   ],
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 85),
                    child: ListView.builder(
                        controller: _autoScrollController,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        // itemExtent: 50,
                        padding: const EdgeInsets.all(0.0),
                        // itemCount: snapshot.data.length,
                        itemCount: widget.messages.length,
                        // separatorBuilder: (BuildContext context, int index) =>
                        //     const Divider(height: 0),
                        itemBuilder: (BuildContext context, int index) {
                          final message = widget.messages[index];
                          bool isMe = message["isMe"] && !showLeftSide;
                          return AutoScrollTag(
                            key: ValueKey(index),
                            controller: _autoScrollController,
                            index: index,
                            // highlightColor:
                            //     const Color.fromRGBO(244, 67, 54, 1),
                            child: message["type"] == "title"
                                ? Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              message["japan"],
                                              style: bodyTextMessage.copyWith(
                                                  color: currentIndex == index
                                                      ? secondaryColor
                                                      : Colors.grey[900]
                                                  // isMe
                                                  //     ? Colors.white
                                                  //     : Colors.grey[800]
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              message["myanmar"],
                                              style: bodyTextMessage.copyWith(
                                                  color: currentIndex == index
                                                      ? secondaryColor
                                                      : Colors.grey[900]
                                                  // isMe
                                                  //     ? Colors.white
                                                  //     : Colors.grey[800]
                                                  ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Row(
                                            mainAxisAlignment: isMe
                                                ? MainAxisAlignment.end
                                                : MainAxisAlignment.start,
                                            children: [
                                              if (!isMe)
                                                SizedBox(
                                                  width: 40,
                                                ),
                                              // Icon(
                                              //   Icons.done_all,
                                              //   size: 20,
                                              //   color: bodyTextTime.color,
                                              // ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              // Text(
                                              //   message["speaker"],
                                              //   style: bodyTextTime,
                                              // ),
                                              ConvertSpeaker(
                                                name: message["avatar"],
                                              ),
                                              if (isMe)
                                                SizedBox(
                                                  width: 45,
                                                ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: isMe
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (!isMe)
                                              ConvertAvatar(
                                                  name: message["avatar"]),
                                            // CircleAvatar(
                                            //   radius: 15,
                                            //   backgroundImage: convertAvatar(message["avatar"]),
                                            //       // AssetImage(message.sender.avatar),
                                            // ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.6),
                                              decoration: BoxDecoration(
                                                  color:
                                                      // Colors.amberAccent,
                                                      isMe
                                                          ? Colors.amberAccent
                                                          : Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16),
                                                    bottomLeft: Radius.circular(
                                                        isMe ? 12 : 0),
                                                    bottomRight:
                                                        Radius.circular(
                                                            isMe ? 0 : 12),
                                                  )),
                                              child: Text(
                                                showMyanmar
                                                    ? '${message["japan"]}\n${message["myanmar"]}'
                                                    : '${message["japan"]}',
                                                style: bodyTextMessage.copyWith(
                                                    color: currentIndex == index
                                                        ? secondaryColor
                                                        : Colors.grey[800]
                                                    // isMe
                                                    //     ? Colors.white
                                                    //     : Colors.grey[800]
                                                    ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            if (isMe)
                                              ConvertAvatar(
                                                  name: message["avatar"]),
                                            // CircleAvatar(
                                            //   radius: 15,
                                            //   backgroundImage: AssetImage(
                                            //       "asssets/avatar/sato.jpg"),
                                            //   // AssetImage(message.sender.avatar),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          );
                        }),

                    // ListView.builder(
                    //     reverse: false,
                    //     itemCount: messages.length,
                    //     itemBuilder: (context, int index) {
                    //       final message = messages[index];
                    //       bool isMe = message["isMe"];
                    //       return message["type"] == "title"
                    //           ? Container(
                    //               padding: EdgeInsets.only(top: 5),
                    //               child: Column(
                    //                 children: [
                    //                   Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.center,
                    //                     children: [
                    //                       Text(
                    //                         message["japan"],
                    //                         style: bodyTextMessage.copyWith(
                    //                             color: currentIndex == index
                    //                                 ? Colors.red
                    //                                 : Colors.grey[900]
                    //                             // isMe
                    //                             //     ? Colors.white
                    //                             //     : Colors.grey[800]
                    //                             ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.center,
                    //                     children: [
                    //                       Text(
                    //                         message["myanmar"],
                    //                         style: bodyTextMessage.copyWith(
                    //                             color: currentIndex == index
                    //                                 ? Colors.red
                    //                                 : Colors.grey[900]
                    //                             // isMe
                    //                             //     ? Colors.white
                    //                             //     : Colors.grey[800]
                    //                             ),
                    //                       ),
                    //                     ],
                    //                   )
                    //                 ],
                    //               ),
                    //             )
                    //           : Container(
                    //               margin: EdgeInsets.only(
                    //                   top: 5, left: 10, right: 10),
                    //               child: Column(
                    //                 children: [
                    //                   Padding(
                    //                     padding:
                    //                         const EdgeInsets.only(top: 5),
                    //                     child: Row(
                    //                       mainAxisAlignment: isMe
                    //                           ? MainAxisAlignment.end
                    //                           : MainAxisAlignment.start,
                    //                       children: [
                    //                         if (!isMe)
                    //                           SizedBox(
                    //                             width: 40,
                    //                           ),
                    //                         // Icon(
                    //                         //   Icons.done_all,
                    //                         //   size: 20,
                    //                         //   color: bodyTextTime.color,
                    //                         // ),
                    //                         SizedBox(
                    //                           width: 8,
                    //                         ),
                    //                         Text(
                    //                           message["speaker"],
                    //                           style: bodyTextTime,
                    //                         ),
                    //                         if (isMe)
                    //                           SizedBox(
                    //                             width: 45,
                    //                           ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Row(
                    //                     mainAxisAlignment: isMe
                    //                         ? MainAxisAlignment.end
                    //                         : MainAxisAlignment.start,
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.end,
                    //                     children: [
                    //                       if (!isMe)
                    //                         ConvertAvatar(
                    //                             name: message["avatar"]),
                    //                       // CircleAvatar(
                    //                       //   radius: 15,
                    //                       //   backgroundImage: convertAvatar(message["avatar"]),
                    //                       //       // AssetImage(message.sender.avatar),
                    //                       // ),
                    //                       SizedBox(
                    //                         width: 10,
                    //                       ),
                    //                       Container(
                    //                         padding: EdgeInsets.all(10),
                    //                         constraints: BoxConstraints(
                    //                             maxWidth:
                    //                                 MediaQuery.of(context)
                    //                                         .size
                    //                                         .width *
                    //                                     0.6),
                    //                         decoration: BoxDecoration(
                    //                             color:
                    //                                 // Colors.amberAccent,
                    //                                 isMe
                    //                                     ? Colors.amberAccent
                    //                                     : Colors.grey[200],
                    //                             borderRadius:
                    //                                 BorderRadius.only(
                    //                               topLeft:
                    //                                   Radius.circular(16),
                    //                               topRight:
                    //                                   Radius.circular(16),
                    //                               bottomLeft: Radius.circular(
                    //                                   isMe ? 12 : 0),
                    //                               bottomRight:
                    //                                   Radius.circular(
                    //                                       isMe ? 0 : 12),
                    //                             )),
                    //                         child: Text(
                    //                           '${message["japan"]}\n${message["myanmar"]}',
                    //                           style: bodyTextMessage.copyWith(
                    //                               color: currentIndex == index
                    //                                   ? Colors.red
                    //                                   : Colors.grey[800]
                    //                               // isMe
                    //                               //     ? Colors.white
                    //                               //     : Colors.grey[800]
                    //                               ),
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         width: 10,
                    //                       ),
                    //                       if (isMe)
                    //                         ConvertAvatar(
                    //                             name: message["avatar"]),
                    //                       // CircleAvatar(
                    //                       //   radius: 15,
                    //                       //   backgroundImage: AssetImage(
                    //                       //       "asssets/avatar/sato.jpg"),
                    //                       //   // AssetImage(message.sender.avatar),
                    //                       // ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             );
                    //     }),
                  ),
                )
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      child: StreamBuilder(
                          stream: player.onPositionChanged,
                          builder: (context, data) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    loading
                                        ? Container(
                                            width: 30,
                                            height: 30,
                                            // padding: EdgeInsets.only(left: 5),
                                            child: CircularProgressIndicator(
                                              color: Colors.black26,
                                            ))
                                        : GestureDetector(
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.13,
                                              child: Icon(
                                                player.state ==
                                                        PlayerState.playing
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

class ConvertSpeaker extends StatelessWidget {
  final String name;
  const ConvertSpeaker({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    // if (name == "sato") {
    return Text(
      name == "sato"
          ? sato.name
          : name == "yamada"
              ? yamada.name
              : name == "mira"
                  ? mira.name
                  : name == "santosu"
                      ? santosu.name
                      : currentUser.name,
      style: bodyTextTime,
    );

    // }
  }
}

class ConvertAvatar extends StatelessWidget {
  final String name;
  const ConvertAvatar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    // if (name == "sato") {
    return CircleAvatar(
      radius: 15,
      backgroundImage: AssetImage(name == "sato"
          ? sato.avatar
          : name == "yamada"
              ? yamada.avatar
              : name == "mira"
                  ? mira.avatar
                  : name == "santosu"
                      ? santosu.avatar
                      : currentUser.avatar),
    );
    // }
  }
}

class User {
  final int id;
  final String name;
  final String kanji;
  final String avatar;

  User({
    required this.id,
    required this.name,
    required this.kanji,
    required this.avatar,
  });
}

final User currentUser =
    User(id: 0, name: 'You', kanji: '', avatar: 'assets/logo.png');

final User mira =
    User(id: 1, name: 'ミラーさん', kanji: '', avatar: 'assets/avatar/mira.jpg');

final User sato =
    User(id: 2, name: 'さとうさん', kanji: '佐藤さん', avatar: 'assets/avatar/sato.jpg');

final User yamada = User(
    id: 3, name: 'やまださん', kanji: '山田さん', avatar: 'assets/avatar/yamada.jpg');

final User santosu =
    User(id: 4, name: 'サントスさん', kanji: '', avatar: 'assets/avatar/santosu.jpg');
