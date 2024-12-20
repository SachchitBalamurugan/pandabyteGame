import 'dart:async';
import 'package:game_pandabyte/menu_overlay.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_pandabyte/components/custom_hitbox.dart';
import 'package:game_pandabyte/menu_overlay.dart';
import 'package:game_pandabyte/pixel_adventure.dart';
import 'package:game_pandabyte/screens/Course.dart';
double shield = 0;
class Fruit extends SpriteAnimationComponent with HasGameRef<PixelAdventure>, CollisionCallbacks{
  final String fruit;
  Fruit({
    this.fruit = 'Apple',
    position,
    size,
}) : super(
    position: position,
    size: size
  );

  bool _collected = false;
  bool hasPrinted = false;

  final double stepTime = 0.05;
  final hitbox = CustomHitbox(
      offsetX: 10,
      offsetY: 10,
      width: 12,
      height: 12
  );

  @override
  FutureOr<void> onLoad(){
    //debugMode = true;
    priority = priorityFruit;

    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
      collisionType: CollisionType.passive
    ));
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/$fruit.png'),
        SpriteAnimationData.sequenced(
            amount: 17,
            stepTime: stepTime,
            textureSize: Vector2.all(32)
        ));
    return super.onLoad();
  }

  void collidingWithPlayer() {
    if(!_collected) {
      if (collectedF ==1){
        shield = 1;
        collectedF=0;
      }

      animation = SpriteAnimation.fromFrameData(
          game.images.fromCache('Items/Fruits/Collected.png'),
          SpriteAnimationData.sequenced(
              amount: 6,
              stepTime: stepTime,
              textureSize: Vector2.all(32),
            loop: false
          ));
      _collected = true;
    }
    Future.delayed(
      const Duration(milliseconds: 400),
          () {
        if (!hasPrinted) {
          print('done');
          // implement the scoring logic here
          hasPrinted = true;
        }
        removeFromParent();
      },
    );


    //removeFromParent();
  }

}