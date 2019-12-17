import 'dart:ui';

import 'package:mazeball/Elements/mazeBuilder.dart';
import 'package:mazeball/Views/base/baseView.dart';
import 'package:mazeball/Views/base/viewSwtichMessage.dart';
import 'package:mazeball/Views/viewManager.dart';

class OptionBackgroundMessage {
  int width;
  int height;

  OptionBackgroundMessage(this.width,this.height);

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
  void moveToBackground({ViewSwitchMessage message}) {
  }

  @override
  void render(Canvas c) {
    _mazeBuilder?.render(c);
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
      _mazeBuilder = MazeBuilder(
        this.viewManager.game,
        height: details.height,
        width: details.width,
      );
      _mazeBuilder.generateMaze();
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
