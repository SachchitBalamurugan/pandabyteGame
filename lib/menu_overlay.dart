import 'package:flutter/material.dart';
import 'pixel_adventure.dart';
import 'components/player.dart';

class MenuOverlay extends StatefulWidget {
  const MenuOverlay({
    Key? key,
    required this.game,
    required this.player,
  }) : super(key: key);


  final PixelAdventure game;
  final Player player;

  @override
  _MenuOverlayState createState() => _MenuOverlayState();
}

class _MenuOverlayState extends State<MenuOverlay> {
  // Global flag to track movement state


  String _selectedOption = 'Player.moveRight(1)';
  final List<String> _options = [
    'Player.moveRight(1)',
    'Player.moveLeft(1)',
    'Player.jumpRight(1)',
    'Player.jumpLeft(1)',
    'Player.jump()',
  ];

  List<String> _commandsInCodeSpace = [];

  void _handleCommand(String command) {
    if (command == 'Player.moveRight(1)') {
      // Set global flag to true
      isMoveRequested = 2;

      widget.player.moveRight(1);
    } else if (command == 'Player.moveLeft(1)') {
      // Set global flag to true
      isMoveRequested = 0;
      // } else if (command == 'Player.jumpRight(1)') {
      //   widget.player.jumpRight(1);
      // } else if (command == 'Player.jumpLeft(1)') {
      //   widget.player.jumpLeft(1);
      // } else if (command == 'Player.attack()') {
      //   widget.player.attack();
      // }
    } else if (command == 'Player.jumpRight(1)') {
      isMoveRequested = 3;
    } else if (command == 'Player.jumpLeft(1)') {
      isMoveRequested = 4;
    } else if (command == 'Player.jump()') {
      isMoveRequested = 5;
    }
  }

  void _runCommand() {
    for (var command in _commandsInCodeSpace) {
      _handleCommand(command);
    }
    print('Running: $_commandsInCodeSpace');
  }

  void _cancelCommand(String command) {
    setState(() {
      _commandsInCodeSpace.remove(command);
    });

    if (command == 'Player.moveLeft(1)' || command == 'Player.moveRight(1)') {
      isMoveRequested = 1;
      widget.player.stopMovement();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.black.withOpacity(0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: _selectedOption,
                items: _options
                    .map((String option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: TextStyle(color: Colors.white),
                  ),
                ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue!;
                    _commandsInCodeSpace.add(_selectedOption);
                    _handleCommand(_selectedOption);
                  });
                },
                dropdownColor: Colors.black,
                iconEnabledColor: Colors.white,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              for (var command in _commandsInCodeSpace)
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Text(
                        command,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => _cancelCommand(command),
                    ),
                  ],
                ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _runCommand,
                child: Text('Run', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
