import 'package:flutter/material.dart';

import 'mazeGame.dart';
import 'package:game_pandabyte/menu_overlay.dart';
String gameLevel = 'Level_01';
int priorityFruit = 0;
class Course1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage(); // Directly return HomePage without wrapping in a new MaterialApp.
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color bgColor = Color(0xFF141F23);
  final Color circleColor = Color(0xFF334A56);
  final Color activeCircleColor = Color(0xFF25F277);
  List<bool> circleStates = [false, false, false, false]; // Initial state for each circle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF334A56),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        title: Text(
          '1. Programming',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            child: CustomPaint(
              painter: CirclePathPainter(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // First Circle
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        circleStates[0] = true;
                      });
                      showConditionSection = true; //show the if then dropdown in the menu overlay if it goes with the course
                      gameLevel = 'Level_01';
                      priorityFruit = -1;
                      Navigator.pushNamed(context, '/game'); // Navigate using named route
                    },
                    child: buildCircle(
                      "Programming Fundamentals",
                      circleStates[0] ? activeCircleColor : circleColor,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Second Circle
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        circleStates[1] = true;
                      });
                      gameLevel = 'Level_02';
                      priorityFruit = 0;
                      Navigator.pushNamed(context, '/game'); // Navigate using named route
                    },
                    child: buildCircle(
                      "Data Structures",
                      circleStates[1] ? activeCircleColor : circleColor,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Third Circle
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        circleStates[2] = true;
                      });
                      gameLevel = 'Level_03';
                      Navigator.pushNamed(context, '/game'); // Navigate using named route
                    },
                    child: buildCircle(
                      "Algorithms",
                      circleStates[2] ? activeCircleColor : circleColor,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Fourth Circle
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        circleStates[3] = true; // Update the state
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RobotGamePage()), // Navigate to RobotGamePage
                      );
                    },
                    child: buildCircle(
                      "Advanced Topiscs",
                      circleStates[3] ? activeCircleColor : circleColor,
                    ),
                  ),
                  SizedBox(height: 40),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCircle(String label, Color color) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CirclePathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Color(0xFF25F277)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    // Draw the connecting lines
    double startX = size.width / 2;
    double startY = 60;
    double spacing = 160;

    for (int i = 0; i < 3; i++) {
      canvas.drawLine(
        Offset(startX, startY),
        Offset(startX, startY + spacing),
        linePaint,
      );
      startY += spacing;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// CoursePage for navigation
class CoursePage extends StatelessWidget {
  final String courseName;

  CoursePage({required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF334A56),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
        title: Text(courseName, style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(
          courseName,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      backgroundColor: Color(0xFF141F23),
    );
  }
}
