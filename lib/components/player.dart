import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:game_pandabyte/components/collision_block.dart';
import 'package:game_pandabyte/components/custom_hitbox.dart';
import 'package:game_pandabyte/components/utils.dart';
import 'package:game_pandabyte/menu_overlay.dart';
import 'dart:async';

import 'package:game_pandabyte/pixel_adventure.dart';

import 'fruit.dart';
import 'saw.dart';
double isMoveRequested = 1;
double amountMoveRight = 1;
double amountMoveLeft = 1;
double amountMoveUpRight = 1;
double amountMoveUpLeft = 1;

enum PlayerState { idle, running, jumping, falling, hit, appearing }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler, CollisionCallbacks{
  String character;
  Player({position, required this.character}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;
  late final SpriteAnimation fallingAnimation;
  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation appearingAnimation;

  final double stepTime = 0.05;

  final double _gravity = 9.8;
  final double _jumpForce = 150; // change jump height
  final double _terminalVelocity = 300;
  double horizontalMovement = 0;

  double moveSpeed = 100;
  Vector2 startingPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  bool hasJumped = false;
  bool gotHit = false;
  List<CollisionBlock> collisionBlocks = [];
  CustomHitbox hitbox = CustomHitbox(
      offsetX: 10,
      offsetY: 4,
      width: 14,
      height: 28
  );

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();

    startingPosition = Vector2(position.x, position.y);
    add(RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height)
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if(collectedF ==1){
      final neonGreenColor = Color(0x8000FF00); // Neon green with 50% transparency (alpha 0x80)
      this.paint = Paint()
        ..colorFilter = ColorFilter.mode(neonGreenColor, BlendMode.overlay);
    }
    // Wait until isMoveRequested is true to proceed with movement logic
    if (isMoveRequested == 0) {
      // Move left by 1 step
      moveLeft(amountMoveLeft);
      isMoveRequested = 1;  // Stop further movement until triggered again
    } else if (isMoveRequested == 2) {
      // Move right by 1 step
      moveRight(amountMoveRight);
      isMoveRequested = 1;  // Stop further movement until triggered again

      } else if (isMoveRequested == 20) {
      // Move right by 1 step
      print('worked');
      moveRight2(1);
      isMoveRequested = 1;  // Stop further movement until triggered again

    }
    else if (isMoveRequested == 30) {
      // Move right by 1 step
      print('worked');
      moveRight3(1);
      isMoveRequested = 1;  // Stop further movement until triggered again

    }
    else if (isMoveRequested == 40) {
      // Move right by 1 step
      print('worked');
      moveRight4(1);
      isMoveRequested = 1;  // Stop further movement until triggered again

    }
    else if (isMoveRequested == 50) {
      // Move right by 1 step
      print('worked');
      moveLeft2(1);
      isMoveRequested = 1;  // Stop further movement until triggered again

    }
    else if (isMoveRequested == 60) {
      // Move right by 1 step
      print('worked');
      moveLeft3(1);
      isMoveRequested = 1;  // Stop further movement until triggered again

    }
    else if (isMoveRequested == 70) {
      // Move right by 1 step
      print('worked');
      moveLeft4(1);
      isMoveRequested = 1;  // Stop further movement until triggered again

    }

    else if (isMoveRequested == 3) {
      // Move right by 1 step
      // moveRight(1);
      // isMoveRequested = 1;  // Stop further movement until triggered again
      if (isOnGround) {
        _playerJump(dt); // Trigger the jump
        moveRight(amountMoveUpRight);
      }
    }
    else if (isMoveRequested == 80) {
      // Move right by 1 step
      // moveRight(1);
      print('WOrked');
      // isMoveRequested = 1;  // Stop further movement until triggered again
      if (isOnGround) {
        _playerJump(dt); // Trigger the jump
        moveRight2(amountMoveUpRight);
      }
    }
    else if (isMoveRequested == 90) {
      // Move right by 1 step
      // moveRight(1);
      print('WOrked');
      // isMoveRequested = 1;  // Stop further movement until triggered again
      if (isOnGround) {
        _playerJump(dt); // Trigger the jump
        moveRight3(amountMoveUpRight);
      }
    }
    else if (isMoveRequested == 100) {
      // Move right by 1 step
      // moveRight(1);
      print('WOrked');
      // isMoveRequested = 1;  // Stop further movement until triggered again
      if (isOnGround) {
        _playerJump(dt); // Trigger the jump
        moveRight4(amountMoveUpRight);
      }
    }


    else if (isMoveRequested == 4) {
          // Move right by 1 step
          // moveRight(1);
          // isMoveRequested = 1;  // Stop further movement until triggered again
          if (isOnGround) {
            _playerJump(dt);  // Trigger the jump
            moveLeft(amountMoveUpLeft);
          }
    } else if (isMoveRequested == 110) {
      // Move right by 1 step
      // moveRight(1);
      // isMoveRequested = 1;  // Stop further movement until triggered again
      if (isOnGround) {
        _playerJump(dt); // Trigger the jump
        moveLeft2(amountMoveUpLeft);
      }
    }
    else if (isMoveRequested == 120) {
      // Move right by 1 step
      // moveRight(1);
      // isMoveRequested = 1;  // Stop further movement until triggered again
      if (isOnGround) {
        _playerJump(dt); // Trigger the jump
        moveLeft3(amountMoveUpLeft);
      }
    }
    else if (isMoveRequested == 130) {
      // Move right by 1 step
      // moveRight(1);
      // isMoveRequested = 1;  // Stop further movement until triggered again
      if (isOnGround) {
        _playerJump(dt); // Trigger the jump
        moveLeft4(amountMoveUpLeft);
      }
    }
    else if (isMoveRequested == 5) {
      // Move right by 1 step
      // moveRight(1);
      // isMoveRequested = 1;  // Stop further movement until triggered again
      if (isOnGround) {
        _playerJump(dt);  // Trigger the jump


      }
    }

    if(!gotHit){
      // Continue updating other player states and logic
      _updatePlayerState();
      _updatePlayerMovement(dt);
      _checkHorizontalCollisions();
      _applyGravity(dt);
      _checkVerticalCollisions();
    }


    super.update(dt);  // Call the superclass's update method
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Fruit) other.collidingWithPlayer();
    if (other is Saw) _respawn();
    super.onCollision(intersectionPoints, other);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);
    jumpingAnimation = _spriteAnimation('Jump', 1);
    fallingAnimation = _spriteAnimation('Fall', 1);
    hitAnimation = _spriteAnimation('Hit', 7);
    appearingAnimation = _specialSpriteAnimation('Appearing', 7);




    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.falling: fallingAnimation,
      PlayerState.hit: hitAnimation,
      PlayerState.appearing: appearingAnimation

    };

    // Set current animation
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(game.images.fromCache('Main Characters/$character/$state (32x32).png'),
        SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
        )
    );
  }

  SpriteAnimation _specialSpriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(game.images.fromCache('Main Characters/$state (96x96).png'),
        SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: stepTime,
          textureSize: Vector2.all(96),
        )
    );
  }


  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }
    // Check if moving, set to running
    if (velocity.x > 0 || velocity.x < 0) playerState = PlayerState.running;
    // Check if falling, set to falling
    if (velocity.y > 0) playerState = PlayerState.falling;
    // Check if jumping, set to jumping
    if (velocity.y < 0) playerState = PlayerState.jumping;
    current = playerState;
  }

  void _updatePlayerMovement(double dt) {
    if (hasJumped && isOnGround) _playerJump(dt);
    if (velocity.y > _gravity) isOnGround = false;
    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _playerJump(double dt) {
    if (isMoveRequested == 3 || isMoveRequested == 4 || isMoveRequested == 5 || isMoveRequested == 80 || isMoveRequested == 90 || isMoveRequested == 100 || isMoveRequested == 110 || isMoveRequested == 120 || isMoveRequested == 130) {
      velocity.y = -_jumpForce;
      position.y += velocity.y * dt;
      isOnGround = false;
      hasJumped = false;

    }
    isMoveRequested = 1;
  }

  //test remove if needed:
  // Make sure moveLeft and moveRight are properly handled
  void moveLeft(double distance) {


    horizontalMovement = -distance; // Move left
    Future.delayed(Duration(milliseconds: 300), () {
      stopMovement(); // Stop the movement after 1 second
    });
    print('moveLeft called with distance: $distance'); // Print statement for testing
    print(isMoveRequested);
  }

  void moveLeft2(double distance) {


    horizontalMovement = -distance; // Move left
    Future.delayed(Duration(milliseconds: 600), () {
      stopMovement(); // Stop the movement after 1 second
    });
    print('moveLeft called with distance: $distance'); // Print statement for testing
    print(isMoveRequested);
  }
  void moveLeft3(double distance) {


    horizontalMovement = -distance; // Move left
    Future.delayed(Duration(milliseconds: 900), () {
      stopMovement(); // Stop the movement after 1 second
    });
    print('moveLeft called with distance: $distance'); // Print statement for testing
    print(isMoveRequested);
  }

  void moveLeft4(double distance) {


    horizontalMovement = -distance; // Move left
    Future.delayed(Duration(milliseconds: 1200), () {
      stopMovement(); // Stop the movement after 1 second
    });
    print('moveLeft called with distance: $distance'); // Print statement for testing
    print(isMoveRequested);
  }

  void moveRight(double distance) {
    horizontalMovement = distance; // Move right
    Future.delayed(Duration(milliseconds: 300), () {
      stopMovement(); // Stop the movement after 1 second
    });
  }

  void moveRight2(double distance) {
    horizontalMovement = distance; // Move right
    Future.delayed(Duration(milliseconds: 600), () {
      stopMovement(); // Stop the movement after 1 second
    });
  }
  void moveRight3(double distance) {
    horizontalMovement = distance; // Move right
    Future.delayed(Duration(milliseconds: 900), () {
      stopMovement(); // Stop the movement after 1 second
    });
  }
  void moveRight4(double distance) {
    horizontalMovement = distance; // Move right
    Future.delayed(Duration(milliseconds: 1200), () {
      stopMovement(); // Stop the movement after 1 second
    });
  }

  void stopMovement() {
    horizontalMovement = 0; // Stop horizontal movement
    print('Movement stopped');
  }



  void _checkHorizontalCollisions() {
    for (final block in collisionBlocks) {
      // Handle collision
      if (!block.isPlatform) {
        if (checkCollision(this, block)) {
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = block.x - hitbox.offsetX - hitbox.width;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width + hitbox.width + hitbox.offsetX;
            break;
          }
        }
      }
    }
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _checkVerticalCollisions() {
    for (final block in collisionBlocks) {
      if (block.isPlatform) {
        // Handle platforms
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
        }
      } else {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y + block.height - hitbox.offsetY;
          }
        }
      }
    }
  }

  void _respawn() {
    if (shield != 1) {
      const hitDuration = Duration(milliseconds: 350);
      const appearingDuration = Duration(milliseconds: 350);
      const canMoveDuration = Duration(milliseconds: 400);
      gotHit = true;
      current = PlayerState.hit;
      Future.delayed(hitDuration, () {
        scale.x = 1;
        position = startingPosition - Vector2.all(32);
        current = PlayerState.appearing;
        Future.delayed(appearingDuration, () {
          velocity = Vector2.zero();
          position = startingPosition;
          _updatePlayerState();
          Future.delayed(canMoveDuration, () => gotHit = false);
        });
      });
      //position = startingPosition;
    } else {
      final neonGreenColor = Color(0x8000FF00); // Neon green with 50% transparency (alpha 0x80)
      this.paint = Paint()
        ..colorFilter = ColorFilter.mode(neonGreenColor, BlendMode.overlay);
    }
  }
}
