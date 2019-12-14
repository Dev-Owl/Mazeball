import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
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
      //Generate our test ball at the scaled center of the screen
      player = Ball(
          viewManager.game,
          scaleVectoreBy(Vector2(Wall.wallWidth * 4, Wall.wallWidth * 4),
              viewManager.game.screenSize.width / viewManager.game.scale));
      //_generateOuterWalls();
      mazeBuilder = MazeBuilder(viewManager.game);
      mazeBuilder.generateMaze();
    }
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
