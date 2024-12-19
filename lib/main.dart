import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:game_pandabyte/pixel_adventure.dart';
import 'package:flame/flame.dart';
import 'package:game_pandabyte/menu_overlay.dart'; // Import the menu overlay
import 'package:game_pandabyte/screens/Course.dart';
import 'package:game_pandabyte/screens/battle.dart';
import 'package:game_pandabyte/screens/home_page.dart'; // Import the homepage
import 'components/player.dart';
import 'screens/gallery.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen(); // Set device to full screen

  runApp(MaterialApp(
    initialRoute: '/', // Define the initial route (homepage)
    routes: {
      '/': (context) => MainPage(), // Main Menu page
      '/game': (context) => GamePage(), // Game page
    },
  ));
}

// MainPage with bottom navigation
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Selected index for the bottom navigation bar
  final PageController _pageController = PageController(); // PageController for navigation

  final List<Widget> _pages = [
    HomePage(), // HomePage
    BattleScreen(), // GamePage
    CharacterGalleryScreen(), // TestPage
    CoursePage(), // CoursePage
  ];

  // Handle bottom navigation tap
  void _onItemTapped(int index) {
    _pageController.jumpToPage(index); // Navigate to the selected page
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose PageController when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index; // Update selected index
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF141F23), // Dark color for the bottom nav bar
        selectedItemColor: Color(0xFF25F277), // Green color for selected item
        unselectedItemColor: Color(0xFF618BA1), // Blue color for unselected items
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', // Home page navigation
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Game', // Game page navigation
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Test', // Placeholder for test page
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses', // Placeholder for course page
          ),
        ],
      ),
    );
  }
}

// GamePage with the Flame GameWidget
class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PixelAdventure game = PixelAdventure();
    Player player = Player(character: 'Pink Man', position: Vector2(0, 0)); // Initialize Player

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GameWidget(game: game), // Flame game widget to render the game
          MenuOverlay(game: game, player: player), // Menu overlay on top of the game
        ],
      ),
    );
  }
}

// Placeholder for the HomePage
class HomePage extends StatelessWidget {
  final Color bgColor = Color(0xFF141F23);
  final Color cardColor = Color(0xFF334A56);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          Container(
            color: cardColor,
            padding: EdgeInsets.symmetric(vertical: 36, horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.local_fire_department, color: Colors.orange, size: 34),
                SizedBox(width: 4),
                Text(
                  "20",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Spacer(),
                Text(
                  "Welcome User",
                  style: TextStyle(color: Colors.white, fontSize: 38),
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildCard(context, "Assignments", Course1()),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildCard(context, "Favorites", FavoritePage()),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildCard(context, "Treasure", TreasurePage()),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildCard(context, "Profile", ProfilePage()),
          ),
        ],
      ),
    );
  }


  Widget _buildCard(BuildContext context, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFF3A4E5F),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                color: Color(0xFF7594A4),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder pages for navigation
class AssignmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Assignments Page", style: TextStyle(fontSize: 24))),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Favorites Page", style: TextStyle(fontSize: 24))),
    );
  }
}

class TreasurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Treasure Page", style: TextStyle(fontSize: 24))),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Profile Page", style: TextStyle(fontSize: 24))),
    );
  }
}

// Placeholder for the TestPage
class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Test Page", style: TextStyle(fontSize: 24))),
    );
  }
}

// Placeholder for the CoursePage
class CoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Courses Page", style: TextStyle(fontSize: 24))),
    );
  }
}
