import 'package:flutter/material.dart';
import 'package:link_up/pages/goods_page.dart';
import 'package:link_up/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // Goods Page wrapped with gradient container
    Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 34, 90, 50),
            Color.fromARGB(255, 17, 35, 22),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: const GoodsPage(),
    ),
    Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 34, 90, 50),
            Color.fromARGB(255, 17, 35, 22),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: const Center(
        child: Text(
          "Find Housing/Mess",
          style: TextStyle(
            color: Color.fromARGB(255, 88, 236, 130),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 34, 90, 50),
            Color.fromARGB(255, 17, 35, 22),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: const Center(
        child: Text(
          "Find Tuition",
          style: TextStyle(
            color: Color.fromARGB(255, 88, 236, 130),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 34, 90, 50),
            Color.fromARGB(255, 17, 35, 22),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: const Center(
        child: Text(
          "Find Part-Time Jobs",
          style: TextStyle(
            color: Color.fromARGB(255, 88, 236, 130),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset("assets/images/appbgG4.jpg", fit: BoxFit.fill),
          ),

          // Gradient Container for content
          Positioned(
            top: 100,
            bottom: 0,
            left: 0,
            right: 0,
            child: _pages[_currentIndex],
          ),

          // Top Row: Logo + Profile Button
          Positioned(
            top: -30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 30), // spacer for centering logo
                Image.asset(
                  'assets/images/linkUpLogo.png',
                  height: height * 0.2, // fixed height to keep it at top
                ),
                IconButton(
                  icon: const Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 88, 236, 130),
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color.fromARGB(
          255,
          17,
          35,
          22,
        ), // welcome card color
        selectedItemColor: const Color.fromARGB(255, 88, 236, 130),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Goods",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.house), label: "Housing"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Tuition"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
        ],
      ),
    );
  }
}
