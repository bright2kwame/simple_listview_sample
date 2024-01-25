import 'package:find_better_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int activeIndex = 0;

  List<Widget> pages = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.black,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            height: 200,
          );
        },
        enableDrag: true,
        showDragHandle: true,
      ),
      endDrawer: Drawer(),
      drawer: Drawer(
        width: 200,
      ),
      body: pages[activeIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (position) {
            print("Pos: " + position.toString());

            setState(() {
              activeIndex = position;
            });
          },
          currentIndex: activeIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "My"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: "Home")
          ]),
    );
  }
}
