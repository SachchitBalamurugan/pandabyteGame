import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:game_pandabyte/pixel_adventure.dart';
import 'package:flame/flame.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  // Flame.device.setLandscape(); do it if I want landscape mode when playing

  PixelAdventure game = PixelAdventure();
  runApp(GameWidget(game: kDebugMode ? PixelAdventure() : game)); // when publishing change this to just game  runApp(GameWidget(game: game)

}
