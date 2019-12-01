import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:mazeball/Elements/ball.dart';
import 'package:mazeball/Elements/wall.dart';
import 'package:mazeball/helper.dart';

class MazeBallGame extends Game {
  //Needed for Box2D
  static const int WORLD_POOL_SIZE = 100;
  static const int WORLD_POOL_CONTAINER_SIZE = 10;
  //Main physic object -> our game world
  World world;
  //Zero vector -> no gravity
  final Vector2 _gravity = Vector2.zero();
  //Scale factore for our world
  final int scale = 5;
  //Size of the screen from the resize event
  Size screenSize;
  //Rectangle based on the size, easy to use
  Rect _screenRect;

  //Our first testing ball
  Ball player;

  //Our test wall
  Wall leftWall;
  Wall topWall;
  Wall rightWall;
  Wall bottomWall;

  MazeBallGame() {
    world = new World.withPool(
        _gravity, DefaultWorldPool(WORLD_POOL_SIZE, WORLD_POOL_CONTAINER_SIZE));
    initialize();
  }

  //Initialize all things we need, devided by things need the size and things without
  Future initialize() async {
    //Call the resize as soon as flutter is ready
    resize(await Flame.util.initialDimensions());
    //Generate our test ball at the scaled center of the screen
    player = Ball(
        this,
        scaleVectoreBy(
            offsetToVector2(_screenRect.center), screenSize.width / scale));
    //Draw a wall over the complete left side of the screen
    leftWall = Wall(
        this,
        Vector2.zero(),
        scaleVectoreBy(
            Vector2(0, screenSize.height), screenSize.width / scale));

    topWall = Wall(this, Vector2.zero(),
        scaleVectoreBy(Vector2(screenSize.width, 0), screenSize.width / scale));

    var rightStart =
        scaleVectoreBy(Vector2(_screenRect.right, 0), screenSize.width / scale);
    rightStart.sub(Vector2(Wall.wallWidth, 0));

    var rightEnd = scaleVectoreBy(Vector2(_screenRect.right, screenSize.height),
        screenSize.width / scale);
    rightEnd.sub(Vector2(Wall.wallWidth, 0));

    rightWall = Wall(this, rightStart, rightEnd);

    var bottomStart =
        scaleVectoreBy(Vector2(0, screenSize.height), screenSize.width / scale);
    bottomStart.sub(Vector2(0, Wall.wallWidth));

    var bottomEnd = scaleVectoreBy(
        Vector2(screenSize.width, screenSize.height - Wall.wallWidth),
        screenSize.width / scale);
    bottomEnd.sub(Vector2(0, Wall.wallWidth));

    rightEnd.sub(Vector2(Wall.wallWidth, 0));
    bottomWall = Wall(this, bottomStart, bottomEnd);
  }

  void resize(Size size) {
    //Store size and related rectangle
    screenSize = size;
    _screenRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    super.resize(size);
  }

  @override
  void render(Canvas canvas) {
    //If no size information -> leave
    if (screenSize == null) {
      return;
    }
    //Save the canvas and resize/scale it based on the screenSize
    canvas.save();
    canvas.scale(screenSize.width / scale);
    //Render our ball to the canvas if created
    player?.render(canvas);
    //Render the outer walls
    leftWall?.render(canvas);
    topWall?.render(canvas);
    rightWall?.render(canvas);
    bottomWall?.render(canvas);
    //Finish the canvas and restore it to the screen
    canvas.restore();
  }

  @override
  void update(double t) {
    //Run any physic related calculation
    world.stepDt(t, 100, 100);
    //Update our ball
    player?.update(t);
  }
}
