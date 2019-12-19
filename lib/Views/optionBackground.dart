import 'dart:ui';

import 'package:mazeball/Elements/mazeBuilder.dart';
import 'package:mazeball/Views/base/baseView.dart';
import 'package:mazeball/Views/base/viewSwtichMessage.dart';
import 'package:mazeball/Views/viewManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class OptionBackgroundMessage {
  int width;
  int height;

  OptionBackgroundMessage(this.width, this.height);

  OptionBackgroundMessage.eightByEight() {
    width = 8;
    height = 8;
  }
}

class OptionBackgroundView extends BaseView {
  bool initRequired = true;
  MazeBuilder _mazeBuilder;
  OptionBackgroundView(GameView view, ViewManager viewManager)
      : super(view, viewManager);

  @override
  void moveToBackground({ViewSwitchMessage message}) {}

  @override
  void render(Canvas c) {
    _mazeBuilder?.render(c);
  }

  void initMaze() {
    var savedHeight = sharedPrefs.getInt("maze_height") ?? 8;
    var savedWidth = sharedPrefs.getInt("maze_width") ?? 8;
    _mazeBuilder = MazeBuilder(
      this.viewManager.game,
      height: savedHeight,
      width: savedWidth,
    );
    _mazeBuilder.generateMaze();
  }

  @override
  void setActive({ViewSwitchMessage message}) {
    OptionBackgroundMessage details;
    if (message?.userData is OptionBackgroundMessage) {
      details = (message.userData as OptionBackgroundMessage);
    } else {
      details = OptionBackgroundMessage.eightByEight();
    }

    if (initRequired) {
      initRequired = false;
      initMaze();
    } else {
      _mazeBuilder.resetMaze(
        width: details.width,
        height: details.height,
      );
    }
  }

  @override
  void update(double t) {
    // Nothing to do here ...
  }
}
