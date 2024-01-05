import 'package:auto_animated/auto_animated.dart';
import 'package:mjdictionary/choose_units.dart';
import 'package:mjdictionary/common/global_constant.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:mjdictionary/grammar.dart';
import 'package:mjdictionary/grammar_list.dart';
import 'package:mjdictionary/conversation.dart';
import 'package:mjdictionary/kaiwa.dart';
import 'package:mjdictionary/translate.dart';
import 'package:mjdictionary/utils/colors_util.dart';

import 'components/gradient_text.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage>
    with AutomaticKeepAliveClientMixin {
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
    {"title": "Numbers", "icon": Icons.numbers_rounded, "page": GrammarPage()},
    {
      "title": "Grammar",
      "icon": Icons.menu_book_rounded,
      "page": GrammarPage()
    },
    {
      "title": "G Form",
      "icon": Icons.markunread_mailbox_rounded,
      "page": GrammarFormListPage()
    },
    {"title": "Kaiwa", "icon": Icons.tag_faces_sharp, "page": KaiwaPage()},
    {"title": "Conversation", "icon": Icons.tag_faces_sharp, "page": ConversationPage()},{
      "title": "FlashCard Kotoba",
      "icon": Icons.memory_rounded,
      "page": ChooseUnitsPage()
    },
    {"title": "Translate", "icon": Icons.translate, "page": TranslatePage()},
  ];

  @override
  Widget build(BuildContext context) {
    // Build animated item (helper for all examples)
    Widget buildAnimatedItem(
      BuildContext context,
      int index,
      Animation<double> animation,
    ) =>
        // For example wrap with fade transition
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          // And slide transition
          child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              // Paste you Widget
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        );

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
                      secondaryColor,
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
                  //               secondaryColor,
                  //               secondaryColor,
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
                      child: LiveGrid.options(
                        options: options,
                        itemBuilder: buildAnimatedItem,
                        itemCount: moreList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          // crossAxisSpacing: 16,
                          // mainAxisSpacing: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
              //   child: Column(
              //     children: [
              //       Expanded(
              //         child: GridView.builder(
              //           gridDelegate:
              //               const SliverGridDelegateWithFixedCrossAxisCount(
              //                   crossAxisCount: 4),
              //           itemCount: moreList.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             return GestureDetector(
              //               onTap: () {
              //                 Navigator.push(context,
              //                     MaterialPageRoute(builder: (context) {
              //                   return moreList[index]["page"];
              //                 }));
              //               },
              //               child: Card(
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(10),
              //                   //set border radius more than 50% of height and width to make circle
              //                 ),
              //                 elevation: 5,
              //                 shadowColor: Colors.black,
              //                 color: Colors.amber[100],
              //                 // color: Colors.primaries[index % 10][100],
              //                 child: Stack(
              //                   children: [
              //                     Column(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.center,
              //                       children: [
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.center,
              //                           children: [
              //                             Icon(moreList[index]["icon"]),
              //                           ],
              //                         ),
              //                         SizedBox(
              //                           height: 5,
              //                         ),
              //                         Text(
              //                           '${moreList[index]["title"]}',
              //                           textAlign: TextAlign.center,
              //                           style: const TextStyle(
              //                               fontSize: 13,
              //                               fontWeight: FontWeight.bold),
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       )
              //     ],
              //   ),
              // ),
            ),
          ],
        ),
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
