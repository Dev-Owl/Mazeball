import 'dart:ui';
import 'package:mazeball/Views/base/baseView.dart';
import 'package:mazeball/Views/mainMenuBackground.dart';
import 'package:mazeball/Views/optionBackground.dart';
import 'package:mazeball/Views/playingView.dart';
import 'package:mazeball/game.dart';
import 'base/viewSwtichMessage.dart';

class ViewManager {
  List<BaseView> views;
  final MazeBallGame game;
  BaseView get activeView =>
      views.firstWhere((view) => view.active, orElse: () {
        return null;
      });

  ViewManager(this.game) {
    _generateViews();
  }

  void _generateViews() {
    if (views == null) {
      views = List();
      views.add(PlayingView(GameView.Playing, this));
      views.add(MainMenuBackground(GameView.MainMenuBackground, this));
      views.add(OptionBackgroundView(GameView.Options, this));
    }
  }

  void changeView(GameView nextView,{ViewSwitchMessage message}) {
    activeView?.moveToBackground(message: message);
    var nextActiveView =
        views.firstWhere((view) => view.view == nextView, orElse: () {
      return null;
    });
    nextActiveView?.setActive(message: message);
    activeView?.active = false;
    nextActiveView?.active = true;
  }

  void render(Canvas c) {
    activeView?.render(c);
  }

  void update(double t) {
    activeView?.update(t);
  }
}