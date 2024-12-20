import 'package:flutter/material.dart';
import 'pixel_adventure.dart';
import 'components/player.dart';

double collectedF=0;

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
  String _selectedCondition = 'if (collected apple)';
  String _selectedAction = 'Player.activate(shield)';

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
  final List<String> _conditionOptions = [
    'if (collected apple)',
    'if (player health < 50)',
    'if (time remaining < 10)',
  ];

  final List<String> _actionOptions = [
    'Player.activate(shield)',
    'Player.gainHealth(10)',
    'Player.increaseSpeed(2)',
  ];

  void _handleCommand(String command) {
    if (command == 'Player.moveRight(1)') {
      isMoveRequested = 2;
    } else if (command == 'Player.moveRight(2)') {
      isMoveRequested = 20;
    } else if (command == 'Player.moveRight(3)') {
      isMoveRequested = 30;
    } else if (command == 'Player.moveRight(4)') {
      isMoveRequested = 40;
    } else if (command == 'Player.moveLeft(1)') {
      isMoveRequested = 0;
    } else if (command == 'Player.moveLeft(2)') {
      isMoveRequested = 50;
    } else if (command == 'Player.moveLeft(3)') {
      isMoveRequested = 60;
    } else if (command == 'Player.moveLeft(4)') {
      isMoveRequested = 70;
    } else if (command == 'Player.jumpRight(1)') {
      isMoveRequested = 3;
    } else if (command == 'Player.jumpRight(2)') {
      isMoveRequested = 80;
    } else if (command == 'Player.jumpRight(3)') {
      isMoveRequested = 90;
    } else if (command == 'Player.jumpRight(4)') {
      isMoveRequested = 100;
    } else if (command == 'Player.jumpLeft(1)') {
      isMoveRequested = 4;
    } else if (command == 'Player.jumpLeft(2)') {
      isMoveRequested = 110;
    } else if (command == 'Player.jumpLeft(3)') {
      isMoveRequested = 120;
    } else if (command == 'Player.jumpLeft(4)') {
      isMoveRequested = 130;
    } else if (command == 'Player.jump()') {
      isMoveRequested = 5;
    }
    _checkConditionsAndActions(command);
  }
  //if and action logic
  void _checkConditionsAndActions(String command) {
    if (command.contains('if (collected apple)') && command.contains('Player.activate(shield)')) {
      collectedF = 1;
      print('Condition: collected apple | Action: activate shield');
    } else if (command.contains('if (collected apple)') && command.contains('Player.gainHealth(10)')) {
      print('Condition: collected apple | Action: gain health');
    } else if (command.contains('if (collected apple)') && command.contains('Player.increaseSpeed(2)')) {
      print('Condition: collected apple | Action: increase speed');
    } else if (command.contains('if (player health < 50)') && command.contains('Player.activate(shield)')) {
      print('Condition: player health < 50 | Action: activate shield');
    } else if (command.contains('if (player health < 50)') && command.contains('Player.gainHealth(10)')) {
      print('Condition: player health < 50 | Action: gain health');
    } else if (command.contains('if (player health < 50)') && command.contains('Player.increaseSpeed(2)')) {
      print('Condition: player health < 50 | Action: increase speed');
    } else if (command.contains('if (time remaining < 10)') && command.contains('Player.activate(shield)')) {
      print('Condition: time remaining < 10 | Action: activate shield');
    } else if (command.contains('if (time remaining < 10)') && command.contains('Player.gainHealth(10)')) {
      print('Condition: time remaining < 10 | Action: gain health');
    } else if (command.contains('if (time remaining < 10)') && command.contains('Player.increaseSpeed(2)')) {
      print('Condition: time remaining < 10 | Action: increase speed');
    }
  }

  void _runCommand() {
    setState(() {
      // Execute the latest command only
      if (_commandsInCodeSpace.isNotEmpty) {
        String latestCommand = _commandsInCodeSpace.last;
        _handleCommand(latestCommand);  // Execute the latest command
        print('Running command: $latestCommand');
        // Clear the commands after running
        _commandsInCodeSpace.clear();
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          color: Colors.black.withOpacity(0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _buildDropdown('Move Right', _selectedMoveRight, _moveRightOptions, (newValue) {
                    setState(() {
                      _selectedMoveRight = newValue!;
                      _commandsInCodeSpace = [_selectedMoveRight];  // Update to only include the latest selection
                    });
                  }),
                  _buildDropdown('Move Left', _selectedMoveLeft, _moveLeftOptions, (newValue) {
                    setState(() {
                      _selectedMoveLeft = newValue!;
                      _commandsInCodeSpace = [_selectedMoveLeft];  // Update to only include the latest selection
                    });
                  }),
                  _buildDropdown('Jump Right', _selectedJumpRight, _jumpRightOptions, (newValue) {
                    setState(() {
                      _selectedJumpRight = newValue!;
                      _commandsInCodeSpace = [_selectedJumpRight];  // Update to only include the latest selection
                    });
                  }),
                  _buildDropdown('Jump Left', _selectedJumpLeft, _jumpLeftOptions, (newValue) {
                    setState(() {
                      _selectedJumpLeft = newValue!;
                      _commandsInCodeSpace = [_selectedJumpLeft];  // Update to only include the latest selection
                    });
                  }),
                  _buildDropdown('Jump', _selectedJump, _jumpOptions, (newValue) {
                    setState(() {
                      _selectedJump = newValue!;
                      _commandsInCodeSpace = [_selectedJump];  // Update to only include the latest selection
                    });
                  }),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Create a Condition:',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _buildDropdown('Condition', _selectedCondition, _conditionOptions, (newValue) {
                    setState(() {
                      _selectedCondition = newValue!;
                    });
                  }),
                  _buildDropdown('Action', _selectedAction, _actionOptions, (newValue) {
                    setState(() {
                      _selectedAction = newValue!;
                      String conditionalCommand = '$_selectedCondition { $_selectedAction; }';
                      _commandsInCodeSpace = [conditionalCommand];  // Update to only include the latest selection
                    });
                  }),
                ],
              ),
              SizedBox(height: 8),
              Container(
                height: 60,
                child: SingleChildScrollView(
                  child: Column(
                    children: _commandsInCodeSpace
                        .map(
                          (command) => Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            color: Colors.white,
                            child: Text(
                              command,
                              style: TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.white, size: 16),
                            onPressed: () => _cancelCommand(command),
                          ),
                        ],
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 16, // Space between buttons
                children: [
                  ElevatedButton(
                    onPressed: _runCommand,
                    child: Text('Run', style: TextStyle(color: Colors.black, fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent, // Neon green color
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String label, String selectedValue, List<String> options, ValueChanged<String?> onChanged) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          DropdownButton<String>(
            value: selectedValue,
            items: options
                .map((option) => DropdownMenuItem<String>(
              value: option,
              child: Text(option, style: TextStyle(color: Colors.white, fontSize: 12)),
            ))
                .toList(),
            onChanged: onChanged,
            dropdownColor: Colors.black,
            iconEnabledColor: Colors.white,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
