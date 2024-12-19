import 'package:flame/components.dart';
import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_pandabyte/components/background_tile.dart';
import 'package:game_pandabyte/components/collision_block.dart';
import 'package:game_pandabyte/components/fruit.dart';
import 'package:game_pandabyte/components/player.dart';
import 'package:game_pandabyte/pixel_adventure.dart';

class Level extends World with HasGameRef<PixelAdventure>{
  final String levelName;
  Level({required this.levelName});
  late TiledComponent level;
  List<CollisionBlock> collissionBlocks = [];
  late Player player; // Declare player at the class level

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));
    add(level);

    _scrollingBackground();
    _spawningObjects();
    _addCollisions();





    return super.onLoad();
  }

  void _scrollingBackground() {
    final backgroundLayer = level.tileMap.getLayer('Background');
    const tileSize = 64;
    final numTilesY = (game.size.y / tileSize).floor();
    final numTilesX = (game.size.x / tileSize).floor();

    if (backgroundLayer != null) {
      final backgroundColor =
          backgroundLayer.properties.getValue('BackgroundColor');

      for(double y = 0; y < (game.size.y / numTilesY); y++){
        for (double x = 0; x < numTilesX; x++) {
          final backgroundTile = BackgroundTile(
            color: backgroundColor ?? 'Gray',
            position: Vector2(x * tileSize, y * tileSize - tileSize - tileSize),
          );
          add(backgroundTile);
        }
      }
    }
  }

  void _spawningObjects() {
    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointLayer != null) {
      for (final spawnPoint in spawnPointLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player = Player(
              character: 'Pink Man',
              position: Vector2(spawnPoint.x, spawnPoint.y),
            );
            add(player);
            break;
          case 'Fruit':
            final fruit = Fruit(
              fruit: spawnPoint.name,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(fruit);
          default:
        }
      }
    }
  }

  void _addCollisions() {
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        switch (collision.class_) {
          case 'Platform':
            final platform = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              isPlatform: true,
            );
            collissionBlocks.add(platform);
            add(platform);
            break;
          default:
            final block = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            collissionBlocks.add(block);
            add(block);
        }
      }
    }
// Now player is accessible, so we can assign collision blocks
    player.collisionBlocks = collissionBlocks;
  }

}
