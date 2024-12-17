import 'dart:ui';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart'; // Import Flutter's Material package
import 'dart:async';
import 'components/level.dart';

class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;

  final world = Level(levelName: 'Level_01'); // change the level here

  String selectedCommand = 'Player.jumpRight(1)'; // Default command for the dropdown
  String commandHistory = ''; // To store the history of selected commands

  @override
  FutureOr<void> onLoad() async {
    // loads images in cache
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(world: world, width: 390, height: 844);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, world]);
    return super.onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The Flame Game Widget for rendering the game
          GameWidget(game: this),

          // UI Elements to display the dropdown and submit button
          Positioned(
            bottom: 20,
            left: 50,
            child: DropdownButton<String>(
              value: selectedCommand,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedCommand = newValue;
                  // Update the command history text when the selection changes
                  commandHistory = 'Selected: $selectedCommand';
                }
              },
              items: <String>[
                'Player.jumpRight(1)',
                'Player.moveRight(1)',
                'Player.jumpLeft(1)',
                'Player.moveLeft(1)',
                // Add more commands here as needed
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),

          // Display the selected command and a submit button
          Positioned(
            bottom: 100,
            left: 50,
            child: Column(
              children: [
                // Show the selected command history
                Text(
                  commandHistory,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),

                // Submit button to execute the selected command
                ElevatedButton(
                  onPressed: () {
                    executeCommand(selectedCommand);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to execute the selected command
  void executeCommand(String command) {
    // You can implement logic to execute the code here
    if (command == 'Player.jumpRight(1)') {
      // Call jumpRight method on Player
      print('Jumping right by 1 unit');
    } else if (command == 'Player.moveRight(1)') {
      // Call moveRight method on Player
      print('Moving right by 1 unit');
    } else if (command == 'Player.jumpLeft(1)') {
      // Call jumpLeft method on Player
      print('Jumping left by 1 unit');
    } else if (command == 'Player.moveLeft(1)') {
      // Call moveLeft method on Player
      print('Moving left by 1 unit');
    }
  }
}
