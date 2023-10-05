import 'dart:convert';
import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/gradient_text.dart';
import 'package:mjdictionary/kaiwa_setting.dart';

class KotobaPage extends StatefulWidget {
  final List kotobalist;
  const KotobaPage({super.key, required this.kotobalist});

  @override
  State<KotobaPage> createState() => _KotobaPageState();
}

class _KotobaPageState extends State<KotobaPage> {
  final FlutterTts tts = FlutterTts();
  // List kotobalist = [
  //   {
  //     "myanmar": "ကျွန်ုပ်၊ ကျွန်တော်/ ကျွန်မ",
  //     "japan": "わたし",
  //     "romaji": "watashi",
  //     "type": "n",
  //     "lesson": "1",
  //     "new": "",
  //     "konnyomi": "",
  //     "onnyomi": "",
  //     "level": "N5",
  //     "kanji": "私",
  //     "sentence": [
  //       {"myanmar": "", "japan": "", "kanji": "", "sennew": ""}
  //     ]
  //   },
  //   {
  //     "myanmar": "သင်၊ ခင်ဗျား၊ ရှင်",
  //     "japan": "あなた",
  //     "romaji": "anata",
  //     "type": "n",
  //     "lesson": "1",
  //     "new": "",
  //     "konnyomi": "",
  //     "onnyomi": "",
  //     "level": "N5",
  //     "kanji": "貴方",
  //     "sentence": [
  //       {"myanmar": "", "japan": "", "kanji": "", "sennew": ""}
  //     ]
  //   },
  //   {
  //     "myanmar": "ဟိုလူ (ဟိုပုဂ္ဂိုလ်)",
  //     "japan": "あのひと",
  //     "romaji": "anohito",
  //     "type": "n",
  //     "lesson": "1",
  //     "new": "",
  //     "konnyomi": "",
  //     "onnyomi": "",
  //     "level": "N5",
  //     "kanji": "あの人",
  //     "sentence": [
  //       {"myanmar": "", "japan": "", "kanji": "", "sennew": ""}
  //     ]
  //   },
  // ];

  @override
  void initState() {
    // kotobalist.add(kotobalist[0]["showtop"] = boolValue);
    tts.setLanguage('ja');
    tts.setSpeechRate(0.4);
    for (var i = 0; i < widget.kotobalist.length; i++) {
      // ! True - Japan Top || False - Myanmar Top
      var boolValue = Random().nextBool();
      widget.kotobalist[i]["showtop"] = boolValue;
      widget.kotobalist[i]["showanswer"] = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: mainColor,
        body: Stack(
      children: [
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              // color: mainColor,
              height: 250,
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
              padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Color.fromARGB(255, 137, 37, 37),
                    ),
                  ),
                  GradientText(
                    "FlashCard Kotoba",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                    gradient: LinearGradient(colors: [
                      Colors.black,
                      Color.fromARGB(255, 137, 37, 37),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return KaiwaSettingPage();
                      }));
                    },
                    child: const Icon(
                      Icons.settings,
                      color: Color.fromARGB(255, 137, 37, 37),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 18.0, left: 0, right: 0,),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Expanded(
                      child: Swiper(
                        onIndexChanged: (value) {},
                        onTap: (index) {
                          setState(() {});
                          widget.kotobalist[index]["showanswer"] = true;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                             padding: EdgeInsets.only(bottom: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              elevation: 5,
                              shadowColor: Colors.black,
                              color: Colors.white,
                              // color: Colors.primaries[index % 10][100],
                              child: Container(
                                // padding: EdgeInsets.all(10),
                                                
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: GestureDetector(
                                        onTap: () async {
                                          debugPrint("Click Speak>>>");
                                          await tts.setSharedInstance(true);
                                          await tts.awaitSynthCompletion(true);
                                          await tts.awaitSpeakCompletion(true);
                                                
                                          await tts.speak(
                                              "${widget.kotobalist[index]["japan"]}");
                                          debugPrint("Click Speak Done>>>");
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.only(
                                                bottomLeft: Radius.circular(30.0),
                                                bottomRight:
                                                    Radius.circular(30.0)),
                                            color: mainColor,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.volume_down_alt,
                                                size: 30,
                                              )
                                              // Text(
                                              //   'Footer',
                                              //   textAlign: TextAlign.center,
                                              //   style: const TextStyle(
                                              //       fontSize: 13,
                                              //       fontWeight: FontWeight.bold),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    LayoutBuilder(
                                      builder: (BuildContext context,
                                          BoxConstraints constraints) {
                                        return Column(
                                          children: [
                                            Container(
                                              height:
                                                  (constraints.maxHeight / 2) -
                                                      25,
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.1),
                                              child: widget.kotobalist[index]["showtop"]
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                '${widget.kotobalist[index]["japan"]}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                '${widget.kotobalist[index]["kanji"]}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 28,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                '${widget.kotobalist[index]["myanmar"]}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                            Container(
                                              height:
                                                  (constraints.maxHeight / 2) -
                                                      25,
                                                      padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.12),
                                              child: !widget.kotobalist[index]
                                                      ["showanswer"]
                                                  ? Container()
                                                  : widget.kotobalist[index]["showtop"]
                                                      ? Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    '${widget.kotobalist[index]["myanmar"]}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      : Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    '${widget.kotobalist[index]["japan"]}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    '${widget.kotobalist[index]["kanji"]}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          28,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: widget.kotobalist.length,
                        viewportFraction: 0.85,
                        scale: 0.9,
                        loop: false,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
