import 'package:dictionary/components/colors.dart';
import 'package:flutter/material.dart';
class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(children: [
      Text("BOOKMARK>>>")
    ]),
    );
  }
}