import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dictionary/bookmark.dart';
import 'package:dictionary/colors.dart';
import 'package:dictionary/dialog-helper.dart';
import 'package:dictionary/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

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
    super.initState();

    _tabController = new TabController(vsync: this, length: 2);
    _tabController.index = widget.tabIndex;
    _selectedItemPosition = widget.tabIndex;
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
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
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
  // ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(25)),
  // );

  ShapeBorder? bottomBarShape = const BeveledRectangleBorder(
      borderRadius: BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  ));
  Color selectedColor = selectColor;
  Color unselectedColor = selectColor;
  int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.rectangle;

  EdgeInsets padding = const EdgeInsets.all(0);

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
      backgroundColor: Colors.white,
      // bottomNavigationBar: menu(),
      bottomNavigationBar: SnakeNavigationBar.color(
        // height: 80,
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
backgroundColor: Color.fromARGB(255, 159, 159, 159),
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() {
          _selectedItemPosition = index;
          _tabController.index = index;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'bookmark'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
      body: new TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          BookmarkPage(),
          // SettingMain(),
        ],
        controller: _tabController,
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
