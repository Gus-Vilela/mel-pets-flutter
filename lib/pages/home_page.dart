import 'package:flutter/material.dart';
import 'package:projeto/pages/missing_page.dart';
import 'package:projeto/pages/sighted_page.dart';
import 'package:projeto/pages/user_info_page.dart';
import 'package:projeto/repositories/user_repository.dart';

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
          children: const [MissingPage(), SightedPage(), UserInfoPage()],
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
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: 'Perdidos',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Avistados',
            ),
            BottomNavigationBarItem(
              icon: CurrentUser.currentUser.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        CurrentUser.currentUser.image as String,
                        width: 26,
                        height: 26,
                      ))
                  : const SizedBox(
                      width: 26, 
                      height: 26, 
                      child: Icon(Icons.person, size: 25),
                    ),
              label: 'Perfil',
            )
          ],
          backgroundColor: Colors.red[100],
        ));
  }
}
