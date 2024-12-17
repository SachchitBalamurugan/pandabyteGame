import 'package:flame/components.dart';
import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_pandabyte/components/player.dart';

class Level extends World {
  final String levelName;
  Level({required this.levelName});
  late TiledComponent level;
  @override
  FutureOr<void> onLoad() async{
    // TODO: implement onLoad
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));
    add(level);
    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    for(final spawnPoint in spawnPointLayer!.objects) {
      switch (spawnPoint.class_){
        case 'Player':
          final player = Player(character: 'Pink Man', position: Vector2(spawnPoint.x, spawnPoint.y));
          add(player);
          break;
        default:
      }
    }
    // add(Player(character: 'Pink Man')); // change character
    return super.onLoad();
  }
}