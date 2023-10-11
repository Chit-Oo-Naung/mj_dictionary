import 'package:mjdictionary/alphabet.dart';
import 'package:mjdictionary/choose_units.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:mjdictionary/grammar.dart';
import 'package:mjdictionary/kaiwa.dart';
import 'package:mjdictionary/kotoba.dart';
import 'package:mjdictionary/lessons.dart';
import 'package:mjdictionary/translate.dart';
import 'package:mjdictionary/utils/icons.dart';

import 'components/gradient_text.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List moreList = [
    // {"title": "Alphabet", "icon": font, "page": AlphabetPage()},
    // {
    //   "title": "Kanji",
    //   "icon": language,
    //   "page": LessonsPage(
    //     tabIndex: 1,
    //   ),
    // },
    // {
    //   "title": "Lessons",
    //   "icon": book_1,
    //   "page": LessonsPage(
    //     tabIndex: 3,
    //   ),
    // },
    {
      "title": "Grammar",
      "icon": Icons.menu_book_rounded,
      "page": GrammarPage()
    },
    {
      "title": "G Form",
      "icon": Icons.markunread_mailbox_rounded,
      "page": GrammarPage()
    },
    {"title": "Kaiwa", "icon": Icons.tag_faces_sharp, "page": KaiwaPage()},
    {"title": "FlashCard Kotoba", "icon": Icons.memory_rounded, "page": ChooseUnitsPage()},
    {"title": "Translate", "icon": Icons.translate, "page": TranslatePage()},
  ];

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
              height: 200,
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
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                children: [
                  // Text(
                  //   "MJ Dictionary",
                  //   style: TextStyle(
                  //       fontSize: 19,
                  //       color: selectColor,
                  //       fontWeight: FontWeight.bold),
                  // )
                  GradientText(
                    "More",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                    gradient: LinearGradient(colors: [
                      Colors.black,
                      Color.fromARGB(255, 137, 37, 37),
                    ]),
                  ),
                  // Text("More",
                  //     style: TextStyle(
                  //         fontSize: 19.0,
                  //         fontWeight: FontWeight.bold,
                  //         foreground: Paint()
                  //           ..shader = const LinearGradient(
                  //             colors: <Color>[
                  //               Colors.black,
                  //               Color.fromARGB(255, 137, 37, 37),
                  //               Color.fromARGB(255, 137, 37, 37),
                  //             ],
                  //           ).createShader(
                  //               Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))))
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemCount: moreList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return moreList[index]["page"];
                              }));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              elevation: 5,
                              shadowColor: Colors.black,
                              color: Colors.amber[100],
                              // color: Colors.primaries[index % 10][100],
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(moreList[index]["icon"]),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),                                    
                                      Text(
                                        '${moreList[index]["title"]}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
