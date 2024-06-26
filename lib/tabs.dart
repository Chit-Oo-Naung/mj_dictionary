import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mjdictionary/alphabet.dart';
import 'package:mjdictionary/more.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/dialog-helper.dart';
import 'package:mjdictionary/components/jsonprovider.dart';
import 'package:mjdictionary/home.dart';
import 'package:mjdictionary/lessons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:mjdictionary/utils/icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TabsPage extends StatefulWidget {
  final int tabIndex;
  const TabsPage({Key? key, required this.tabIndex}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  
  // int _page = 0;
  // GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: selectColor, // navigation bar color
    //   statusBarColor: mainColor, // status bar color
    // ));
    super.initState();

    _tabController = TabController(vsync: this, length: 5);
    _tabController.index = widget.tabIndex;
    _selectedItemPosition = widget.tabIndex;
    _getCloudData();
  }

  void statusCallback(EasyLoadingStatus status) {
    print('Loading Status $status');
  }

  @override
  void dispose() {
    _tabController.dispose();
    EasyLoading.showSuccess('Use in initState');
    EasyLoading.addStatusCallback(statusCallback);
    super.dispose();
  }

  _getCloudData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("stored_data") ?? "";
    // print("SD>> $storedData");
    List jsonList = [];
    if (storedData != "") {
      jsonList = json.decode(storedData);
      await addLevel(jsonList);
      // _streamController.add(userData);

      // List _modifiedData = groupJSONByUniqueKey(userData, "level");
      // debugPrint("LEVEL LIST >>> $_modifiedData");
    }

    if (firstTime) {
      try {
        if (storedData == "") {
          EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
          EasyLoading.instance.animationStyle =
              EasyLoadingAnimationStyle.custom;
          EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.pulse;
          await EasyLoading.show(
            status: 'Syncing...',
            maskType: EasyLoadingMaskType.clear,
          );
        }

        final url = Uri.parse(
            'https://drive.google.com/uc?export=view&id=1H9A6Fwx76gVOoSjWq44Su0iToLGYcJ_3');
        final response = await http.get(url).timeout(
          const Duration(seconds: 15),
          onTimeout: () {
            // Time has run out, do what you wanted to do.
            return http.Response(
                'Server failed!', 500); // Request Timeout response status code
          },
        );
        debugPrint("${response.statusCode}");
        if (response.statusCode == 200) {
          final data = json.decode(utf8.decode(response.bodyBytes));
          jsonList = data["items"];
          prefs.setString("stored_data", json.encode(data["items"]));
          setState(() {
            firstTime = false;
          });

          if (storedData == "") {
            await EasyLoading.dismiss();
            EasyLoading.showSuccess('Ok! let\'s go..');
          }
        }
      } catch (er) {
        await EasyLoading.showError("Server failed!", dismissOnTap: false);
        print(er);
      }
    }

    await addLevel(jsonList);

    // _streamController.add(data["items"]);
  }

  onWillPop() async {
    var i = await DialogHelper.dislog(context, 'assets/close.gif', "Exit",
        "Are you sure you want to exit?", "2", "blue", "dark");
    if (i == "Yes") {
      SystemNavigator.pop();
    }
  }

  late final List<BottomNavigationBarItem> items;

  /// If [SnakeBarBehaviour.floating] this color is
  /// used as background color of shaped view.
  /// If [SnakeBarBehaviour.pinned] this color just
  /// a background color of whole [SnakeNavigationBar] view
  late final Gradient backgroundGradient;

  /// This color represents a SnakeView and unselected
  /// Icon and label color
  late final Gradient snakeViewGradient;

  /// This color represents a selected Icon color
  late final Gradient selectedItemGradient;

  /// This color represents a unselected Icon color
  late final Gradient unselectedItemGradient;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  // late final bool showSelectedLabels;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  // late final bool showUnselectedLabels;

  /// The index into [items] for the current active [BottomNavigationBarItem].
  late final int currentIndex;

  ///You can specify custom elevation shadow color
  late final Color shadowColor;

  /// Defines the [SnakeView] shape and behavior of a [SnakeNavigationBar].
  ///
  /// See documentation for [SnakeShape] for information on the
  /// meaning of different shapes.
  ///
  /// Default is [SnakeShape.circle]
  // late final SnakeShape snakeShape;

  /// Defines the layout and behavior of a [SnakeNavigationBar].
  ///
  /// See documentation for [SnakeBarBehaviour] for information on the
  /// meaning of different styles.
  ///
  /// Default is [SnakeBarBehaviour.pinned]
  late final SnakeBarBehaviour behaviour;

  /// You can define custom [ShapeBorder] with padding and elevation to [SnakeNavigationBar]
  late final ShapeBorder shape;
  // late final EdgeInsets padding;
  late final double elevation;

  /// Called when one of the [items] is pressed.
  late final ValueChanged<int> onTap;

  // Widget menu() {
  //   return new Container(
  //     decoration: BoxDecoration(
  //       border: Border(
  //         top: BorderSide(
  //           color: Colors.grey.shade800,
  //           width: 0.6,
  //         ),
  //       ),
  //     ),
  //     child: new TabBar(
  //       indicator: BoxDecoration(),
  //       labelColor: Colors.lightBlue,
  //       unselectedLabelColor: Colors.grey,
  //       // indicatorWeight: 1.0,
  //       labelPadding: EdgeInsets.all(0),
  //       // labelStyle: TextStyle(fontSize: 12.0, fontFamily: "Pyidaungsu"),
  //       tabs: [
  //         Container(
  //           // height: 52,
  //           padding: EdgeInsets.only(top: 8),
  //           child: new Tab(
  //             child: Column(
  //               children: <Widget>[
  //                 Icon(
  //                   Icons.search,
  //                   size: widget.tabIndex == 0 ? 30 : 24,
  //                 ),
  //                 Transform(
  //                     transform: Matrix4.translationValues(0, -5, 0),
  //                     child: Text("Search")),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Container(
  //           // height: 52,
  //           padding: EdgeInsets.only(top: 8),
  //           child: new Tab(
  //             child: Column(
  //               children: <Widget>[
  //                 Icon(
  //                   Icons.bookmark,
  //                   size: 24,
  //                 ),
  //                 Transform(
  //                     transform: Matrix4.translationValues(0, -5, 0),
  //                     child: Text("Bookmark")),
  //               ],
  //             ),
  //           ),
  //         ),
  //         // Container(
  //         //   height: 52,
  //         //   padding: EdgeInsets.only(top: 8),
  //         //   child: new Tab(
  //         //     child: Column(
  //         //       children: <Widget>[
  //         //         Icon(
  //         //           Icons.settings,
  //         //           size: 24,
  //         //         ),
  //         //         Transform(
  //         //             transform: Matrix4.translationValues(0, -5, 0),
  //         //             child: Text("Settings")),
  //         //       ],
  //         //     ),
  //         //   ),
  //         // ),
  //       ],

  //       controller: _tabController,
  //       // ),
  //     ),
  //   );
  // }
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  // ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(25)),
  // );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  Color selectedColor = selectColor;
  Color unselectedColor = selectColor;
  int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.circle;

  EdgeInsets padding = const EdgeInsets.only(left: 8, right: 8, bottom: 8);

  bool showSelectedLabels = true;
  bool showUnselectedLabels = true;

  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;
  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
    const Color(0xFFF4E4CE),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.white,
      // bottomNavigationBar: menu(),
      bottomNavigationBar: SnakeNavigationBar.color(
        height: 50,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,

        ///configuration for SnakeNavigationBar.gradient
        // snakeViewGradient: selectedGradient,
        // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        // unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        backgroundColor: mainColor,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() {
          _selectedItemPosition = index;
          _tabController.index = index;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(font), label: 'Alphabet'),
          BottomNavigationBarItem(icon: Icon(language), label: 'Kanji'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(book_1), label: 'Lessons'),
          BottomNavigationBarItem(
              icon: Icon(Icons.move_up_rounded), label: 'More'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
      body: SafeArea(
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const <Widget>[
            AlphabetPage(),
            LessonsPage(
              tabIndex: 1,
            ),
            HomePage(),
            LessonsPage(
              tabIndex: 3,
            ),
            BookmarkPage(),
            // SettingMain(),
          ],
        ),
      ),
    );
    //   return Scaffold(
    //       backgroundColor: Colors.deepPurple,
    //       bottomNavigationBar: CurvedNavigationBar(
    //         backgroundColor: Colors.deepPurple,
    //         color: Colors.deepPurple.shade200,
    //         animationDuration: const Duration(milliseconds: 300),
    //         onTap: (index) {
    //           setState(() {
    //             _page = index;
    //             print("$_page");
    //           });
    //         },
    //         items: const [
    //           Icon(
    //             Icons.search,
    //             color: Colors.white,
    //           ),
    //           Icon(
    //             Icons.bookmark,
    //             color: Colors.white,
    //           ),
    //         ],
    //       ));
    // }
  }
}
