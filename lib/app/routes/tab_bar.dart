import 'package:flutter/material.dart';
import 'package:go_watch/app/constants/style.dart';
import 'package:go_watch/app/pages/home/home_page.dart';
import 'package:go_watch/app/pages/search/search_page.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({super.key});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  List<Widget> pages = [
    const SearchPage(),
    const HomePage(),
  ];

  void _onItemTapped(int index) {
    if (index != 2) {
      setState(() {
        _tabController.index = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_tabController.index],
      backgroundColor: primaryColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        elevation: 0,
        onTap: _onItemTapped,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black.withOpacity(0.8),
        items: [
          const BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.search,
              ),
              label: 'Pesquisar'),
          BottomNavigationBarItem(
              icon: Container(
                width: 50,
                height: 50,
                transform: Matrix4.translationValues(0, -15, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: Colors.pink),
                child: const Center(
                  child: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              label: 'Inicio'),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
              ),
              label: 'Perfil')
        ],
      ),
    );
  }
}
