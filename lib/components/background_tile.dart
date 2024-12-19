import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_pandabyte/pixel_adventure.dart';
class BackgroundTile extends SpriteComponent with HasGameRef<PixelAdventure>{
  final String color;
  BackgroundTile({
    this.color = 'Gray',
    position,
  }) : super(
    position: position,
  );
  // adjust speed
  final double scrollSpeed = 0.9;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    size = Vector2.all(64.6);
    sprite = Sprite(game.images.fromCache('Background/$color.png'));
    // parallax = await gameRef.loadParallax(
    //   [ParallaxImageData('Background/$color.png')],
    //   baseVelocity: Vector2(0, -scrollSpeed),
    //   repeat: ImageRepeat.repeat,
    //   fill: LayerFill.none,
    // );
    return super.onLoad();
  }
  @override
  void update(double dt){
    position.y += scrollSpeed;
    double tileSize = 64;
    int scrollHeight = (game.size.y / tileSize).floor();
    if(position.y > scrollHeight * tileSize) position.y = -tileSize;
    super.update(dt);
  }
}