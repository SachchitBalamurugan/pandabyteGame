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
  String _selectedMoveRight = 'Player.moveRight(1)';
  String _selectedMoveLeft = 'Player.moveLeft(1)';
  String _selectedJumpRight = 'Player.jumpRight(1)';
  String _selectedJumpLeft = 'Player.jumpLeft(1)';
  String _selectedJump = 'Player.jump()';

  final List<String> _moveRightOptions = [
    'Player.moveRight(1)',
    'Player.moveRight(2)',
    'Player.moveRight(3)',
    'Player.moveRight(4)',
  ];
  final List<String> _moveLeftOptions = [
    'Player.moveLeft(1)',
    'Player.moveLeft(2)',
    'Player.moveLeft(3)',
    'Player.moveLeft(4)',
  ];
  final List<String> _jumpRightOptions = [
    'Player.jumpRight(1)',
    'Player.jumpRight(2)',
    'Player.jumpRight(3)',
    'Player.jumpRight(4)',
  ];
  final List<String> _jumpLeftOptions = [
    'Player.jumpLeft(1)',
    'Player.jumpLeft(2)',
    'Player.jumpLeft(3)',
    'Player.jumpLeft(4)',
  ];
  final List<String> _jumpOptions = [
    'Player.jump()',
  ];

  List<String> _commandsInCodeSpace = [];

  void _handleCommand(String command) {
    if (command == 'Player.moveRight(1)') {
      isMoveRequested = 2;
    } else if (command == 'Player.moveRight(2)') {
      isMoveRequested = 20;

    }
    else if (command == 'Player.moveRight(3)'){
      isMoveRequested=30;
    }
    else if (command == 'Player.moveRight(4)'){
      isMoveRequested=40;
    } else
    if (command == 'Player.moveLeft(1)') {
      isMoveRequested = 0;
    } else if (command == 'Player.moveLeft(2)') {
      isMoveRequested = 50;
    } else if (command == 'Player.moveLeft(3)') {
      isMoveRequested = 60;
    } else if (command == 'Player.moveLeft(4)') {
      isMoveRequested = 70;
    } else
    if (command == 'Player.jumpRight(1)') {
      isMoveRequested = 3;
    } else if (command == 'Player.jumpRight(2)') {
      isMoveRequested = 80;
    } else if (command == 'Player.jumpRight(3)') {
      isMoveRequested = 90;
    }else if (command == 'Player.jumpRight(4)') {
      isMoveRequested = 100;
    }
    else
    if (command == 'Player.jumpLeft(1)') {
      isMoveRequested = 4;
    } else if (command == 'Player.jumpLeft(2)') {
      isMoveRequested = 110;
    } else if (command == 'Player.jumpLeft(3)') {
      isMoveRequested = 120;
    } else if (command == 'Player.jumpLeft(4)') {
      isMoveRequested = 130;
    }
    else if (command == 'Player.jump()') {
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

    if (command.startsWith('Player.moveLeft') ||
        command.startsWith('Player.moveRight')) {
      isMoveRequested = 1;
      widget.player.stopMovement();
    }
  }

  void _completeAndNavigate() {
    _runCommand();
    setState(() {});
    Navigator.pop(context);
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
              // Wrap dropdowns in a Row with wrap behavior
              Wrap(
                spacing: 10, // Spacing between dropdowns
                runSpacing: 10, // Spacing between lines when wrapping
                children: [
                  // Move Right Dropdown with label
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Move Right',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        DropdownButton<String>(
                          value: _selectedMoveRight,
                          items: _moveRightOptions
                              .map((String option) =>
                              DropdownMenuItem<String>(
                                value: option,
                                child: Text(option,
                                    style: TextStyle(color: Colors.white)),
                              ))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedMoveRight = newValue!;
                              _commandsInCodeSpace.add(_selectedMoveRight);
                              _handleCommand(_selectedMoveRight);
                            });
                          },
                          dropdownColor: Colors.black,
                          iconEnabledColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Move Left Dropdown with label
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Move Left',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        DropdownButton<String>(
                          value: _selectedMoveLeft,
                          items: _moveLeftOptions
                              .map((String option) =>
                              DropdownMenuItem<String>(
                                value: option,
                                child: Text(option,
                                    style: TextStyle(color: Colors.white)),
                              ))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedMoveLeft = newValue!;
                              _commandsInCodeSpace.add(_selectedMoveLeft);
                              _handleCommand(_selectedMoveLeft);
                            });
                          },
                          dropdownColor: Colors.black,
                          iconEnabledColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Jump Right Dropdown with label
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jump Right',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        DropdownButton<String>(
                          value: _selectedJumpRight,
                          items: _jumpRightOptions
                              .map((String option) =>
                              DropdownMenuItem<String>(
                                value: option,
                                child: Text(option,
                                    style: TextStyle(color: Colors.white)),
                              ))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedJumpRight = newValue!;
                              _commandsInCodeSpace.add(_selectedJumpRight);
                              _handleCommand(_selectedJumpRight);
                            });
                          },
                          dropdownColor: Colors.black,
                          iconEnabledColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Jump Left Dropdown with label
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jump Left',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        DropdownButton<String>(
                          value: _selectedJumpLeft,
                          items: _jumpLeftOptions
                              .map((String option) =>
                              DropdownMenuItem<String>(
                                value: option,
                                child: Text(option,
                                    style: TextStyle(color: Colors.white)),
                              ))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedJumpLeft = newValue!;
                              _commandsInCodeSpace.add(_selectedJumpLeft);
                              _handleCommand(_selectedJumpLeft);
                            });
                          },
                          dropdownColor: Colors.black,
                          iconEnabledColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Jump Dropdown with label
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jump',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        DropdownButton<String>(
                          value: _selectedJump,
                          items: _jumpOptions
                              .map((String option) =>
                              DropdownMenuItem<String>(
                                value: option,
                                child: Text(option,
                                    style: TextStyle(color: Colors.white)),
                              ))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedJump = newValue!;
                              _commandsInCodeSpace.add(_selectedJump);
                              _handleCommand(_selectedJump);
                            });
                          },
                          dropdownColor: Colors.black,
                          iconEnabledColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 70, // Fixed height for the scrollable section
                child: SingleChildScrollView(
                  child: Column(
                    children: _commandsInCodeSpace
                        .map(
                          (command) =>
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
                    )
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _completeAndNavigate,
                child: Text('Done', style: TextStyle(color: Colors.black)),
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