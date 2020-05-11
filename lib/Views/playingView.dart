import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:flutter/gestures.dart';
import 'package:mazeball/Elements/ball.dart';
import 'package:mazeball/Elements/mazeBuilder.dart';
import 'package:mazeball/Elements/wall.dart';
import 'package:mazeball/Views/base/baseView.dart';
import 'package:mazeball/Views/viewManager.dart';
import 'package:mazeball/helper.dart';
import 'package:mazeball/main.dart';
import 'base/viewSwtichMessage.dart';

class PlayingView extends BaseView {
  Ball player;
  bool _initRequired = true;

  MazeBuilder mazeBuilder;

  PlayingView(GameView view, ViewManager viewManager)
      : super(view, viewManager);

  @override
  void setActive({ViewSwitchMessage message}) {
    if (_initRequired) {
      _initRequired = false;
      final panGestureRecognizer = PanGestureRecognizer();
      panGestureRecognizer.onEnd = swipeEnded;
      flameUtil.addGestureRecognizer(panGestureRecognizer);
      //Generate our test ball at the scaled center of the screen
      player = Ball(
          viewManager.game,
          scaleVectoreBy(Vector2(Wall.wallWidth * 4, Wall.wallWidth * 4),
              viewManager.game.screenSize.width / viewManager.game.scale));
      initMaze();
    }
  }

  void swipeEnded(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx.abs() >
        details.velocity.pixelsPerSecond.dy.abs()) {
      if (details.velocity.pixelsPerSecond.dx < 0) {
        //Left swipe
        player.acceleration = Vector2(-3,0);
       
      } else {
        //Right swipe
        player.acceleration = Vector2(3,0);
      }
    } else {
      // Y Axis
      if (details.velocity.pixelsPerSecond.dy < 0) {
        //Swiping up
        player.acceleration = Vector2(0,-3);
      } else {
        //Swiping down
        player.acceleration = Vector2(0,3);
      }
    }
  }

  void initMaze() {
    var savedHeight = sharedPrefs.getInt("maze_height") ?? 8;
    var savedWidth = sharedPrefs.getInt("maze_width") ?? 8;
    mazeBuilder = MazeBuilder(
      this.viewManager.game,
      height: savedHeight,
      width: savedWidth,
    );
    mazeBuilder.generateMaze();
  }

  @override
  void moveToBackground({ViewSwitchMessage message}) {
    // TODO: implement moveToBackground
  }

  @override
  void render(Canvas c) {
    player?.render(c);
    mazeBuilder?.render(c);
  }

  @override
  void update(double t) {
    player?.update(t);
  }
}
