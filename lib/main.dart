import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:game_pandabyte/pixel_adventure.dart';
import 'package:flame/flame.dart';
import 'menu_overlay.dart';
import 'components/player.dart'; // Import the player component

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  // Flame.device.setLandscape(); // Uncomment if you want landscape mode when playing

  PixelAdventure game = PixelAdventure();
  Player player = Player(character: 'Pink Man', position: Vector2(0, 0)); // Initialize Player

  runApp(MaterialApp(
    home: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GameWidget(game: kDebugMode ? PixelAdventure() : game),
          MenuOverlay(game: game, player: player), // Pass both game and player to the MenuOverlay
        ],
      ),
    ),
  ));
}
