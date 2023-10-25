import 'package:flutter/material.dart';
import 'package:mjdictionary/common/global_constant.dart';
import 'package:mjdictionary/components/advanced_switch.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/gradient_text.dart';
import 'package:mjdictionary/utils/colors_util.dart';

class FlashCardSettingPage extends StatefulWidget {
  const FlashCardSettingPage({super.key});

  @override
  State<FlashCardSettingPage> createState() => _FlashCardSettingPageState();
}

class _FlashCardSettingPageState extends State<FlashCardSettingPage> {
  final randomCtrl = ValueNotifier<bool>(false);
  final showTopRandomCtrl = ValueNotifier<bool>(true);
  final changeJMCtrl = ValueNotifier<bool>(false);

  @override
  void initState() {
    randomCtrl.value = random;
    showTopRandomCtrl.value = showTopRandom;
    changeJMCtrl.value = changeJM;
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
              padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
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
                    "FlashCard Setting",
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
            Expanded(
              child: Card(
                margin: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  //set border radius more than 50% of height and width to make circle
                ),
                elevation: 5,
                shadowColor: Colors.black,
                color: Colors.white,
                child: Container(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 15, right: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientText(
                            "Random",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            gradient: LinearGradient(colors: [
                              Colors.black,
                              secondaryColor,
                            ]),
                          ),
                          AdvancedSwitch(
                            controller: randomCtrl,
                            activeColor: secondaryColor,
                            onChanged: (v) => {},
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientText(
                            "Show Meaning Random",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            gradient: LinearGradient(colors: [
                              Colors.black,
                              secondaryColor,
                            ]),
                          ),
                          AdvancedSwitch(
                            controller: showTopRandomCtrl,
                            activeColor: secondaryColor,
                            onChanged: (v) {
                              setState(() {});
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      showTopRandomCtrl.value
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ! True - Japan Top || False - Myanmar Top
                                GradientText(
                                  "Show Meaning Japan",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  gradient: LinearGradient(colors: [
                                    Colors.black,
                                    secondaryColor,
                                  ]),
                                ),
                                AdvancedSwitch(
                                  controller: changeJMCtrl,
                                  activeColor: secondaryColor,
                                  onChanged: (v) => {},
                                )
                              ],
                            ),
                      SizedBox(
                        height: 30,
                      ),
                      GradientText(
                        "* If you change and saved the setting, flash card list will reset",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        gradient: LinearGradient(colors: [
                          Colors.black,
                          secondaryColor,
                        ]),
                      ),

                      // Text("Speed"),
                      // Text("Order"),
                      // Text("Await Time"),
                      // Text("Hide Kanji"),
                      // Text("Favorite"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              // startKotoba();
            },
            child: Container(
              // color: mainColor,
              // height: 50,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: mainColor,
              ),
              child: GestureDetector(
                onTap: () {
                  // startKotoba();
                  bool randomVal = randomCtrl.value;
                  random = randomVal;
                  bool showTopRandomVal = showTopRandomCtrl.value;
                  showTopRandom = showTopRandomVal;
                  bool changeJMVal = changeJMCtrl.value;
                  changeJM = changeJMVal;
                  Navigator.of(context).pop(true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Saved Change",
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                      // gradient: LinearGradient(colors: [
                      //   Colors.black,
                      //   secondaryColor,
                      // ]
                      // ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
