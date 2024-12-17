import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:game_pandabyte/components/collision_block.dart';
import 'package:game_pandabyte/components/player_hitbox.dart';
import 'package:game_pandabyte/components/utils.dart';
import 'dart:async';

import 'package:game_pandabyte/pixel_adventure.dart';
double isMoveRequested = 1;
enum PlayerState { idle, running, jumping, falling }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  String character;
  Player({position, required this.character}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;
  late final SpriteAnimation fallingAnimation;
  final double stepTime = 0.05;

  final double _gravity = 9.8;
  final double _jumpForce = 280; // change jump height
  final double _terminalVelocity = 300;
  double horizontalMovement = 0;

  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  bool hasJumped = false;
  List<CollisionBlock> collisionBlocks = [];
  PlayerHitbox hitbox = PlayerHitbox(
      offsetX: 10,
      offsetY: 4,
      width: 14,
      height: 28
  );

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    add(RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height)
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // Wait until isMoveRequested is true to proceed with movement logic
    if (isMoveRequested == 0) {
      // Move left by 1 step
      moveLeft(1);
      isMoveRequested = 1;  // Stop further movement until triggered again
    } else if (isMoveRequested == 2) {
      // Move right by 1 step
      moveRight(1);
      isMoveRequested = 1;  // Stop further movement until triggered again
    }


    // Continue updating other player states and logic
    _updatePlayerState();
    _updatePlayerMovement(dt);
    _checkHorizontalCollisions();
    _applyGravity(dt);
    _checkVerticalCollisions();

    super.update(dt);  // Call the superclass's update method
  }


  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA)
        || keysPressed.contains(LogicalKeyboardKey.arrowLeft);

    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD)
        || keysPressed.contains(LogicalKeyboardKey.arrowRight);

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;


    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);
    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);
    jumpingAnimation = _spriteAnimation('Jump', 1);
    fallingAnimation = _spriteAnimation('Fall', 1);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.falling: fallingAnimation
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
    velocity.y = -_jumpForce;
    position.y += velocity.y * dt;
    isOnGround = false;
    hasJumped = false;
  }

  //test remove if needed:
  // Make sure moveLeft and moveRight are properly handled
  void moveLeft(double distance) {


    horizontalMovement = -distance; // Move left

    print('moveLeft called with distance: $distance'); // Print statement for testing
    print(isMoveRequested);
  }

  void moveRight(double distance) {
    horizontalMovement = distance; // Move right
    Future.delayed(Duration(milliseconds: 300), () {
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
}
