import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:mazeball/Elements/ball.dart';
import 'package:mazeball/Elements/wall.dart';
import 'package:mazeball/Views/base/viewSwtichMessage.dart';
import 'package:mazeball/Views/viewManager.dart';
import 'package:mazeball/helper.dart';

import 'base/baseView.dart';

class MainMenuBackground extends BaseView {
  Ball player;
  bool _initRequired = true;
  Wall leftWall;
  Wall topWall;
  Wall rightWall;
  Wall bottomWall;
  MainMenuBackground(GameView view, ViewManager viewManager)
      : super(view, viewManager);

  @override
  void moveToBackground({ViewSwitchMessage message}) {
    // TODO: implement moveToBackground
  }

  @override
  void render(Canvas c) {
    player?.render(c);
    leftWall?.render(c);
    topWall?.render(c);
    rightWall?.render(c);
    bottomWall?.render(c);
  }

  @override
  void setActive({ViewSwitchMessage message}) {
    if (_initRequired) {
      var screenSize = viewManager.game.screenSize;
      player = Ball(
          viewManager.game,
          scaleVectoreBy(
              Vector2(screenSize.width / 2, (screenSize.height / 100) * 20),
              viewManager.game.screenSize.width / viewManager.game.scale));

      leftWall = Wall(
        viewManager.game,
        Vector2.zero(),
        Vector2(0, screenSize.height),
      );

      topWall = Wall(
        viewManager.game,
        Vector2.zero(),
        Vector2(screenSize.width, 0),
      );

      var rightStart = Vector2(viewManager.game.screenRect.right, 0);
      rightStart.sub(Vector2(Wall.wallWidth, 0));

      var rightEnd =
          Vector2(viewManager.game.screenRect.right, screenSize.height);
      rightEnd.sub(Vector2(Wall.wallWidth, 0));
      rightWall = Wall(viewManager.game, rightStart, rightEnd);

      var bottomStart = Vector2(0, screenSize.height);
      bottomStart.sub(Vector2(0, Wall.wallWidth));

      var bottomEnd =
          Vector2(screenSize.width, screenSize.height - Wall.wallWidth);
      bottomEnd.sub(Vector2(0, Wall.wallWidth));

      rightEnd.sub(Vector2(Wall.wallWidth, 0));
      bottomWall = Wall(viewManager.game, bottomStart, bottomEnd);
    }
  }

  @override
  void update(double t) {
    player?.update(t);
  }
}
