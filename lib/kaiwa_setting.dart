import 'package:flutter/material.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/gradient_text.dart';

class KaiwaSettingPage extends StatefulWidget {
  const KaiwaSettingPage({super.key});

  @override
  State<KaiwaSettingPage> createState() => _KaiwaSettingPageState();
}

class _KaiwaSettingPageState extends State<KaiwaSettingPage> {
  
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
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color.fromARGB(255, 137, 37, 37),
                      ),
                    ),
                    GradientText(
                      "Setting",
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                      gradient: LinearGradient(colors: [
                        Colors.black,
                        Color.fromARGB(255, 137, 37, 37),
                      ]),
                    ),
                    Container()
                  ],
                ),
              ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
                child: Column(
                  children: [
                    Text("Speed"),
                    Text("Order"),
                    Text("Await Time"),
                    Text("Hide Kanji"),
                    Text("Favorite"),
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