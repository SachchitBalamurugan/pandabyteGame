import 'package:flutter/material.dart';
import 'dart:math';

class RobotGamePage extends StatefulWidget {
  @override
  _RobotGamePageState createState() => _RobotGamePageState();
}

class _RobotGamePageState extends State<RobotGamePage> {
  final Color bgColor = Color(0xFF141F23);
  final Color mapColor = Color(0xFF334A56);
  final Color robotColor = Color(0xFF25F277);
  final Color coinColor = Color(0xFFFFC107);

  // Robot position
  int robotX = 1; // Column position
  int robotY = 1; // Row position
  List<String> commands = []; // Commands entered by the user
  int collectedCoins = 0; // Track the number of collected coins

  // Grid size
  final int gridRows = 5;
  final int gridCols = 5;

  // Coin positions (randomly placed)
  late List<List<bool>> coins;

  @override
  void initState() {
    super.initState();
    _generateCoins(); // Initialize random coin positions
  }

  // Generate random coin positions
  void _generateCoins() {
    Random rand = Random();
    coins = List.generate(gridRows, (row) {
      return List.generate(gridCols, (col) {
        return rand.nextBool(); // Randomly decide if there's a coin at this position
      });
    });
  }

  // Execute the commands
  void executeCommands() async {
    for (String command in commands) {
      // Parse the command to get the direction and steps
      RegExp regExp = RegExp(r'robot\.MOVE(\w+)\((\d+)\)');
      Match? match = regExp.firstMatch(command);

      if (match != null) {
        String direction = match.group(1)!;
        int steps = int.parse(match.group(2)!);

        // Move the robot step by step with delay
        for (int i = 0; i < steps; i++) {
          await Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              // Move the robot based on the direction
              if (direction == 'UP' && robotY - 1 >= 0) {
                robotY -= 1;
              } else if (direction == 'DOWN' && robotY + 1 < gridRows) {
                robotY += 1;
              } else if (direction == 'LEFT' && robotX - 1 >= 0) {
                robotX -= 1;
              } else if (direction == 'RIGHT' && robotX + 1 < gridCols) {
                robotX += 1;
              }

              // Check if the robot lands on a coin
              if (coins[robotY][robotX]) {
                collectedCoins++; // Collect the coin
                coins[robotY][robotX] = false; // Remove the coin from the grid
              }
            });
          });
        }
      }
    }

    setState(() {
      commands.clear(); // Clear commands after execution
    });
  }

  // Show tutorial dialog
  void _showTutorial() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text(
            "Tutorial",
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. Use commands like 'robot.MOVEUP(1)' to move the robot one step up.",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "2. The robot will move one step at a time with a delay.",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "3. Collect coins by moving the robot over them.",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  "Try to collect as many coins as possible!",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Use foregroundColor instead of primary
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: mapColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: Text(
          "Robot Game",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.flag, color: Colors.white), // Flag icon
            onPressed: _showTutorial, // Show tutorial when clicked
          ),
        ],
      ),
      body: Column(
        children: [
          // Top Half: Map and Robot
          Expanded(
            flex: 2,
            child: Container(
              color: mapColor,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCols,
                ),
                itemCount: gridRows * gridCols,
                itemBuilder: (context, index) {
                  int x = index % gridCols; // Column index
                  int y = index ~/ gridCols; // Row index
                  return GestureDetector(
                    onTap: () {
                      // You can add a tap event to show info or more interactions
                    },
                    child: Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: (x == robotX && y == robotY)
                            ? robotColor
                            : (coins[y][x] ? coinColor : Colors.white12),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Bottom Half: Code Input Area
          Expanded(
            flex: 1,
            child: Container(
              color: bgColor,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Commands (Pseudo-code):",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        itemCount: commands.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              commands[index],
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.close, color: Colors.redAccent),
                              onPressed: () {
                                setState(() {
                                  commands.removeAt(index);
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      DropdownButton<String>(
                        dropdownColor: mapColor,
                        value: null,
                        hint: Text(
                          "Add Command",
                          style: TextStyle(color: Colors.white),
                        ),
                        items: ["robot.MOVEUP", "robot.MOVEDOWN", "robot.MOVELEFT", "robot.MOVERIGHT"]
                            .map((String command) {
                          return DropdownMenuItem<String>(
                            value: command,
                            child: Text(
                              command,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              commands.add('$value(1)'); // Default to 1 step for simplicity
                            });
                          }
                        },
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: robotColor,
                        ),
                        onPressed: executeCommands,
                        child: Text("Run"),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Display collected coins
                  Text(
                    "Coins Collected: $collectedCoins",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
