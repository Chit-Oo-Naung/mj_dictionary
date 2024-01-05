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

class Message {
  final User sender;
  final String avatar;
  final String time;
  final int unreadCount;
  final bool isRead;
  final String text;
  final bool isMe;

  Message({
    required this.sender,
    required this.avatar,
    required this.time,
    required this.unreadCount,
    required this.text,
    required this.isRead,
    required this.isMe,
  });
}

class _KaiwaPageState extends State<KaiwaPage> {
  final player = AudioPlayer();
  Duration? duration;

  final List<Message> messages = [
    Message(
        sender: sato,
        time: 'さとうさん',
        avatar: sato.avatar,
        isRead: true,
        text: "おはようございます。\nမင်္ဂလာနံနက်ခင်းပါ။",
        unreadCount: 0,
        isMe: false),
    Message(
        sender: yamada,
        time: 'やまださん',
        isRead: true,
        avatar: yamada.avatar,
        text:
            "おはようございます。さとうさん、こちらは　マイク・ミラーさんです。\nမင်္ဂလာနံနက်ခင်းပါ။ စတိုစံ သူက မိုက်(ခ်)မီလာစံဖြစ်ပါတယ်။",
        unreadCount: 0,
        isMe: true),
    Message(
        sender: mira,
        time: 'ミラー さん',
        isRead: true,
        avatar: mira.avatar,
        text:
            "はじめまして。マイク・ミラーです。アメリカから　きました。どうぞ　よろしく。\nတွေ့ရတာ ဝမ်းသာပါတယ်။ မိုက်(ခ်)မီလာဖြစ်ပါတယ်။ အမေရိကားကနေ လာခဲ့ပါတယ်။ ခင်ခင်မင်မင်ဆက်ဆံပေးပါ။",
        unreadCount: 0,
        isMe: false),
    Message(
        sender: sato,
        time: 'さとうさん',
        avatar: sato.avatar,
        isRead: true,
        text:
            "さとうけいこです。 どうぞ　よろしく。\nစတိုခဲအိကို ဖြစ်ပါတယ်။ ခင်ခင်မင်မင်ဆက်ဆံပေးပါ။",
        unreadCount: 0,
        isMe: false),
  ];

  final User user = currentUser;

  // static Color kPrimaryColor = Color(0xff7C7B9B);
  // static Color kPrimaryColorVariant = Color(0xff686795);
  // static Color kAccentColor = Color(0xffFCAAAB);
  // static Color kAccentColorVariant = Color(0xffF7A3A2);
  // static Color kUnreadChatBG = Color(0xffEE1D1D);

  static final TextStyle bodyTextMessage =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w600);

  static final TextStyle bodyTextTime = TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

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
    await player.play(UrlSource(audioUrl.toString()));

    await player.pause();
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
                Container(
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 85),
                      child: ListView.builder(
                          reverse: false,
                          itemCount: messages.length,
                          itemBuilder: (context, int index) {
                            final message = messages[index];
                            bool isMe = message.isMe;
                            return Container(
                              margin:
                                  EdgeInsets.only(top: 5, left: 10, right: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
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
                                        Text(
                                          message.time,
                                          style: bodyTextTime,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (!isMe)
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage:
                                              AssetImage(message.sender.avatar),
                                        ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6),
                                        decoration: BoxDecoration(
                                            color:
                                                // Colors.amberAccent,
                                                isMe
                                                    ? Colors.amberAccent
                                                    : Colors.grey[200],
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                              bottomLeft: Radius.circular(
                                                  isMe ? 12 : 0),
                                              bottomRight: Radius.circular(
                                                  isMe ? 0 : 12),
                                            )),
                                        child: Text(
                                          messages[index].text,
                                          style: bodyTextMessage.copyWith(
                                              color: Colors.grey[800]
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
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage:
                                              AssetImage(message.sender.avatar),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
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

class User {
  final int id;
  final String name;
  final String avatar;

  User({
    required this.id,
    required this.name,
    required this.avatar,
  });
}

final User currentUser = User(id: 0, name: 'You', avatar: 'assets/logo.png');

final User mira = User(id: 1, name: 'sato', avatar: 'assets/avatar/mira.jpg');

final User sato = User(id: 2, name: 'Angel', avatar: 'assets/avatar/sato.jpg');

final User yamada =
    User(id: 3, name: 'Deanna', avatar: 'assets/avatar/yamada.jpg');

final User jason = User(id: 4, name: 'Json', avatar: 'assets/images/Jason.jpg');

final User judd = User(id: 5, name: 'Judd', avatar: 'assets/images/Judd.jpg');

final User leslie =
    User(id: 6, name: 'Leslie', avatar: 'assets/images/Leslie.jpg');

final User nathan =
    User(id: 7, name: 'Nathan', avatar: 'assets/images/Nathan.jpg');

final User stanley =
    User(id: 8, name: 'Stanley', avatar: 'assets/images/Stanley.jpg');

final User virgil =
    User(id: 9, name: 'Virgil', avatar: 'assets/images/Virgil.jpg');
