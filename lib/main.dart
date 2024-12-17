import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:game_pandabyte/pixel_adventure.dart';
import 'package:flame/flame.dart';
import 'package:game_pandabyte/menu_overlay.dart'; // Import the menu overlay
import 'package:game_pandabyte/screens/home_page.dart'; // Import the homepage
import 'components/player.dart';

// Entry point of the application
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

  final List<Widget> _pages = [
    HomePage(), // HomePage is shown initially
    GamePage(), // GamePage is navigated to from the bottom nav
    TestPage(), // Test Page (for future implementation)
    CoursePage(), // Courses Page (future navigation)
  ];

  // Handle navigation tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141F23), // Background color for home
      body: Center(
        child: Text(
          "Welcome to the Game App!",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
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
