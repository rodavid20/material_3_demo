
import 'package:flutter/material.dart';
import 'package:material_3_demo/utils/hymn_changed.dart';
import 'package:share_plus/share_plus.dart';

import '../utils/custom_search_delegate.dart';
import '../utils/navigation_bars.dart';
import 'hymn_screen.dart';
import 'hymnlist_screen.dart';
import 'notation_screen.dart';

import 'package:share_plus/share_plus.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int screenIndex = 0;
  late TabController _tabController;
  int selectedIndex = 0;
  int selectedHymnNo = 1;
  String selectedHymnType = "K";

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
        print(selectedIndex);
      });
    });
  }

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  Widget createScreenFor(int screenIndex, bool showNavBarExample) {
    switch (screenIndex) {
      case 0:
        return HymnScreen();
      case 1:
        return NotationScreen();
      case 2:
        return HymnListScreen("A");
      case 3:
        return HymnListScreen("C");
      default:
        return HymnScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: NotificationListener<HymnChanged>(
          child: Scaffold(
            appBar: createAppBar(context),
            body: createScreenFor(screenIndex, false),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: (screenIndex == 1 ? FloatingActionButton(
              // isExtended: true,
              child: Icon(Icons.play_arrow),
              onPressed: () {

              },
            ) : null),
            bottomNavigationBar: NavigationBars(
              onSelectItem: handleScreenChanged,
              selectedIndex: screenIndex,
            ),
          ),
          onNotification: (HymnChanged notification) {
            setState(() {
              selectedHymnType= notification.hymnType;
              selectedHymnNo = notification.hymnNo;
            });
            return true;
          }),
    );
  }

  String getAppBarTitle() {
    switch (screenIndex) {
      case 0:
      case 1:
        return (selectedHymnType == "K" ? "Kan. No." : "Tulu No.") + " $selectedHymnNo";
      case 2:
        return "Alphabet Index";
      case 3:
        return "Category Index";
      default:
        return "";
    }
  }

  PreferredSizeWidget createAppBar(BuildContext context) {
    return AppBar(
      title: Text(getAppBarTitle()),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
          tooltip: "Search Hymn",
        ),
        PopupMenuButton<int>(
          itemBuilder: (context) => [
            // popupmenu item 1
            PopupMenuItem(
              value: 1,
              // row has two child icon and text.
              child: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Settings")
                ],
              ),
            ),
            // popupmenu item 2
            PopupMenuItem(
              value: 2,
              // row has two child icon and text
              child: Row(
                children: [
                  Icon(Icons.share),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Share")
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 1) {

            } else if (value == 2) {
              Share.share('Shared from MangaloreHymns App');
            }
          },
        ),
      ],
    );
  }
}
