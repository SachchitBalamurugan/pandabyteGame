import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'dart:async';
import 'components/level.dart';
class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents{
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;

  final world = Level(levelName: 'Level_01'); //change the level here
  @override
  FutureOr<void> onLoad() async{
    // loads images in cache
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(world: world, width: 390, height: 844);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, world]);
    return super.onLoad();
  }
}