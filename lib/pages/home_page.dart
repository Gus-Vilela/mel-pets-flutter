import 'package:flutter/material.dart';
import 'package:projeto/pages/missing_page.dart';
import 'package:projeto/pages/sighted_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: pageController,
          children: const [MissingPage(), SightedPage()],
          onPageChanged: (value) => setState(() => currentPage = value),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
              pageController.animateToPage(
                currentPage,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: 'Perdidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Avistados',
            ),
          ],
          backgroundColor: Colors.red[100],
        ));
  }
}
